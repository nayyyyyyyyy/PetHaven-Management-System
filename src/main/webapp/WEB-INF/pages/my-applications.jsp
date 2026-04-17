<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pethaven.model.Application, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | My Applications</title>
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
        <a href="${pageContext.request.contextPath}/my-applications" class="sidebar-link active"><i class="fas fa-file-alt"></i><span>My Applications</span></a>
        <a href="${pageContext.request.contextPath}/my-favourites" class="sidebar-link"><i class="fas fa-heart"></i><span>Favourites</span></a>
        <a href="${pageContext.request.contextPath}/my-visits" class="sidebar-link"><i class="fas fa-calendar-alt"></i><span>My Visits</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    </div>
</aside>

<main class="main-content">
    <div class="topbar">
        <div class="topbar-left">
            <h1>My Applications</h1>
            <p>Track the status of your adoption applications</p>
        </div>
        <div class="topbar-right">
            <a href="${pageContext.request.contextPath}/browse-pets" class="btn btn-primary">
                <i class="fas fa-plus"></i> New Application
            </a>
        </div>
    </div>

    <%
        List<Application> apps = (List<Application>) request.getAttribute("applications");
        if (apps == null || apps.isEmpty()) {
    %>
        <div class="card">
            <div class="empty-state">
                <i class="fas fa-file-alt"></i>
                <h3>No applications yet</h3>
                <p>Browse available pets and submit your first adoption application.</p>
                <a href="${pageContext.request.contextPath}/browse-pets" class="btn btn-primary">Browse Pets</a>
            </div>
        </div>
    <% } else { %>
    <div class="table-wrap">
        <table>
            <thead>
                <tr>
                    <th>Pet Name</th>
                    <th>Type</th>
                    <th>Breed</th>
                    <th>Status</th>
                    <th>Applied On</th>
                </tr>
            </thead>
            <tbody>
                <% for (Application app : apps) { %>
                <tr>
                    <td><strong><%= app.getPetName() %></strong></td>
                    <td><%= app.getPetType() %></td>
                    <td><%= app.getPetBreed() %></td>
                    <td><span class="badge badge-<%= app.getStatus().toLowerCase() %>"><%= app.getStatus() %></span></td>
                    <td style="color:var(--gray);font-size:13px;"><%= app.getAppliedAt() %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
</main>
</body>
</html>
