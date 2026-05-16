<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pethaven.model.User, com.pethaven.model.Pet, java.util.List, java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;600;700&family=Caveat:wght@600;700&display=swap');
        
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Quicksand', sans-serif;
            background: linear-gradient(135deg, #faf8f3 0%, #f5f2ed 100%);
            min-height: 100vh;
            color: #5a5a5a;
        }
        
        .sidebar {
            position: fixed;
            top: 0; left: 0;
            width: 280px;
            height: 100vh;
            background: #fffef9;
            border-right: 3px solid #e8f3e5;
            padding: 28px 0;
            z-index: 1000;
            display: flex;
            flex-direction: column;
            box-shadow: 4px 0 20px rgba(168,197,160,0.08);
        }
        
        .sidebar-brand {
            padding: 0 24px 24px;
            border-bottom: 3px dashed #c9ddc4;
            margin-bottom: 24px;
        }
        
        .brand-icon {
            width: 60px; height: 60px;
            background: linear-gradient(135deg, #a8c5a0, #c9ddc4);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 28px;
            color: white;
            margin-bottom: 12px;
            box-shadow: 0 6px 20px rgba(168,197,160,0.3);
            border: 4px solid #e8f3e5;
        }
        
        .sidebar-brand h2 { 
            font-family: 'Caveat', cursive;
            font-size: 32px; 
            font-weight: 700; 
            color: #5a5a5a; 
            margin-bottom: 2px;
            letter-spacing: 0.5px;
        }
        
        .sidebar-brand span { 
            font-size: 11px; 
            color: #9a9a9a; 
            text-transform: uppercase; 
            letter-spacing: 2px; 
            font-weight: 600;
        }
        
        .sidebar-nav { flex: 1; padding: 0 16px; }
        
        .nav-label { 
            font-size: 10px; 
            color: #9a9a9a; 
            text-transform: uppercase; 
            letter-spacing: 1.5px; 
            margin: 18px 12px 8px; 
            font-weight: 700;
        }
        
        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 18px;
            color: #9a9a9a;
            text-decoration: none;
            border-radius: 20px;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            margin-bottom: 6px;
        }
        
        .sidebar-link i { font-size: 18px; width: 24px; }
        .sidebar-link:hover { 
            background: #e8f3e5; 
            color: #8fad87; 
            transform: translateX(4px);
        }
        .sidebar-link.active { 
            background: linear-gradient(135deg, #a8c5a0, #8fad87);
            color: white; 
            font-weight: 700; 
            box-shadow: 0 6px 20px rgba(168,197,160,0.35);
        }
        
        .sidebar-footer { padding: 16px; border-top: 3px dashed #c9ddc4; }
        
        .main-content {
            margin-left: 280px;
            padding: 32px 36px;
            min-height: 100vh;
        }
        
        .topbar {
            background: #fffef9;
            border: 3px solid #e8f3e5;
            border-radius: 24px;
            padding: 24px 28px;
            margin-bottom: 28px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 20px rgba(168,197,160,0.12);
        }
        
        .topbar-left h1 { 
            font-family: 'Caveat', cursive;
            font-size: 36px; 
            font-weight: 700; 
            color: #5a5a5a; 
            margin-bottom: 2px;
            letter-spacing: 0.5px;
        }
        
        .topbar-left p { font-size: 14px; color: #9a9a9a; font-weight: 500; }
        
        .user-pill {
            display: flex;
            align-items: center;
            gap: 12px;
            background: #e8f3e5;
            padding: 8px 20px 8px 8px;
            border-radius: 50px;
            border: 3px solid #c9ddc4;
        }
        
        .user-avatar {
            width: 44px; height: 44px;
            background: linear-gradient(135deg, #ffd4b8, #ffe8d9);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            color: white;
            font-weight: 700;
            font-size: 16px;
            border: 3px solid white;
        }
        
        .user-pill span { font-size: 15px; font-weight: 700; color: #5a5a5a; }
        
        .alert {
            padding: 16px 20px;
            border-radius: 24px;
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            border: 3px solid;
        }
        
        .alert-success { 
            background: #e8f3e5; 
            color: #8fad87; 
            border-color: #c9ddc4;
        }
        
        .alert-error { 
            background: #ffe8f0; 
            color: #d5006d; 
            border-color: #ffc4dd;
        }
        
        .stats-grid {
            display: grid;
            gap: 20px;
            margin-bottom: 28px;
        }
        
        .stat-card {
            background: #fffef9;
            border: 3px solid #e8f3e5;
            border-radius: 24px;
            padding: 24px;
            display: flex;
            align-items: center;
            gap: 16px;
            text-decoration: none;
            color: inherit;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            box-shadow: 0 4px 20px rgba(168,197,160,0.12);
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            bottom: 0; left: 0; right: 0;
            height: 6px;
            background: #a8c5a0;
            border-radius: 0 0 20px 20px;
        }
        
        .stat-card:nth-child(2)::before { background: #f4d9a6; }
        .stat-card:nth-child(3)::before { background: #ffd4b8; }
        .stat-card:nth-child(4)::before { background: #f4d9a6; }
        .stat-card:nth-child(5)::before { background: #90caf9; }
        .stat-card:nth-child(6)::before { background: #ce93d8; }
        
        .stat-card:hover { 
            transform: translateY(-6px) scale(1.02); 
            box-shadow: 0 8px 30px rgba(168,197,160,0.18); 
            border-color: #c9ddc4;
        }
        
        .stat-icon {
            width: 60px; height: 60px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 26px;
            flex-shrink: 0;
            border: 3px solid white;
            background: #e8f3e5;
            color: #a8c5a0;
        }
        
        .stat-card:nth-child(2) .stat-icon { background: #fcedc7; color: #e8c78e; }
        .stat-card:nth-child(3) .stat-icon { background: #ffe8d9; color: #e8a68e; }
        .stat-card:nth-child(4) .stat-icon { background: #fcedc7; color: #e8c78e; }
        .stat-card:nth-child(5) .stat-icon { background: #e3f2fd; color: #90caf9; }
        .stat-card:nth-child(6) .stat-icon { background: #f3e5f5; color: #ce93d8; }
        
        .stat-info h3 { 
            font-size: 11px; 
            font-weight: 700; 
            color: #9a9a9a; 
            text-transform: uppercase; 
            letter-spacing: 1px; 
            margin-bottom: 6px; 
        }
        
        .stat-info p { font-size: 36px; font-weight: 700; color: #5a5a5a; line-height: 1; }
        
        .quick-actions { 
            display: grid; 
            grid-template-columns: repeat(4, 1fr); 
            gap: 16px; 
            margin-bottom: 28px; 
        }
        
        .quick-btn { 
            background: #fffef9; 
            border: 3px solid #e8f3e5; 
            border-radius: 24px; 
            padding: 20px 14px; 
            text-align: center; 
            text-decoration: none; 
            color: #5a5a5a; 
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); 
            box-shadow: 0 4px 20px rgba(168,197,160,0.12);
        }
        
        .quick-btn:hover { 
            border-color: #c9ddc4; 
            transform: translateY(-4px) scale(1.05); 
            box-shadow: 0 8px 30px rgba(168,197,160,0.18);
        }
        
        .quick-btn i { font-size: 28px; margin-bottom: 10px; display: block; color: #a8c5a0; }
        .quick-btn:nth-child(2) i { color: #90caf9; }
        .quick-btn:nth-child(3) i { color: #ce93d8; }
        .quick-btn:nth-child(4) i { color: #f4d9a6; }
        .quick-btn span { font-size: 13px; font-weight: 700; }
        
        .card {
            background: #fffef9;
            border: 3px solid #e8f3e5;
            border-radius: 24px;
            padding: 28px;
            margin-bottom: 24px;
            box-shadow: 0 4px 20px rgba(168,197,160,0.12);
        }
        
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 16px;
            border-bottom: 3px dashed #c9ddc4;
        }
        
        .card-header h2 { 
            font-family: 'Caveat', cursive;
            font-size: 28px; 
            font-weight: 700; 
            color: #5a5a5a;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .card-header h2 i { color: #a8c5a0; }
        .card-header span { font-size: 13px; color: #9a9a9a; }
        
        .add-form-bar {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            background: #e8f3e5;
            border: 3px dashed #c9ddc4;
            border-radius: 24px;
            padding: 20px;
        }
        
        .add-form-bar input,
        .add-form-bar select {
            flex: 1;
            min-width: 140px;
            padding: 12px 18px;
            background: #fffef9;
            border: 3px solid #c9ddc4;
            border-radius: 50px;
            color: #5a5a5a;
            font-size: 14px;
            font-family: inherit;
            font-weight: 600;
            outline: none;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        }
        
        .add-form-bar input:focus,
        .add-form-bar select:focus {
            border-color: #a8c5a0;
            box-shadow: 0 0 0 4px rgba(168,197,160,0.15);
            transform: scale(1.02);
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border: none;
            border-radius: 50px;
            font-size: 15px;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            font-family: inherit;
        }
        
        .btn-primary { 
            background: linear-gradient(135deg, #a8c5a0, #8fad87);
            color: white; 
            box-shadow: 0 6px 20px rgba(168,197,160,0.3);
        }
        .btn-primary:hover { 
            transform: translateY(-3px) scale(1.05); 
            box-shadow: 0 8px 25px rgba(168,197,160,0.4);
        }
        
        .charts-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 28px; }
        
        .chart-card { 
            background: #fffef9; 
            border: 3px solid #e8f3e5; 
            border-radius: 24px; 
            padding: 24px; 
            box-shadow: 0 4px 20px rgba(168,197,160,0.12);
        }
        
        .chart-card h3 { 
            font-family: 'Caveat', cursive;
            font-size: 24px; 
            font-weight: 700; 
            color: #5a5a5a; 
            margin-bottom: 16px; 
            display: flex; 
            align-items: center; 
            gap: 10px;
            letter-spacing: 0.5px;
        }
        
        .chart-card h3 i { color: #a8c5a0; font-size: 22px; }
        .chart-wrap { position: relative; height: 220px; }
        
        .activity-feed { 
            background: #fffef9; 
            border: 3px solid #e8f3e5; 
            border-radius: 24px; 
            padding: 24px; 
            box-shadow: 0 4px 20px rgba(168,197,160,0.12);
        }
        
        .activity-feed h3 { 
            font-family: 'Caveat', cursive;
            font-size: 24px; 
            font-weight: 700; 
            color: #5a5a5a; 
            margin-bottom: 16px; 
            display: flex; 
            align-items: center; 
            gap: 10px;
            letter-spacing: 0.5px;
        }
        
        .activity-item { 
            display: flex; 
            align-items: center; 
            gap: 14px; 
            padding: 12px 0; 
            border-bottom: 2px dashed #e8f3e5; 
        }
        
        .activity-item:last-child { border-bottom: none; }
        
        .activity-avatar { 
            width: 46px; height: 46px; 
            border-radius: 50%; 
            background: linear-gradient(135deg, #ffd4b8, #ffe8d9);
            display: flex; 
            align-items: center; 
            justify-content: center; 
            color: white; 
            font-weight: 700; 
            font-size: 16px; 
            border: 3px solid white;
            box-shadow: 0 4px 12px rgba(255,212,184,0.3);
        }
        
        .activity-info { flex: 1; }
        .activity-info p { font-size: 14px; color: #5a5a5a; margin: 0; font-weight: 600; }
        .activity-info p strong { color: #8fad87; }
        .activity-info span { font-size: 12px; color: #9a9a9a; font-weight: 600; }
        
        .pets-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 24px;
        }
        
        .pet-card {
            background: #fffef9;
            border: 3px solid #e8f3e5;
            border-radius: 24px;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            box-shadow: 0 4px 20px rgba(168,197,160,0.12);
        }
        
        .pet-card:hover { 
            transform: translateY(-8px) rotate(-1deg); 
            box-shadow: 0 8px 30px rgba(168,197,160,0.18); 
            border-color: #c9ddc4;
        }
        
        .pet-card-header {
            height: 200px;
            background: linear-gradient(135deg, #e8f3e5, #ffe8d9);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 72px;
            position: relative;
            overflow: hidden;
        }
        
        .pet-card-header img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        
        .pet-card-body { padding: 20px; }
        .pet-card-body h3 { 
            font-family: 'Caveat', cursive;
            font-size: 26px; 
            font-weight: 700; 
            color: #5a5a5a; 
            margin-bottom: 12px;
            letter-spacing: 0.5px;
        }
        
        .pet-meta { display: flex; flex-direction: column; gap: 8px; margin-bottom: 14px; }
        .pet-meta-row { display: flex; align-items: center; gap: 10px; font-size: 14px; color: #9a9a9a; font-weight: 600; }
        .pet-meta-row i { width: 20px; color: #a8c5a0; font-size: 16px; }
        .pet-meta-row strong { color: #5a5a5a; }
        
        .pet-card-footer {
            padding: 14px 20px;
            background: #faf8f3;
            border-top: 3px dashed #c9ddc4;
            display: flex;
            gap: 8px;
        }
        
        .badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 16px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 700;
            border: 2px solid;
        }
        
        .badge-available { background: #e8f3e5; color: #8fad87; border-color: #c9ddc4; }
        .badge-adopted { background: #ffe8f0; color: #d5006d; border-color: #ffc4dd; }
        .badge-pending { background: #fcedc7; color: #c89b4a; border-color: #f4d9a6; }
        .badge-approved { background: #e8f3e5; color: #8fad87; border-color: #c9ddc4; }
        .badge-rejected { background: #ffe8f0; color: #d5006d; border-color: #ffc4dd; }
        
        .empty-state { text-align: center; padding: 60px 20px; color: #9a9a9a; }
        .empty-state i { font-size: 64px; margin-bottom: 16px; opacity: 0.3; display: block; color: #a8c5a0; }
        .empty-state h3 { font-size: 20px; font-weight: 700; margin-bottom: 8px; color: #5a5a5a; }
        .empty-state p { font-size: 15px; font-weight: 500; }
    </style>
</head>
<body>
<%
    // PRESENTATION LAYER: Extracting session user for display in the UI
    User currentUser = (User) session.getAttribute("currentUser");
    String displayName = (currentUser != null) ? currentUser.getFullName() : "Admin";
    String initials = (displayName.length() >= 2) ? displayName.substring(0,2).toUpperCase() : "AD";
    
    // Get attributes for display
    String errorMessage = (String) request.getAttribute("errorMessage");
    String successMessage = (String) request.getAttribute("successMessage");
    Integer totalPets = (Integer) request.getAttribute("totalPets");
    Integer availablePets = (Integer) request.getAttribute("availablePets");
    Integer adoptedPets = (Integer) request.getAttribute("adoptedPets");
    Integer pendingApps = (Integer) request.getAttribute("pendingApps");
    Integer totalUsers = (Integer) request.getAttribute("totalUsers");
    Integer scheduledVisits = (Integer) request.getAttribute("scheduledVisits");
    List<Pet> petList = (List<Pet>) request.getAttribute("petList");
%>

<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon"><i class="fas fa-paw"></i></div>
        <h2>Pet Haven</h2>
        <span>Admin Panel</span>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-label">Main</div>
        <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link active">
            <i class="fas fa-home"></i><span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/manage-pets" class="sidebar-link">
            <i class="fas fa-dog"></i><span>Manage Pets</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin-appointments" class="sidebar-link">
            <i class="fas fa-calendar-check"></i><span>Appointments</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin-users" class="sidebar-link">
            <i class="fas fa-users"></i><span>Users</span>
        </a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link">
            <i class="fas fa-sign-out-alt"></i><span>Logout</span>
        </a>
    </div>
</aside>

<main class="main-content">
    <!-- TOPBAR -->
    <div class="topbar">
        <div class="topbar-left">
            <h1>Admin Dashboard</h1>
            <p>Welcome back, <%= displayName %> — here's your shelter overview</p>
        </div>
        <div class="topbar-right">
            <div class="user-pill">
                <div class="user-avatar"><%= initials %></div>
                <span><%= displayName %></span>
            </div>
        </div>
    </div>

    <!-- NOTIFICATION CONTAINERS: Display friendly validation error states or success messages -->
    <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
        <div class="alert alert-error">
            <i class="fas fa-exclamation-circle"></i>
            <span><%= errorMessage %></span>
        </div>
    <% } %>

    <% if (successMessage != null && !successMessage.isEmpty()) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i>
            <span><%= successMessage %></span>
        </div>
    <% } %>

    <!-- STAT CARDS -->
    <div class="stats-grid" style="grid-template-columns:repeat(3,1fr);">
        <a href="${pageContext.request.contextPath}/manage-pets" class="stat-card">
            <div class="stat-icon"><i class="fas fa-paw"></i></div>
            <div class="stat-info"><h3>Total Pets</h3><p><%= totalPets != null ? totalPets : 0 %></p></div>
        </a>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
            <div class="stat-info"><h3>Available</h3><p><%= availablePets != null ? availablePets : 0 %></p></div>
        </div>
        <div class="stat-card">
            <div class="stat-icon"><i class="fas fa-home"></i></div>
            <div class="stat-info"><h3>Adopted</h3><p><%= adoptedPets != null ? adoptedPets : 0 %></p></div>
        </div>
        <a href="${pageContext.request.contextPath}/admin-appointments" class="stat-card">
            <div class="stat-icon"><i class="fas fa-clock"></i></div>
            <div class="stat-info"><h3>Pending Apps</h3><p><%= pendingApps != null ? pendingApps : 0 %></p></div>
        </a>
        <a href="${pageContext.request.contextPath}/admin-users" class="stat-card">
            <div class="stat-icon"><i class="fas fa-users"></i></div>
            <div class="stat-info"><h3>Total Users</h3><p><%= totalUsers != null ? totalUsers : 0 %></p></div>
        </a>
        <a href="${pageContext.request.contextPath}/admin-appointments" class="stat-card">
            <div class="stat-icon"><i class="fas fa-calendar-alt"></i></div>
            <div class="stat-info"><h3>Scheduled Visits</h3><p><%= scheduledVisits != null ? scheduledVisits : 0 %></p></div>
        </a>
    </div>

    <!-- QUICK ACTIONS -->
    <div class="quick-actions">
        <a href="${pageContext.request.contextPath}/manage-pets" class="quick-btn">
            <i class="fas fa-plus-circle"></i>
            <span>Add Pet</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin-appointments" class="quick-btn">
            <i class="fas fa-calendar-check"></i>
            <span>Appointments</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin-users" class="quick-btn">
            <i class="fas fa-user-cog"></i>
            <span>Manage Users</span>
        </a>
        <a href="${pageContext.request.contextPath}/manage-pets" class="quick-btn">
            <i class="fas fa-list-alt"></i>
            <span>Pet Registry</span>
        </a>
    </div>

    <!-- PET REGISTRATION FORM -->
    <div class="card">
        <div class="card-header">
            <h2><i class="fas fa-plus-circle"></i>Register New Pet</h2>
        </div>
        <form action="${pageContext.request.contextPath}/dashboard" method="post">
            <div class="add-form-bar">
                <input type="text" name="name" placeholder="Pet Name *" required>
                <input type="number" name="age" placeholder="Age" style="max-width:90px;" min="0">
                <input type="text" name="breed" placeholder="Breed">
                <select name="type">
                    <option value="">-- Type --</option>
                    <option value="Dog">Dog</option>
                    <option value="Cat">Cat</option>
                    <option value="Bird">Bird</option>
                    <option value="Rabbit">Rabbit</option>
                    <option value="Turtle">Turtle</option>
                    <option value="Fish">Fish</option>
                    <option value="Hamster">Hamster</option>
                    <option value="Guinea Pig">Guinea Pig</option>
                    <option value="Other">Other</option>
                </select>
                <select name="gender">
                    <option value="">-- Gender --</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Unknown">Unknown</option>
                </select>
                <input type="url" name="imageUrl" placeholder="Image URL (optional)" style="min-width:180px;">
                <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i> Register Pet</button>
            </div>
        </form>
    </div>

    <!-- CHARTS ROW 1 -->
    <div class="charts-grid">
        <!-- Applications Over Time (Line) -->
        <div class="chart-card">
            <h3><i class="fas fa-chart-line"></i> Applications Over Time</h3>
            <div class="chart-wrap">
                <canvas id="lineChart"></canvas>
            </div>
        </div>
        <!-- Pets by Type (Doughnut) -->
        <div class="chart-card">
            <h3><i class="fas fa-chart-pie"></i> Pets by Type</h3>
            <div class="chart-wrap">
                <canvas id="doughnutChart"></canvas>
            </div>
        </div>
    </div>

    <!-- CHARTS ROW 2 + ACTIVITY -->
    <div class="charts-grid">
        <!-- Age Distribution (Bar) -->
        <div class="chart-card">
            <h3><i class="fas fa-chart-bar"></i> Age Distribution</h3>
            <div class="chart-wrap">
                <canvas id="barChart"></canvas>
            </div>
        </div>

        <!-- Recent Activity Feed -->
        <div class="activity-feed">
            <h3><i class="fas fa-bell"></i> Recent Applications</h3>
            <%
                List<Map<String,String>> recentApps = (List<Map<String,String>>) request.getAttribute("recentApps");
                if (recentApps == null || recentApps.isEmpty()) {
            %>
                <p style="color:var(--text-muted);font-size:13px;text-align:center;padding:30px 0;">No recent activity</p>
            <%
                } else {
                    for (Map<String,String> a : recentApps) {
                        String uName = a.get("userName") != null ? a.get("userName") : "User";
                        String ini = uName.length() >= 2 ? uName.substring(0,2).toUpperCase() : uName.toUpperCase();
            %>
            <div class="activity-item">
                <div class="activity-avatar"><%= ini %></div>
                <div class="activity-info">
                    <p><strong><%= uName %></strong> applied for <strong><%= a.get("petName") %></strong></p>
                    <span><%= a.get("appliedAt") %> &nbsp;·&nbsp;
                        <span class="badge badge-<%= a.get("status").toLowerCase() %>"><%= a.get("status") %></span>
                    </span>
                </div>
            </div>
            <%  } } %>
        </div>
    </div>

    <!-- PET LIST (LOOP DEMONSTRATION) -->
    <div class="card">
        <div class="card-header">
            <h2><i class="fas fa-list"></i>Pet Registry (Sorted A→Z)</h2>
            <span>
                <%= petList != null ? petList.size() : 0 %> pets total
            </span>
        </div>
        <div class="pets-grid">
            <%
                if (petList == null || petList.isEmpty()) {
            %>
                <div class="empty-state" style="grid-column:1/-1;">
                    <i class="fas fa-paw"></i>
                    <h3>No pets registered yet</h3>
                    <p>Use the form above to add your first pet.</p>
                </div>
            <%
                } else {
                    for (Pet pet : petList) {
                        String petName = pet.getName() != null ? pet.getName() : "Unknown";
                        String petType = pet.getType() != null && !pet.getType().isEmpty() ? pet.getType() : "Unknown";
                        String petBreed = pet.getBreed() != null && !pet.getBreed().isEmpty() ? pet.getBreed() : "Mixed";
                        String petGender = pet.getGender() != null && !pet.getGender().isEmpty() ? pet.getGender() : "Unknown";
                        String petStatus = pet.getStatus() != null ? pet.getStatus() : "Available";
                        String badgeClass = "Available".equals(petStatus) ? "available" : "adopted";
            %>
                <div class="pet-card">
                    <div class="pet-card-header">
                        <% if (pet.getImageUrl() != null && !pet.getImageUrl().isEmpty()) { %>
                            <img src="<%= pet.getImageUrl() %>" alt="<%= petName %>" onerror="this.style.display='none';">
                        <% } else { %>
                            🐾
                        <% } %>
                    </div>
                    <div class="pet-card-body">
                        <h3><%= petName %></h3>
                        <div class="pet-meta">
                            <div class="pet-meta-row">
                                <i class="fas fa-tag"></i>
                                <span><strong>Type:</strong> <%= petType %></span>
                            </div>
                            <div class="pet-meta-row">
                                <i class="fas fa-dna"></i>
                                <span><strong>Breed:</strong> <%= petBreed %></span>
                            </div>
                            <div class="pet-meta-row">
                                <i class="fas fa-birthday-cake"></i>
                                <span><strong>Age:</strong> <%= pet.getAge() %> yr</span>
                            </div>
                            <div class="pet-meta-row">
                                <i class="fas fa-venus-mars"></i>
                                <span><strong>Gender:</strong> <%= petGender %></span>
                            </div>
                        </div>
                    </div>
                    <div class="pet-card-footer">
                        <span class="badge badge-<%= badgeClass %>">
                            <%= petStatus %>
                        </span>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
    // CHART CONFIGURATION: Using Chart.js for real-time data visualization
    Chart.defaults.font.family = "'Quicksand', sans-serif";
    Chart.defaults.color = '#5a5a5a';

    const palette = ['#a8c5a0','#f4d9a6','#ffd4b8','#d4a5a5','#b8c5d4'];

    // Line Chart — Applications over time
    new Chart(document.getElementById('lineChart'), {
        type: 'line',
        data: {
            labels: [${chartMonthLabels}],
            datasets: [{
                label: 'Applications',
                data: [${chartMonthCounts}],
                borderColor: '#a8c5a0',
                backgroundColor: 'rgba(168,197,160,0.2)',
                borderWidth: 2.5,
                pointBackgroundColor: '#7fa99b',
                pointRadius: 5,
                tension: 0.4,
                fill: true
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                y: { beginAtZero: true, ticks: { stepSize: 1 }, grid: { color: 'rgba(255,255,255,0.05)' } },
                x: { grid: { display: false } }
            }
        }
    });

    // Doughnut Chart — Pets by type
    new Chart(document.getElementById('doughnutChart'), {
        type: 'doughnut',
        data: {
            labels: [${chartTypeLabels}],
            datasets: [{
                data: [${chartTypeCounts}],
                backgroundColor: palette,
                borderWidth: 0,
                hoverOffset: 8
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            plugins: {
                legend: { position: 'bottom', labels: { padding: 16, font: { size: 12 } } }
            },
            cutout: '65%'
        }
    });

    // Bar Chart — Age distribution
    new Chart(document.getElementById('barChart'), {
        type: 'bar',
        data: {
            labels: ['0–1 yr', '2–3 yrs', '4–5 yrs', '6–8 yrs', '9+ yrs'],
            datasets: [{
                label: 'Pets',
                data: [${ageBuckets}],
                backgroundColor: palette,
                borderRadius: 8,
                borderSkipped: false
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                y: { beginAtZero: true, ticks: { stepSize: 1 }, grid: { color: 'rgba(255,255,255,0.05)' } },
                x: { grid: { display: false } }
            }
        }
    });
</script>
</body>
</html>
