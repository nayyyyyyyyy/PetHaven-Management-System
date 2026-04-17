package com.pethaven.service;

import com.pethaven.config.DBConfig;
import com.pethaven.model.Application;
import com.pethaven.model.Favourite;
import com.pethaven.model.Visit;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // ── APPLICATIONS ──────────────────────────────────────────────────────────

    public boolean applyForPet(int userId, int petId) {
        String check = "SELECT 1 FROM applications WHERE user_id=? AND pet_id=?";
        String insert = "INSERT INTO applications (user_id, pet_id) VALUES (?, ?)";
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(check);
            ps.setInt(1, userId); ps.setInt(2, petId);
            if (ps.executeQuery().next()) return false; // already applied
            ps = conn.prepareStatement(insert);
            ps.setInt(1, userId); ps.setInt(2, petId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Application> getApplicationsByUser(int userId) {
        List<Application> list = new ArrayList<>();
        String sql = "SELECT a.*, p.name AS pet_name, p.type AS pet_type, p.breed AS pet_breed " +
                     "FROM applications a JOIN pets p ON a.pet_id = p.pet_id WHERE a.user_id = ? ORDER BY a.applied_at DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("application_id"));
                app.setUserId(rs.getInt("user_id"));
                app.setPetId(rs.getInt("pet_id"));
                app.setStatus(rs.getString("status"));
                app.setAppliedAt(rs.getString("applied_at"));
                app.setPetName(rs.getString("pet_name"));
                app.setPetType(rs.getString("pet_type"));
                app.setPetBreed(rs.getString("pet_breed"));
                list.add(app);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public int countApplicationsByUser(int userId) {
        String sql = "SELECT COUNT(*) FROM applications WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // ── FAVOURITES ────────────────────────────────────────────────────────────

    public boolean addFavourite(int userId, int petId) {
        String sql = "INSERT IGNORE INTO favourites (user_id, pet_id) VALUES (?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId); ps.setInt(2, petId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public boolean removeFavourite(int userId, int petId) {
        String sql = "DELETE FROM favourites WHERE user_id=? AND pet_id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId); ps.setInt(2, petId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Favourite> getFavouritesByUser(int userId) {
        List<Favourite> list = new ArrayList<>();
        String sql = "SELECT f.*, p.name AS pet_name, p.type AS pet_type, p.breed AS pet_breed, p.status AS pet_status, p.image_url AS pet_image_url " +
                     "FROM favourites f JOIN pets p ON f.pet_id = p.pet_id WHERE f.user_id = ? ORDER BY f.added_at DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Favourite fav = new Favourite();
                fav.setFavouriteId(rs.getInt("favourite_id"));
                fav.setUserId(rs.getInt("user_id"));
                fav.setPetId(rs.getInt("pet_id"));
                fav.setAddedAt(rs.getString("added_at"));
                fav.setPetName(rs.getString("pet_name"));
                fav.setPetType(rs.getString("pet_type"));
                fav.setPetBreed(rs.getString("pet_breed"));
                fav.setPetStatus(rs.getString("pet_status"));
                fav.setPetImageUrl(rs.getString("pet_image_url"));
                list.add(fav);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public int countFavouritesByUser(int userId) {
        String sql = "SELECT COUNT(*) FROM favourites WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    // ── VISITS ────────────────────────────────────────────────────────────────

    public boolean scheduleVisit(Visit visit) {
        String sql = "INSERT INTO visits (user_id, pet_id, visit_date, visit_time, notes) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, visit.getUserId());
            ps.setInt(2, visit.getPetId());
            ps.setString(3, visit.getVisitDate());
            ps.setString(4, visit.getVisitTime());
            ps.setString(5, visit.getNotes());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    public List<Visit> getVisitsByUser(int userId) {
        List<Visit> list = new ArrayList<>();
        String sql = "SELECT v.*, p.name AS pet_name, p.type AS pet_type " +
                     "FROM visits v JOIN pets p ON v.pet_id = p.pet_id WHERE v.user_id = ? ORDER BY v.visit_date DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Visit v = new Visit();
                v.setVisitId(rs.getInt("visit_id"));
                v.setUserId(rs.getInt("user_id"));
                v.setPetId(rs.getInt("pet_id"));
                v.setVisitDate(rs.getString("visit_date"));
                v.setVisitTime(rs.getString("visit_time"));
                v.setStatus(rs.getString("status"));
                v.setNotes(rs.getString("notes"));
                v.setPetName(rs.getString("pet_name"));
                v.setPetType(rs.getString("pet_type"));
                list.add(v);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public int countVisitsByUser(int userId) {
        String sql = "SELECT COUNT(*) FROM visits WHERE user_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }
}
