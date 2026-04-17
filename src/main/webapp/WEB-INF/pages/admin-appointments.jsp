<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Appointments</title>
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
        <a href="${pageContext.request.contextPath}/admin-appointments" class="sidebar-link active"><i class="fas fa-calendar-check"></i><span>Appointments</span></a>
        <a href="${pageContext.request.contextPath}/admin-users" class="sidebar-link"><i class="fas fa-users"></i><span>Users</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    </div>
</aside>

<main class="main-content">
    <div class="topbar">
        <div class="topbar-left">
            <h1>Appointments</h1>
            <p>Manage all scheduled shelter visits</p>
        </div>
    </div>

    <%
        List<Map<String, String>> appointments = (List<Map<String, String>>) request.getAttribute("appointments");
        if (appointments == null || appointments.isEmpty()) {
    %>
        <div class="card">
            <div class="empty-state">
                <i class="fas fa-calendar-check"></i>
                <h3>No appointments scheduled yet</h3>
                <p>Appointments will appear here once users schedule visits.</p>
            </div>
        </div>
    <% } else { %>
    <div class="table-wrap">
        <table>
            <thead>
                <tr><th>User</th><th>Pet</th><th>Type</th><th>Date</th><th>Time</th><th>Notes</th><th>Status</th></tr>
            </thead>
            <tbody>
                <% for (Map<String, String> a : appointments) { %>
                <tr>
                    <td><strong><%= a.get("userName") %></strong></td>
                    <td><%= a.get("petName") %></td>
                    <td><%= a.get("petType") %></td>
                    <td><%= a.get("visitDate") %></td>
                    <td><%= a.get("visitTime") %></td>
                    <td style="color:var(--gray);font-size:13px;"><%= a.get("notes") %></td>
                    <td>
                        <form method="post" action="${pageContext.request.contextPath}/admin-appointments" style="margin:0;">
                            <input type="hidden" name="visitId" value="<%= a.get("visitId") %>">
                            <select name="status" class="status-select" onchange="this.form.submit()">
                                <option value="Scheduled" <%= "Scheduled".equals(a.get("status")) ? "selected" : "" %>>Scheduled</option>
                                <option value="Completed" <%= "Completed".equals(a.get("status")) ? "selected" : "" %>>Completed</option>
                                <option value="Cancelled" <%= "Cancelled".equals(a.get("status")) ? "selected" : "" %>>Cancelled</option>
                            </select>
                        </form>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    <% } %>
</main>
</body>
</html>
