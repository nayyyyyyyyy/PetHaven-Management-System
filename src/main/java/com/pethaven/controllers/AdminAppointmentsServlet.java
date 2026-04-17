package com.pethaven.controllers;

import com.pethaven.config.DBConfig;
import com.pethaven.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin-appointments")
public class AdminAppointmentsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("currentUser");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dashboard");
            return;
        }

        List<Map<String, String>> appointments = new ArrayList<>();
        String sql = "SELECT v.visit_id, u.full_name, p.name AS pet_name, p.type AS pet_type, " +
                     "v.visit_date, v.visit_time, v.status, v.notes " +
                     "FROM visits v JOIN users u ON v.user_id = u.user_id " +
                     "JOIN pets p ON v.pet_id = p.pet_id ORDER BY v.visit_date DESC";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Map<String, String> row = new HashMap<>();
                row.put("visitId", rs.getString("visit_id"));
                row.put("userName", rs.getString("full_name"));
                row.put("petName", rs.getString("pet_name"));
                row.put("petType", rs.getString("pet_type"));
                row.put("visitDate", rs.getString("visit_date"));
                row.put("visitTime", rs.getString("visit_time"));
                row.put("status", rs.getString("status"));
                row.put("notes", rs.getString("notes") != null ? rs.getString("notes") : "-");
                appointments.add(row);
            }
        } catch (SQLException e) { e.printStackTrace(); }

        request.setAttribute("appointments", appointments);
        request.getRequestDispatcher("/WEB-INF/pages/admin-appointments.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        int visitId = Integer.parseInt(request.getParameter("visitId"));
        String status = request.getParameter("status");
        String sql = "UPDATE visits SET status = ? WHERE visit_id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, visitId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
        response.sendRedirect(request.getContextPath() + "/admin-appointments");
    }
}
