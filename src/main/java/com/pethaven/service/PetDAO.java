package com.pethaven.service;

import com.pethaven.model.Pet;
import com.pethaven.utils.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;

public class PetDAO {

    public ArrayList<Pet> getAllPets() {
        ArrayList<Pet> list = new ArrayList<>();
        String sql = "SELECT * FROM pets";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Pet p = new Pet();
                p.setPetId(rs.getInt("pet_id"));
                p.setName(rs.getString("name"));
                p.setAge(rs.getInt("age"));
                p.setBreed(rs.getString("breed"));
                p.setType(rs.getString("type"));
                p.setGender(rs.getString("gender"));
                p.setStatus(rs.getString("status"));
                p.setDescription(rs.getString("description"));
                p.setImageUrl(rs.getString("image_url"));
                p.setAddedBy(rs.getInt("added_by"));
                list.add(p);
            }
            System.out.println("✅ Successfully loaded " + list.size() + " pets from database");
        } catch (SQLException e) { 
            System.err.println("❌ ERROR loading pets from database:");
            e.printStackTrace(); 
        }
        return list;
    }

    public boolean addPet(Pet pet) {
        String sql = "INSERT INTO pets (name, age, breed, type, gender, status, description, image_url, added_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, pet.getName());
            ps.setInt(2, pet.getAge());
            ps.setString(3, pet.getBreed() != null ? pet.getBreed() : "");
            ps.setString(4, pet.getType() != null ? pet.getType() : "");
            ps.setString(5, pet.getGender() != null ? pet.getGender() : "");
            ps.setString(6, pet.getStatus() != null ? pet.getStatus() : "Available");
            ps.setString(7, pet.getDescription() != null ? pet.getDescription() : "");
            ps.setString(8, pet.getImageUrl());
            ps.setInt(9, pet.getAddedBy());
            boolean result = ps.executeUpdate() > 0;
            System.out.println(result ? "✅ Pet added: " + pet.getName() : "❌ Failed to add pet: " + pet.getName());
            return result;
        } catch (SQLException e) { 
            System.err.println("❌ ERROR adding pet: " + pet.getName());
            e.printStackTrace(); 
            return false; 
        }
    }

    public boolean deletePet(int id) {
        String sql = "DELETE FROM pets WHERE pet_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean updatePet(Pet pet) {
        String sql = "UPDATE pets SET name=?, age=?, breed=?, type=?, gender=?, image_url=? WHERE pet_id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, pet.getName());
            ps.setInt(2, pet.getAge());
            ps.setString(3, pet.getBreed() != null ? pet.getBreed() : "");
            ps.setString(4, pet.getType() != null ? pet.getType() : "");
            ps.setString(5, pet.getGender() != null ? pet.getGender() : "");
            ps.setString(6, pet.getImageUrl());
            ps.setInt(7, pet.getPetId());
            boolean result = ps.executeUpdate() > 0;
            System.out.println(result ? "✅ Pet updated: " + pet.getName() : "❌ Failed to update pet: " + pet.getName());
            return result;
        } catch (SQLException e) { 
            System.err.println("❌ ERROR updating pet: " + pet.getName());
            e.printStackTrace(); return false; 
        }
    }

    public boolean updatePetStatus(int id, String status) {
        String sql = "UPDATE pets SET status = ? WHERE pet_id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
}