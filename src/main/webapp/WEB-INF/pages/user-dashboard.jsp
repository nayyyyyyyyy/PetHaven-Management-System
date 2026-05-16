<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pethaven.model.User, com.pethaven.model.Pet, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | My Dashboard</title>
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
        
        .hero-banner {
            background: linear-gradient(135deg, #a8c5a0 0%, #8fad87 100%);
            border-radius: 24px;
            padding: 36px 40px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 6px 20px rgba(168,197,160,0.3);
        }
        .hero-banner::before {
            content: '\f1b0';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            right: 40px; top: 50%;
            transform: translateY(-50%);
            font-size: 120px;
            opacity: 0.1;
            color: white;
        }
        .hero-banner h2 { font-family: 'Caveat', cursive; font-size: 32px; font-weight: 700; margin-bottom: 8px; letter-spacing: 0.5px; }
        .hero-banner p  { font-size: 15px; opacity: 0.9; margin-bottom: 20px; font-weight: 500; }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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
        
        .stat-card:nth-child(2)::before { background: #f5a5a5; }
        .stat-card:nth-child(3)::before { background: #90caf9; }
        
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
        
        .stat-card:nth-child(2) .stat-icon { background: #ffe8f0; color: #f5a5a5; }
        .stat-card:nth-child(3) .stat-icon { background: #e3f2fd; color: #90caf9; }
        
        .stat-info h3 { 
            font-size: 11px; 
            font-weight: 700; 
            color: #9a9a9a; 
            text-transform: uppercase; 
            letter-spacing: 1px; 
            margin-bottom: 6px; 
        }
        
        .stat-info p { font-size: 36px; font-weight: 700; color: #5a5a5a; line-height: 1; }
        
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
        
        .recent-section h2 { 
            font-family: 'Caveat', cursive;
            font-size: 28px; 
            font-weight: 700; 
            color: #5a5a5a; 
            margin-bottom: 18px; 
            display:flex; 
            align-items:center; 
            gap:10px;
            letter-spacing: 0.5px;
        }
        .recent-section h2 a { font-size: 14px; font-weight: 600; color: #a8c5a0; margin-left: auto; text-decoration: none; }
        .recent-section h2 a:hover { text-decoration: underline; }
        
        .pets-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 24px;
            margin-bottom: 28px;
        }
        
        .mini-pet-card { 
            background: #fffef9; 
            border: 3px solid #e8f3e5;
            border-radius: 24px; 
            overflow: hidden; 
            box-shadow: 0 4px 20px rgba(168,197,160,0.12); 
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); 
        }
        .mini-pet-card:hover { transform: translateY(-5px); box-shadow: 0 8px 30px rgba(168,197,160,0.18); border-color: #c9ddc4; }
        .mini-pet-img { width: 100%; height: 160px; object-fit: cover; display: block; }
        .mini-pet-img-placeholder { width: 100%; height: 160px; display: flex; align-items: center; justify-content: center; font-size: 52px; }
        .mini-pet-body { padding: 16px; }
        .mini-pet-body h4 { font-family: 'Caveat', cursive; font-size: 22px; font-weight: 700; color: #5a5a5a; margin-bottom: 4px; letter-spacing: 0.5px; }
        .mini-pet-body p  { font-size: 13px; color: #9a9a9a; margin: 0 0 10px; font-weight: 600; }
        
        .tip-card { 
            background: linear-gradient(135deg, #e8f3e5, #f0faf5); 
            border-radius: 24px; 
            padding: 22px 24px; 
            border: 3px solid #c9ddc4;
            box-shadow: 0 4px 20px rgba(168,197,160,0.12);
        }
        .tip-card h4 { font-size: 16px; font-weight: 700; color: #5a5a5a; margin-bottom: 6px; }
        .tip-card p  { font-size: 14px; color: #9a9a9a; margin: 0; line-height: 1.7; font-weight: 500; }
    </style>
</head>
<body>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    String displayName = (currentUser != null) ? currentUser.getFullName() : "User";
    String initials = (displayName.length() >= 2) ? displayName.substring(0,2).toUpperCase() : "U";
    String[] gradients = {"linear-gradient(135deg,#A8E6CF,#5cb88a)","linear-gradient(135deg,#FFD3B6,#e17055)","linear-gradient(135deg,#A29BFE,#6c5ce7)","linear-gradient(135deg,#FFAAA5,#d63031)"};
    String[] icons = {"fa-dog","fa-cat","fa-paw","fa-horse"};
%>

<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon"><i class="fas fa-paw"></i></div>
        <h2>Pet Haven</h2>
        <span>Adoption Portal</span>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-label">Menu</div>
        <a href="${pageContext.request.contextPath}/dashboard"        class="sidebar-link active"><i class="fas fa-home"></i><span>Dashboard</span></a>
        <a href="${pageContext.request.contextPath}/browse-pets"      class="sidebar-link"><i class="fas fa-search"></i><span>Browse Pets</span></a>
        <a href="${pageContext.request.contextPath}/my-applications"  class="sidebar-link"><i class="fas fa-file-alt"></i><span>My Applications</span></a>
        <a href="${pageContext.request.contextPath}/my-favourites"    class="sidebar-link"><i class="fas fa-heart"></i><span>Favourites</span></a>
        <a href="${pageContext.request.contextPath}/my-visits"        class="sidebar-link"><i class="fas fa-calendar-alt"></i><span>My Visits</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    </div>
</aside>

<main class="main-content">
    <div class="topbar">
        <div class="topbar-left">
            <h1>Welcome back, <%= displayName %>!</h1>
            <p>Ready to find your perfect companion today?</p>
        </div>
        <div class="topbar-right">
            <div class="user-pill">
                <div class="user-avatar"><%= initials %></div>
                <span><%= displayName %></span>
            </div>
        </div>
    </div>

    <!-- HERO BANNER -->
    <div class="hero-banner">
        <div>
            <h2>Find Your Forever Friend</h2>
            <p>Hundreds of loving pets are waiting for a home just like yours.</p>
            <a href="${pageContext.request.contextPath}/browse-pets" class="btn btn-primary" style="background:white;color:#2d7a56;">
                <i class="fas fa-search"></i> Browse All Pets
            </a>
        </div>
    </div>

    <!-- STAT CARDS -->
    <div class="stats-grid" style="margin-bottom:32px;">
        <a href="${pageContext.request.contextPath}/my-applications" class="stat-card" style="--stat-bg:#e8f8f0;--stat-color:#2d7a56;">
            <div class="stat-icon"><i class="fas fa-file-alt"></i></div>
            <div class="stat-info"><h3>My Applications</h3><p>${appCount}</p></div>
        </a>
        <a href="${pageContext.request.contextPath}/my-favourites" class="stat-card" style="--stat-bg:#fde8f0;--stat-color:#c0392b;">
            <div class="stat-icon"><i class="fas fa-heart"></i></div>
            <div class="stat-info"><h3>Favourites</h3><p>${favCount}</p></div>
        </a>
        <a href="${pageContext.request.contextPath}/my-visits" class="stat-card" style="--stat-bg:#eaf2ff;--stat-color:#2980b9;">
            <div class="stat-icon"><i class="fas fa-calendar-alt"></i></div>
            <div class="stat-info"><h3>Scheduled Visits</h3><p>${visitCount}</p></div>
        </a>
    </div>

    <!-- RECENTLY ADDED PETS -->
    <%
        List<Pet> recentPets = (List<Pet>) request.getAttribute("recentPets");
        if (recentPets != null && !recentPets.isEmpty()) {
    %>
    <div class="recent-section">
        <h2>
            <i class="fas fa-star" style="color:#fdcb6e;"></i> Recently Added Pets
            <a href="${pageContext.request.contextPath}/browse-pets">View all <i class="fas fa-arrow-right"></i></a>
        </h2>
        <div class="pets-grid" style="grid-template-columns:repeat(auto-fill,minmax(220px,1fr));margin-bottom:28px;">
            <% int ri = 0; for (Pet pet : recentPets) { %>
            <div class="mini-pet-card">
                <% if (pet.getImageUrl() != null && !pet.getImageUrl().trim().isEmpty()) { %>
                    <img src="<%= pet.getImageUrl() %>" alt="<%= pet.getName() %>" class="mini-pet-img"
                         onerror="this.style.display='none';this.nextElementSibling.style.display='flex';">
                    <div class="mini-pet-img-placeholder" style="display:none;background:<%= gradients[ri % gradients.length] %>;">
                        <i class="fas <%= icons[ri % icons.length] %>" style="color:rgba(255,255,255,0.9);"></i>
                    </div>
                <% } else { %>
                    <div class="mini-pet-img-placeholder" style="background:<%= gradients[ri % gradients.length] %>;">
                        <i class="fas <%= icons[ri % icons.length] %>" style="color:rgba(255,255,255,0.9);"></i>
                    </div>
                <% } %>
                <div class="mini-pet-body">
                    <h4><%= pet.getName() %></h4>
                    <p><%= pet.getType() != null ? pet.getType() : "" %><%= (pet.getBreed() != null && !pet.getBreed().isEmpty()) ? " · " + pet.getBreed() : "" %></p>
                    <a href="${pageContext.request.contextPath}/browse-pets" class="btn btn-primary" style="padding:7px 14px;font-size:12px;width:100%;justify-content:center;">
                        <i class="fas fa-eye"></i> View
                    </a>
                </div>
            </div>
            <% ri++; } %>
        </div>
    </div>
    <% } %>

    <!-- ADOPTION TIP -->
    <div class="tip-card">
        <h4><i class="fas fa-lightbulb"></i> Adoption Tip</h4>
        <p>Before adopting, consider the pet's energy level, size, and compatibility with your lifestyle. Schedule a visit to meet your potential companion in person — it makes all the difference!</p>
    </div>
</main>
</body>
</html>
