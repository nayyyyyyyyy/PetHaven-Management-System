<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pethaven.model.User, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Users</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon"><i class="fas fa-paw"></i></div>
        <h2>Pet Haven</h2>
        <span>Admin Panel</span>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-label">Main</div>
        <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link"><i class="fas fa-home"></i><span>Dashboard</span></a>
        <a href="${pageContext.request.contextPath}/manage-pets" class="sidebar-link"><i class="fas fa-dog"></i><span>Manage Pets</span></a>
        <a href="${pageContext.request.contextPath}/admin-appointments" class="sidebar-link"><i class="fas fa-calendar-check"></i><span>Appointments</span></a>
        <a href="${pageContext.request.contextPath}/admin-users" class="sidebar-link active"><i class="fas fa-users"></i><span>Users</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    </div>
</aside>

<main class="main-content">
    <div class="topbar">
        <div class="topbar-left">
            <h1>Users</h1>
            <p>All registered accounts in the system</p>
        </div>
    </div>

    <%
        List<User> users = (List<User>) request.getAttribute("users");
        if (users == null || users.isEmpty()) {
    %>
        <div class="card">
            <div class="empty-state">
                <i class="fas fa-users"></i>
                <h3>No users found</h3>
            </div>
        </div>
    <% } else { %>
    <div class="table-wrap">
        <table>
            <thead>
                <tr><th>ID</th><th>Username</th><th>Full Name</th><th>Email</th><th>Role</th></tr>
            </thead>
            <tbody>
                <% for (User u : users) { %>
                <tr>
                    <td style="color:var(--gray);font-size:12px;">#<%= u.getUserId() %></td>
                    <td><strong><%= u.getUsername() %></strong></td>
                    <td><%= u.getFullName() != null ? u.getFullName() : "-" %></td>
                    <td style="color:var(--gray);font-size:13px;"><%= u.getEmail() != null ? u.getEmail() : "-" %></td>
                    <td><span class="badge badge-<%= u.getRole().toLowerCase() %>"><%= u.getRole() %></span></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
</main>
</body>
</html>
