package com.pethaven.controllers;

import com.pethaven.model.User;
import com.pethaven.service.PetDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/browse-pets")
public class BrowsePetsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        PetDAO dao = new PetDAO();
        request.setAttribute("pets", dao.getAllPets());
        request.getRequestDispatcher("/WEB-INF/pages/browse-pets.jsp").forward(request, response);
    }
}
