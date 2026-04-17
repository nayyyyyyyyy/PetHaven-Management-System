package com.pethaven.controllers;

import com.pethaven.model.User;
import com.pethaven.model.Visit;
import com.pethaven.service.PetDAO;
import com.pethaven.service.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/my-visits")
public class VisitServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("currentUser");
        UserDAO dao = new UserDAO();
        request.setAttribute("visits", dao.getVisitsByUser(user.getUserId()));
        request.setAttribute("pets", new PetDAO().getAllPets());
        request.getRequestDispatcher("/WEB-INF/pages/my-visits.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("currentUser");
        Visit visit = new Visit();
        visit.setUserId(user.getUserId());
        visit.setPetId(Integer.parseInt(request.getParameter("petId")));
        visit.setVisitDate(request.getParameter("visitDate"));
        visit.setVisitTime(request.getParameter("visitTime"));
        visit.setNotes(request.getParameter("notes"));
        new UserDAO().scheduleVisit(visit);
        response.sendRedirect(request.getContextPath() + "/my-visits");
    }
}
