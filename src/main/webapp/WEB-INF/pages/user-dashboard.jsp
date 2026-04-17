<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pethaven.model.User, com.pethaven.model.Pet, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | My Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .hero-banner {
            background: linear-gradient(135deg, #2d7a56 0%, #34495E 100%);
            border-radius: var(--radius);
            padding: 36px 40px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 28px;
            position: relative;
            overflow: hidden;
        }
        .hero-banner::before {
            content: '\f1b0';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            right: 40px; top: 50%;
            transform: translateY(-50%);
            font-size: 120px;
            opacity: 0.07;
            color: white;
        }
        .hero-banner h2 { font-size: 26px; font-weight: 800; margin-bottom: 8px; }
        .hero-banner p  { font-size: 14px; opacity: 0.8; margin-bottom: 20px; }
        .recent-section h2 { font-size: 17px; font-weight: 700; color: var(--dark2); margin-bottom: 18px; display:flex; align-items:center; gap:10px; }
        .recent-section h2 a { font-size: 13px; font-weight: 500; color: var(--primary-dark); margin-left: auto; text-decoration: none; }
        .recent-section h2 a:hover { text-decoration: underline; }
        .mini-pet-card { background: var(--white); border-radius: var(--radius); overflow: hidden; box-shadow: var(--shadow-sm); transition: var(--transition); }
        .mini-pet-card:hover { transform: translateY(-5px); box-shadow: var(--shadow-md); }
        .mini-pet-img { width: 100%; height: 160px; object-fit: cover; display: block; }
        .mini-pet-img-placeholder { width: 100%; height: 160px; display: flex; align-items: center; justify-content: center; font-size: 52px; }
        .mini-pet-body { padding: 16px; }
        .mini-pet-body h4 { font-size: 15px; font-weight: 700; color: var(--dark2); margin-bottom: 4px; }
        .mini-pet-body p  { font-size: 12px; color: var(--gray); margin: 0 0 10px; }
        .tip-card { background: linear-gradient(135deg, #f0faf5, #e8f8f0); border-radius: var(--radius); padding: 22px 24px; border-left: 4px solid var(--primary-dark); }
        .tip-card h4 { font-size: 14px; font-weight: 700; color: var(--primary-text); margin-bottom: 6px; }
        .tip-card p  { font-size: 13px; color: var(--dark); margin: 0; line-height: 1.6; }
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
