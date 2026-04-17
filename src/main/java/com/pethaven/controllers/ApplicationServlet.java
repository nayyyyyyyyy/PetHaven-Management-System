package com.pethaven.controllers;

import com.pethaven.model.User;
import com.pethaven.service.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/my-applications")
public class ApplicationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("currentUser");
        UserDAO dao = new UserDAO();
        request.setAttribute("applications", dao.getApplicationsByUser(user.getUserId()));
        request.getRequestDispatcher("/WEB-INF/pages/my-applications.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("currentUser");
        int petId = Integer.parseInt(request.getParameter("petId"));
        UserDAO dao = new UserDAO();
        boolean success = dao.applyForPet(user.getUserId(), petId);
        request.setAttribute("message", success ? "Application submitted!" : "You already applied for this pet.");
        request.setAttribute("pets", new com.pethaven.service.PetDAO().getAllPets());
        request.getRequestDispatcher("/WEB-INF/pages/browse-pets.jsp").forward(request, response);
    }
}
