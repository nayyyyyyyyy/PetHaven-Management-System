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

@WebServlet("/my-favourites")
public class FavouriteServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("currentUser");
        UserDAO dao = new UserDAO();
        request.setAttribute("favourites", dao.getFavouritesByUser(user.getUserId()));
        request.getRequestDispatcher("/WEB-INF/pages/my-favourites.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("currentUser");
        int petId = Integer.parseInt(request.getParameter("petId"));
        String action = request.getParameter("action");
        UserDAO dao = new UserDAO();
        if ("remove".equals(action)) {
            dao.removeFavourite(user.getUserId(), petId);
        } else {
            dao.addFavourite(user.getUserId(), petId);
        }
        response.sendRedirect(request.getContextPath() + "/my-favourites");
    }
}
