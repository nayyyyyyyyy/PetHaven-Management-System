package com.pethaven.controllers;

import com.pethaven.config.DBConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirmPassword");

        // Basic validation
        if (fullName == null || username == null || email == null || password == null
                || fullName.trim().isEmpty() || username.trim().isEmpty()
                || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirm)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConfig.getConnection()) {
            // Check username taken
            PreparedStatement check = conn.prepareStatement("SELECT 1 FROM users WHERE username = ?");
            check.setString(1, username.trim());
            ResultSet rs = check.executeQuery();
            if (rs.next()) {
                request.setAttribute("error", "Username already taken. Please choose another.");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
                return;
            }

            // Insert new user with role USER
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO users (full_name, username, email, password, role) VALUES (?, ?, ?, ?, 'USER')"
            );
            ps.setString(1, fullName.trim());
            ps.setString(2, username.trim());
            ps.setString(3, email.trim());
            ps.setString(4, password);
            ps.executeUpdate();

            request.setAttribute("success", "Account created! You can now log in.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error. Please try again.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }
}
