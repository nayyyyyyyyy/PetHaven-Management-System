package com.pethaven.service;

// SERVICE LAYER: Data Access Object (DAO) for the Pet entity.
// This class handles all database interactions for pets — it is the only
// place in the app that runs SQL against the 'pets' table.
//
// SECURITY NOTE: Every SQL statement uses PreparedStatement — never raw
// string concatenation — to prevent SQL Injection attacks.
// All DB resources (Connection, PreparedStatement, ResultSet) are opened
// inside try-with-resources blocks so they close automatically, even on error.

import com.pethaven.config.DBConfig;
import com.pethaven.model.Pet;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PetDAO {

    // ─── READ ALL ────────────────────────────────────────────────────────────
    // Fetches every pet from the database and returns them as an ArrayList.
    // Used by the dashboard and pet-list page to display the full registry.
    public List<Pet> getAllPets() {
        List<Pet> list = new ArrayList<>();
        String sql = "SELECT * FROM pets ORDER BY pet_id DESC";

        // DATABASE PERSISTENCE: try-with-resources ensures Connection and
        // PreparedStatement are closed automatically after the block exits.
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs)); // delegate row-to-object mapping to helper
            }

        } catch (SQLException e) {
            // Log to server console — never expose raw SQL errors to the browser
            System.err.println("[PetDAO] Error loading all pets: " + e.getMessage());
        }
        return list;
    }

    // ─── READ BY ID ──────────────────────────────────────────────────────────
    // Retrieves a single pet by its primary key. Returns null if not found.
    public Pet getPetById(int id) {
        String sql = "SELECT * FROM pets WHERE pet_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // DATABASE PERSISTENCE: Using PreparedStatement to maintain strict data security boundaries
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }

        } catch (SQLException e) {
            System.err.println("[PetDAO] Error fetching pet id=" + id + ": " + e.getMessage());
        }
        return null; // not found — caller should handle null gracefully
    }

    // ─── CREATE ──────────────────────────────────────────────────────────────
    // Inserts a new pet record into the database.
    // Returns true if the INSERT affected at least one row, false otherwise.
    public boolean addPet(Pet pet) {
        String sql = "INSERT INTO pets (name, age, breed, type, gender, status, description, image_url, added_by) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // DATABASE PERSISTENCE: Using PreparedStatement to maintain strict data security boundaries
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, pet.getName());
            ps.setInt   (2, pet.getAge());
            ps.setString(3, pet.getBreed()       != null ? pet.getBreed()       : "");
            ps.setString(4, pet.getType()        != null ? pet.getType()        : "");
            ps.setString(5, pet.getGender()      != null ? pet.getGender()      : "");
            ps.setString(6, pet.getStatus()      != null ? pet.getStatus()      : "Available");
            ps.setString(7, pet.getDescription() != null ? pet.getDescription() : "");
            ps.setString(8, pet.getImageUrl());   // can be null — DB column allows NULL
            ps.setInt   (9, pet.getAddedBy());

            boolean success = ps.executeUpdate() > 0;
            System.out.println("[PetDAO] addPet '" + pet.getName() + "' → " + (success ? "OK" : "FAILED"));
            return success;

        } catch (SQLException e) {
            System.err.println("[PetDAO] Error adding pet '" + pet.getName() + "': " + e.getMessage());
            return false;
        }
    }

    // ─── UPDATE ──────────────────────────────────────────────────────────────
    // Updates the editable fields of an existing pet record.
    public boolean updatePet(Pet pet) {
        String sql = "UPDATE pets SET name=?, age=?, breed=?, type=?, gender=?, image_url=? "
                   + "WHERE pet_id=?";

        // DATABASE PERSISTENCE: Using PreparedStatement to maintain strict data security boundaries
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, pet.getName());
            ps.setInt   (2, pet.getAge());
            ps.setString(3, pet.getBreed()  != null ? pet.getBreed()  : "");
            ps.setString(4, pet.getType()   != null ? pet.getType()   : "");
            ps.setString(5, pet.getGender() != null ? pet.getGender() : "");
            ps.setString(6, pet.getImageUrl());
            ps.setInt   (7, pet.getPetId());

            boolean success = ps.executeUpdate() > 0;
            System.out.println("[PetDAO] updatePet id=" + pet.getPetId() + " → " + (success ? "OK" : "FAILED"));
            return success;

        } catch (SQLException e) {
            System.err.println("[PetDAO] Error updating pet id=" + pet.getPetId() + ": " + e.getMessage());
            return false;
        }
    }

    // ─── UPDATE STATUS ONLY ──────────────────────────────────────────────────
    // Quick status toggle (Available ↔ Adopted) without touching other fields.
    public boolean updatePetStatus(int id, String status) {
        String sql = "UPDATE pets SET status = ? WHERE pet_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt   (2, id);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("[PetDAO] Error updating status for pet id=" + id + ": " + e.getMessage());
            return false;
        }
    }

    // ─── DELETE ──────────────────────────────────────────────────────────────
    // Permanently removes a pet record by its primary key.
    public boolean deletePet(int id) {
        String sql = "DELETE FROM pets WHERE pet_id = ?";

        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            boolean success = ps.executeUpdate() > 0;
            System.out.println("[PetDAO] deletePet id=" + id + " → " + (success ? "OK" : "NOT FOUND"));
            return success;

        } catch (SQLException e) {
            System.err.println("[PetDAO] Error deleting pet id=" + id + ": " + e.getMessage());
            return false;
        }
    }

    // ─── ROW MAPPER ──────────────────────────────────────────────────────────
    // Private helper: converts a single ResultSet row into a Pet object.
    // Centralising this avoids duplicating rs.getString("name") etc. everywhere.
    private Pet mapRow(ResultSet rs) throws SQLException {
        Pet p = new Pet();
        p.setPetId      (rs.getInt   ("pet_id"));
        p.setName       (rs.getString("name"));
        p.setAge        (rs.getInt   ("age"));
        p.setBreed      (rs.getString("breed"));
        p.setType       (rs.getString("type"));
        p.setGender     (rs.getString("gender"));
        p.setStatus     (rs.getString("status"));
        p.setDescription(rs.getString("description"));
        p.setImageUrl   (rs.getString("image_url"));
        p.setAddedBy    (rs.getInt   ("added_by"));
        return p;
    }
}
