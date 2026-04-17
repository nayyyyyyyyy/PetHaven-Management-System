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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("currentUser");

        if ("USER".equals(user.getRole())) {
            UserDAO dao = new UserDAO();
            int uid = user.getUserId();
            request.setAttribute("appCount",   dao.countApplicationsByUser(uid));
            request.setAttribute("favCount",   dao.countFavouritesByUser(uid));
            request.setAttribute("visitCount", dao.countVisitsByUser(uid));

            // Recent available pets for user dashboard preview
            try (Connection conn = com.pethaven.config.DBConfig.getConnection()) {
                PreparedStatement ps = conn.prepareStatement(
                    "SELECT pet_id, name, type, breed, age, gender, status, image_url FROM pets WHERE status='Available' ORDER BY pet_id DESC LIMIT 4");
                ResultSet rs = ps.executeQuery();
                java.util.List<com.pethaven.model.Pet> recentPets = new java.util.ArrayList<>();
                while (rs.next()) {
                    com.pethaven.model.Pet p = new com.pethaven.model.Pet();
                    p.setPetId(rs.getInt("pet_id"));
                    p.setName(rs.getString("name"));
                    p.setType(rs.getString("type"));
                    p.setBreed(rs.getString("breed"));
                    p.setAge(rs.getInt("age"));
                    p.setGender(rs.getString("gender"));
                    p.setStatus(rs.getString("status"));
                    p.setImageUrl(rs.getString("image_url"));
                    recentPets.add(p);
                }
                request.setAttribute("recentPets", recentPets);
            } catch (SQLException e) { e.printStackTrace(); }

            request.getRequestDispatcher("/WEB-INF/pages/user-dashboard.jsp").forward(request, response);

        } else {
            // Admin — load stats + chart data
            try (Connection conn = com.pethaven.config.DBConfig.getConnection()) {

                // Stat counts
                ResultSet rs = conn.prepareStatement("SELECT COUNT(*) FROM pets").executeQuery();
                if (rs.next()) request.setAttribute("totalPets", rs.getInt(1));

                rs = conn.prepareStatement("SELECT COUNT(*) FROM pets WHERE status='Available'").executeQuery();
                if (rs.next()) request.setAttribute("availablePets", rs.getInt(1));

                rs = conn.prepareStatement("SELECT COUNT(*) FROM pets WHERE status='Adopted'").executeQuery();
                if (rs.next()) request.setAttribute("adoptedPets", rs.getInt(1));

                rs = conn.prepareStatement("SELECT COUNT(*) FROM applications WHERE status='Pending'").executeQuery();
                if (rs.next()) request.setAttribute("pendingApps", rs.getInt(1));

                rs = conn.prepareStatement("SELECT COUNT(*) FROM users WHERE role='USER'").executeQuery();
                if (rs.next()) request.setAttribute("totalUsers", rs.getInt(1));

                rs = conn.prepareStatement("SELECT COUNT(*) FROM visits WHERE status='Scheduled'").executeQuery();
                if (rs.next()) request.setAttribute("scheduledVisits", rs.getInt(1));

                // Chart 1: Pets by type (for doughnut chart)
                StringBuilder typeLabels = new StringBuilder();
                StringBuilder typeCounts = new StringBuilder();
                rs = conn.prepareStatement(
                    "SELECT COALESCE(NULLIF(type,''),'Unknown') AS t, COUNT(*) AS c FROM pets GROUP BY t ORDER BY c DESC LIMIT 6"
                ).executeQuery();
                while (rs.next()) {
                    if (typeLabels.length() > 0) { typeLabels.append(","); typeCounts.append(","); }
                    typeLabels.append("'").append(rs.getString("t").replace("'", "\\'")).append("'");
                    typeCounts.append(rs.getInt("c"));
                }
                request.setAttribute("chartTypeLabels", typeLabels.toString());
                request.setAttribute("chartTypeCounts", typeCounts.toString());

                // Chart 2: Age distribution (bar chart buckets)
                int[] ageBuckets = new int[5]; // 0-1, 2-3, 4-5, 6-8, 9+
                rs = conn.prepareStatement("SELECT age FROM pets").executeQuery();
                while (rs.next()) {
                    int age = rs.getInt("age");
                    if      (age <= 1) ageBuckets[0]++;
                    else if (age <= 3) ageBuckets[1]++;
                    else if (age <= 5) ageBuckets[2]++;
                    else if (age <= 8) ageBuckets[3]++;
                    else               ageBuckets[4]++;
                }
                request.setAttribute("ageBuckets", ageBuckets[0]+","+ageBuckets[1]+","+ageBuckets[2]+","+ageBuckets[3]+","+ageBuckets[4]);

                // Chart 3: Applications per month (last 6 months)
                StringBuilder monthLabels = new StringBuilder();
                StringBuilder monthCounts = new StringBuilder();
                rs = conn.prepareStatement(
                    "SELECT DATE_FORMAT(applied_at,'%b %Y') AS mo, COUNT(*) AS c " +
                    "FROM applications WHERE applied_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH) " +
                    "GROUP BY DATE_FORMAT(applied_at,'%Y-%m') ORDER BY MIN(applied_at)"
                ).executeQuery();
                while (rs.next()) {
                    if (monthLabels.length() > 0) { monthLabels.append(","); monthCounts.append(","); }
                    monthLabels.append("'").append(rs.getString("mo")).append("'");
                    monthCounts.append(rs.getInt("c"));
                }
                if (monthLabels.length() == 0) { monthLabels.append("'No data'"); monthCounts.append("0"); }
                request.setAttribute("chartMonthLabels", monthLabels.toString());
                request.setAttribute("chartMonthCounts", monthCounts.toString());

                // Recent applications for activity feed
                java.util.List<java.util.Map<String,String>> recentApps = new java.util.ArrayList<>();
                rs = conn.prepareStatement(
                    "SELECT u.full_name, p.name AS pet_name, a.status, a.applied_at " +
                    "FROM applications a JOIN users u ON a.user_id=u.user_id " +
                    "JOIN pets p ON a.pet_id=p.pet_id ORDER BY a.applied_at DESC LIMIT 5"
                ).executeQuery();
                while (rs.next()) {
                    java.util.Map<String,String> row = new java.util.HashMap<>();
                    row.put("userName",  rs.getString("full_name"));
                    row.put("petName",   rs.getString("pet_name"));
                    row.put("status",    rs.getString("status"));
                    row.put("appliedAt", rs.getString("applied_at"));
                    recentApps.add(row);
                }
                request.setAttribute("recentApps", recentApps);

            } catch (SQLException e) { e.printStackTrace(); }

            request.getRequestDispatcher("/WEB-INF/pages/dashboard.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
