package com.pethaven.controllers;

// CONTROLLER LAYER: PetServlet — handles CRUD operations for the pet management page.
// Mapped to '/manage-pets' via @WebServlet annotation.
//
// doGet  → Loads all pets and forwards to the hidden WEB-INF view.
// doPost → Processes add/edit/delete/update actions with proper validation.

import com.pethaven.model.Pet;
import com.pethaven.model.User;
import com.pethaven.service.PetDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/manage-pets")
public class PetServlet extends HttpServlet {
    private PetDAO petDAO = new PetDAO();

    // ─── doGet ───────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ROUTING CHECK: Using doGet to forward to hidden WEB-INF/pages as required by guidelines.
        // The pet-list.jsp file is secured inside WEB-INF so it cannot be accessed directly.

        // SESSION GUARD: Redirect unauthenticated users to login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Load all pets from database and make them available to the view
        List<Pet> petList = petDAO.getAllPets();
        request.setAttribute("petList", petList);

        // SECURE FORWARD: Forwarding to the JSP hidden inside WEB-INF
        request.getRequestDispatcher("/WEB-INF/pages/pet-list.jsp").forward(request, response);
    }

    // ─── doPost ──────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // SESSION GUARD: Same check as doGet — no unauthenticated POST processing
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");
        String formAction = request.getParameter("formAction");

        // ── EXCEPTION HANDLING WRAPPER ───────────────────────────────────────
        // EXCEPTION HANDLING: Wrapping all parseInt() calls in try-catch to intercept
        // NumberFormatException and prevent raw 500 error pages from showing to users.
        try {

            if ("add".equals(formAction)) {
                // ── ADD NEW PET ──────────────────────────────────────────────
                Pet p = new Pet();
                p.setName(request.getParameter("name"));

                // EXCEPTION HANDLING: Intercepting NumberFormatException here to block raw app failure pages.
                // If someone types "abc" into the age field, parseInt() would crash without this try-catch.
                String ageStr = request.getParameter("age");
                int age = 0;
                if (ageStr != null && !ageStr.trim().isEmpty()) {
                    age = Integer.parseInt(ageStr.trim());
                    // Boundary check: age should be realistic
                    if (age < 0 || age > 100) {
                        request.setAttribute("errorMessage", "Invalid age — must be between 0 and 100.");
                        doGet(request, response);  // Reload page with error
                        return;
                    }
                }
                p.setAge(age);
                p.setBreed(request.getParameter("breed"));
                p.setType(request.getParameter("type"));
                p.setGender(request.getParameter("gender"));
                p.setImageUrl(request.getParameter("imageUrl"));
                p.setStatus("Available");
                p.setAddedBy(currentUser.getUserId());

                // DATABASE PERSISTENCE: Using PetDAO which internally uses PreparedStatement
                petDAO.addPet(p);

            } else if ("edit".equals(formAction)) {
                // ── EDIT EXISTING PET ────────────────────────────────────────
                Pet p = new Pet();

                // EXCEPTION HANDLING: Intercepting NumberFormatException for petId parsing
                String petIdStr = request.getParameter("petId");
                if (petIdStr == null || petIdStr.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Pet ID is missing — cannot update.");
                    doGet(request, response);
                    return;
                }
                p.setPetId(Integer.parseInt(petIdStr.trim()));

                p.setName(request.getParameter("name"));

                // EXCEPTION HANDLING: Intercepting NumberFormatException for age parsing
                String ageStr2 = request.getParameter("age");
                int age2 = 0;
                if (ageStr2 != null && !ageStr2.trim().isEmpty()) {
                    age2 = Integer.parseInt(ageStr2.trim());
                    if (age2 < 0 || age2 > 100) {
                        request.setAttribute("errorMessage", "Invalid age — must be between 0 and 100.");
                        doGet(request, response);
                        return;
                    }
                }
                p.setAge(age2);
                p.setBreed(request.getParameter("breed"));
                p.setType(request.getParameter("type"));
                p.setGender(request.getParameter("gender"));
                p.setImageUrl(request.getParameter("imageUrl"));

                // DATABASE PERSISTENCE: Using PetDAO which internally uses PreparedStatement
                petDAO.updatePet(p);

            } else if ("delete".equals(formAction)) {
                // ── DELETE PET ───────────────────────────────────────────────
                // EXCEPTION HANDLING: Intercepting NumberFormatException for petId parsing
                String petIdStr = request.getParameter("petId");
                if (petIdStr == null || petIdStr.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Pet ID is missing — cannot delete.");
                    doGet(request, response);
                    return;
                }
                int id = Integer.parseInt(petIdStr.trim());

                // DATABASE PERSISTENCE: Using PetDAO which internally uses PreparedStatement
                petDAO.deletePet(id);

            } else if ("update".equals(formAction)) {
                // ── UPDATE STATUS ONLY ───────────────────────────────────────
                // EXCEPTION HANDLING: Intercepting NumberFormatException for petId parsing
                String petIdStr = request.getParameter("petId");
                if (petIdStr == null || petIdStr.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Pet ID is missing — cannot update status.");
                    doGet(request, response);
                    return;
                }
                int id = Integer.parseInt(petIdStr.trim());
                String status = request.getParameter("status");

                // DATABASE PERSISTENCE: Using PetDAO which internally uses PreparedStatement
                petDAO.updatePetStatus(id, status);
            }

        } catch (NumberFormatException e) {
            // EXCEPTION HANDLING: NumberFormatException caught — returning user-friendly error
            // instead of letting the server throw a 500 page with a raw stack trace.
            // This happens when someone types text into a numeric field (age, petId, etc.)
            request.setAttribute("errorMessage",
                "Invalid input format — Numeric fields must contain only numbers, not letters or symbols.");
            doGet(request, response);  // Reload page with error message
            return;
        }
        // ── END EXCEPTION HANDLING ───────────────────────────────────────────

        // SUCCESS: Redirect back to the manage-pets page to show updated list
        response.sendRedirect(request.getContextPath() + "/manage-pets");
    }
}