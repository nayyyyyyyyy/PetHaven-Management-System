<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Appointments</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;600;700&family=Caveat:wght@600;700&display=swap');
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Quicksand', sans-serif; background: linear-gradient(135deg, #faf8f3 0%, #f5f2ed 100%); min-height: 100vh; color: #5a5a5a; }
        .sidebar { position: fixed; top: 0; left: 0; width: 280px; height: 100vh; background: #fffef9; border-right: 3px solid #e8f3e5; padding: 28px 0; z-index: 1000; display: flex; flex-direction: column; box-shadow: 4px 0 20px rgba(168,197,160,0.08); }
        .sidebar-brand { padding: 0 24px 24px; border-bottom: 3px dashed #c9ddc4; margin-bottom: 24px; }
        .brand-icon { width: 60px; height: 60px; background: linear-gradient(135deg, #a8c5a0, #c9ddc4); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 28px; color: white; margin-bottom: 12px; box-shadow: 0 6px 20px rgba(168,197,160,0.3); border: 4px solid #e8f3e5; }
        .sidebar-brand h2 { font-family: 'Caveat', cursive; font-size: 32px; font-weight: 700; color: #5a5a5a; margin-bottom: 2px; letter-spacing: 0.5px; }
        .sidebar-brand span { font-size: 11px; color: #9a9a9a; text-transform: uppercase; letter-spacing: 2px; font-weight: 600; }
        .sidebar-nav { flex: 1; padding: 0 16px; }
        .nav-label { font-size: 10px; color: #9a9a9a; text-transform: uppercase; letter-spacing: 1.5px; margin: 18px 12px 8px; font-weight: 700; }
        .sidebar-link { display: flex; align-items: center; gap: 14px; padding: 14px 18px; color: #9a9a9a; text-decoration: none; border-radius: 20px; font-size: 15px; font-weight: 600; transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); margin-bottom: 6px; }
        .sidebar-link i { font-size: 18px; width: 24px; }
        .sidebar-link:hover { background: #e8f3e5; color: #8fad87; transform: translateX(4px); }
        .sidebar-link.active { background: linear-gradient(135deg, #a8c5a0, #8fad87); color: white; font-weight: 700; box-shadow: 0 6px 20px rgba(168,197,160,0.35); }
        .sidebar-footer { padding: 16px; border-top: 3px dashed #c9ddc4; }
        .main-content { margin-left: 280px; padding: 32px 36px; min-height: 100vh; }
        .topbar { background: #fffef9; border: 3px solid #e8f3e5; border-radius: 24px; padding: 24px 28px; margin-bottom: 28px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 20px rgba(168,197,160,0.12); }
        .topbar-left h1 { font-family: 'Caveat', cursive; font-size: 36px; font-weight: 700; color: #5a5a5a; margin-bottom: 2px; letter-spacing: 0.5px; }
        .topbar-left p { font-size: 14px; color: #9a9a9a; font-weight: 500; }
        .card { background: #fffef9; border: 3px solid #e8f3e5; border-radius: 24px; padding: 28px; margin-bottom: 24px; box-shadow: 0 4px 20px rgba(168,197,160,0.12); }
        .table-wrap { background: #fffef9; border: 3px solid #e8f3e5; border-radius: 24px; overflow: hidden; box-shadow: 0 4px 20px rgba(168,197,160,0.12); }
        table { width: 100%; border-collapse: collapse; }
        thead th { background: #e8f3e5; color: #8fad87; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; padding: 16px 20px; text-align: left; border-bottom: 3px solid #c9ddc4; }
        tbody td { padding: 16px 20px; font-size: 15px; font-weight: 600; color: #5a5a5a; border-bottom: 2px solid #e8f3e5; }
        tbody tr:last-child td { border-bottom: none; }
        tbody tr:hover { background: #faf8f3; }
        .empty-state { text-align: center; padding: 60px 20px; color: #9a9a9a; }
        .empty-state i { font-size: 64px; margin-bottom: 16px; opacity: 0.3; display: block; color: #a8c5a0; }
        .empty-state h3 { font-size: 20px; font-weight: 700; margin-bottom: 8px; color: #5a5a5a; }
        .empty-state p { font-size: 15px; font-weight: 500; }
        .status-select { padding: 8px 14px; background: #fffef9; border: 3px solid #c9ddc4; border-radius: 50px; color: #5a5a5a; font-size: 13px; font-family: inherit; font-weight: 700; cursor: pointer; outline: none; }
    </style>
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
