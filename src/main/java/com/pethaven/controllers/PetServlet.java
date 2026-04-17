package com.pethaven.controllers;

import com.pethaven.model.Pet;
import com.pethaven.service.PetDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/manage-pets")
public class PetServlet extends HttpServlet {
    private PetDAO petDAO = new PetDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Pet> petList = petDAO.getAllPets();
        request.setAttribute("petList", petList);
        request.getRequestDispatcher("/WEB-INF/pages/pet-list.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String formAction = request.getParameter("formAction");
        
        if ("add".equals(formAction)) {
            Pet p = new Pet();
            p.setName(request.getParameter("name"));
            String ageStr = request.getParameter("age");
            p.setAge((ageStr != null && !ageStr.trim().isEmpty()) ? Integer.parseInt(ageStr) : 0);
            p.setBreed(request.getParameter("breed"));
            p.setType(request.getParameter("type"));
            p.setGender(request.getParameter("gender"));
            p.setImageUrl(request.getParameter("imageUrl"));
            p.setStatus("Available");
            p.setAddedBy(1);
            petDAO.addPet(p);
        } else if ("edit".equals(formAction)) {
            Pet p = new Pet();
            p.setPetId(Integer.parseInt(request.getParameter("petId")));
            p.setName(request.getParameter("name"));
            String ageStr2 = request.getParameter("age");
            p.setAge((ageStr2 != null && !ageStr2.trim().isEmpty()) ? Integer.parseInt(ageStr2) : 0);
            p.setBreed(request.getParameter("breed"));
            p.setType(request.getParameter("type"));
            p.setGender(request.getParameter("gender"));
            p.setImageUrl(request.getParameter("imageUrl"));
            petDAO.updatePet(p);
        } else if ("delete".equals(formAction)) {
            int id = Integer.parseInt(request.getParameter("petId"));
            petDAO.deletePet(id);
        } else if ("update".equals(formAction)) {
            int id = Integer.parseInt(request.getParameter("petId"));
            String status = request.getParameter("status");
            petDAO.updatePetStatus(id, status);
        }
        
        response.sendRedirect(request.getContextPath() + "/manage-pets");
    }
}