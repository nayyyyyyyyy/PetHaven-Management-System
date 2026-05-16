package com.pethaven.controllers;

// CONTROLLER LAYER: RegisterServlet — handles new user account creation.
// Mapped to '/register' via @WebServlet annotation.
//
// doGet  → Forwards to the registration form (hidden in WEB-INF).
// doPost → Validates input, checks for duplicate usernames, and creates new USER accounts.

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

    // ─── doGet ───────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ROUTING CHECK: Using doGet to forward to hidden WEB-INF/pages as required by guidelines.
        // The register.jsp file is secured inside WEB-INF so it cannot be accessed directly.
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }

    // ─── doPost ──────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read form inputs
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirmPassword");

        // ── VALIDATION BLOCK ─────────────────────────────────────────────────
        // INPUT VALIDATION: Check for empty/null strings before touching the database.
        // Blank submissions would insert garbage rows — we catch them here instead.
        if (fullName == null || username == null || email == null || password == null
                || fullName.trim().isEmpty() || username.trim().isEmpty()
                || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required — please fill in the entire form.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        // BOUNDARY CONDITION: Password mismatch check
        if (!password.equals(confirm)) {
            request.setAttribute("error", "Passwords do not match — please re-enter carefully.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        // BOUNDARY CONDITION: Password length check
        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters long.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }
        // ── END VALIDATION ───────────────────────────────────────────────────

        // EXCEPTION HANDLING: Wrapping database operations in try-catch to intercept
        // SQLException and prevent raw 500 error pages from showing to users.
        try (Connection conn = DBConfig.getConnection()) {

            // Check if username is already taken
            // DATABASE PERSISTENCE: Using PreparedStatement to maintain strict data security boundaries
            PreparedStatement check = conn.prepareStatement("SELECT 1 FROM users WHERE username = ?");
            check.setString(1, username.trim());
            ResultSet rs = check.executeQuery();

            // BOUNDARY CONDITION: Username already exists — reject registration
            if (rs.next()) {
                request.setAttribute("error", "Username already taken — please choose another.");
                request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
                return;
            }

            // Insert new user with role 'USER' (not 'ADMIN')
            // DATABASE PERSISTENCE: Using PreparedStatement to maintain strict data security boundaries
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO users (full_name, username, email, password, role) VALUES (?, ?, ?, ?, 'USER')"
            );
            ps.setString(1, fullName.trim());
            ps.setString(2, username.trim());
            ps.setString(3, email.trim());
            ps.setString(4, password);  // In production, this should be hashed (e.g., BCrypt)
            ps.executeUpdate();

            // SUCCESS: Account created — redirect to login with success message
            request.setAttribute("success", "Account created successfully! You can now log in.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);

        } catch (SQLException e) {
            // EXCEPTION HANDLING: SQLException caught — returning user-friendly error
            // instead of letting the server throw a 500 page with a raw stack trace.
            // Log the real error server-side — never expose SQL details to the browser
            System.err.println("[RegisterServlet] Database error during registration: " + e.getMessage());
            request.setAttribute("error", "Database error occurred — please try again later.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }
}
