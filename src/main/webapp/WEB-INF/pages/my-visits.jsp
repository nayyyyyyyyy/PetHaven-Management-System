<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pethaven.model.Visit, com.pethaven.model.Pet, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | My Visits</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon"><i class="fas fa-paw"></i></div>
        <h2>Pet Haven</h2>
        <span>Adoption Portal</span>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-label">Menu</div>
        <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link"><i class="fas fa-home"></i><span>Dashboard</span></a>
        <a href="${pageContext.request.contextPath}/browse-pets" class="sidebar-link"><i class="fas fa-search"></i><span>Browse Pets</span></a>
        <a href="${pageContext.request.contextPath}/my-applications" class="sidebar-link"><i class="fas fa-file-alt"></i><span>My Applications</span></a>
        <a href="${pageContext.request.contextPath}/my-favourites" class="sidebar-link"><i class="fas fa-heart"></i><span>Favourites</span></a>
        <a href="${pageContext.request.contextPath}/my-visits" class="sidebar-link active"><i class="fas fa-calendar-alt"></i><span>My Visits</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    </div>
</aside>

<main class="main-content">
    <div class="topbar">
        <div class="topbar-left">
            <h1>My Visits</h1>
            <p>Schedule and manage your shelter visits</p>
        </div>
    </div>

    <!-- SCHEDULE FORM -->
    <div class="schedule-card">
        <h2><i class="fas fa-calendar-plus" style="color:var(--accent3);margin-right:8px;"></i>Schedule a Visit</h2>
        <form method="post" action="${pageContext.request.contextPath}/my-visits">
            <div class="form-row">
                <select name="petId" required>
                    <option value="">-- Select a Pet --</option>
                    <%
                        List<Pet> pets = (List<Pet>) request.getAttribute("pets");
                        String preselectedPetId = request.getParameter("petId");
                        if (pets != null) {
                            for (Pet pet : pets) {
                                if ("Available".equalsIgnoreCase(pet.getStatus())) {
                                    String sel = (preselectedPetId != null && preselectedPetId.equals(String.valueOf(pet.getPetId()))) ? "selected" : "";
                    %>
                    <option value="<%= pet.getPetId() %>" <%= sel %>><%= pet.getName() %> (<%= pet.getType() %>)</option>
                    <%          }
                            }
                        }
                    %>
                </select>
                <input type="date" name="visitDate" required min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                <input type="time" name="visitTime" required>
            </div>
            <div class="form-row">
                <textarea name="notes" rows="2" placeholder="Any notes or questions? (optional)"></textarea>
            </div>
            <button type="submit" class="btn btn-info">
                <i class="fas fa-calendar-check"></i> Schedule Visit
            </button>
        </form>
    </div>

    <!-- VISITS TABLE -->
    <%
        List<Visit> visits = (List<Visit>) request.getAttribute("visits");
        if (visits == null || visits.isEmpty()) {
    %>
        <div class="card">
            <div class="empty-state">
                <i class="fas fa-calendar-alt"></i>
                <h3>No visits scheduled yet</h3>
                <p>Use the form above to schedule your first visit.</p>
            </div>
        </div>
    <% } else { %>
    <div class="table-wrap">
        <table>
            <thead>
                <tr><th>Pet</th><th>Type</th><th>Date</th><th>Time</th><th>Status</th><th>Notes</th></tr>
            </thead>
            <tbody>
                <% for (Visit v : visits) { %>
                <tr>
                    <td><strong><%= v.getPetName() %></strong></td>
                    <td><%= v.getPetType() %></td>
                    <td><%= v.getVisitDate() %></td>
                    <td><%= v.getVisitTime() %></td>
                    <td><span class="badge badge-<%= v.getStatus().toLowerCase() %>"><%= v.getStatus() %></span></td>
                    <td style="color:var(--gray);font-size:13px;"><%= v.getNotes() != null ? v.getNotes() : "-" %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
</main>
</body>
</html>
