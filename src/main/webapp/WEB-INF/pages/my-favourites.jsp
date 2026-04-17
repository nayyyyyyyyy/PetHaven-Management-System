<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pethaven.model.Favourite, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | My Favourites</title>
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
        <a href="${pageContext.request.contextPath}/dashboard"       class="sidebar-link"><i class="fas fa-home"></i><span>Dashboard</span></a>
        <a href="${pageContext.request.contextPath}/browse-pets"     class="sidebar-link"><i class="fas fa-search"></i><span>Browse Pets</span></a>
        <a href="${pageContext.request.contextPath}/my-applications" class="sidebar-link"><i class="fas fa-file-alt"></i><span>My Applications</span></a>
        <a href="${pageContext.request.contextPath}/my-favourites"   class="sidebar-link active"><i class="fas fa-heart"></i><span>Favourites</span></a>
        <a href="${pageContext.request.contextPath}/my-visits"       class="sidebar-link"><i class="fas fa-calendar-alt"></i><span>My Visits</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    </div>
</aside>

<main class="main-content">
    <div class="topbar">
        <div class="topbar-left">
            <h1>My Favourites</h1>
            <p>Pets you've saved for later</p>
        </div>
    </div>

    <%
        List<Favourite> favs = (List<Favourite>) request.getAttribute("favourites");
        if (favs == null || favs.isEmpty()) {
    %>
        <div class="card">
            <div class="empty-state">
                <i class="fas fa-heart"></i>
                <h3>No favourites saved yet</h3>
                <p>Browse pets and click Save to add them here.</p>
                <a href="${pageContext.request.contextPath}/browse-pets" class="btn btn-primary">Browse Pets</a>
            </div>
        </div>
    <% } else { %>
    <div class="pets-grid">
        <%
            String[] favGrads = {
                "linear-gradient(135deg,#FFAAA5,#d63031)",
                "linear-gradient(135deg,#FFD3B6,#e17055)",
                "linear-gradient(135deg,#A29BFE,#6c5ce7)",
                "linear-gradient(135deg,#A8E6CF,#5cb88a)"
            };
            int fi = 0;
            for (Favourite fav : favs) {
                String grad = favGrads[fi % favGrads.length];
                String imgUrl = fav.getPetImageUrl();
                boolean hasImg = imgUrl != null && !imgUrl.trim().isEmpty();
        %>
        <div class="pet-card">
            <div class="pet-card-header" style="background:<%= grad %>;padding:0;overflow:hidden;">
                <% if (hasImg) { %>
                    <img src="<%= imgUrl %>" alt="<%= fav.getPetName() %>"
                         style="width:100%;height:100%;object-fit:cover;display:block;"
                         onerror="this.style.display='none';this.nextElementSibling.style.display='flex';">
                    <div style="display:none;width:100%;height:100%;align-items:center;justify-content:center;font-size:48px;background:<%= grad %>;">
                        <i class="fas fa-paw" style="color:rgba(255,255,255,0.9);"></i>
                    </div>
                <% } else { %>
                    <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;font-size:48px;">
                        <i class="fas fa-paw" style="color:rgba(255,255,255,0.9);"></i>
                    </div>
                <% } %>
                <span class="badge <%= "Available".equalsIgnoreCase(fav.getPetStatus()) ? "badge-available" : "badge-adopted" %>"
                      style="position:absolute;top:12px;right:12px;"><%= fav.getPetStatus() %></span>
            </div>
            <div class="pet-card-body">
                <h3><%= fav.getPetName() %></h3>
                <div class="pet-meta">
                    <div class="pet-meta-row"><i class="fas fa-tag"></i><span>Type: <strong><%= fav.getPetType() %></strong></span></div>
                    <div class="pet-meta-row"><i class="fas fa-dna"></i><span>Breed: <strong><%= fav.getPetBreed() %></strong></span></div>
                </div>
            </div>
            <div class="pet-card-footer">
                <form method="post" action="${pageContext.request.contextPath}/my-favourites" style="margin:0;">
                    <input type="hidden" name="petId" value="<%= fav.getPetId() %>">
                    <input type="hidden" name="action" value="remove">
                    <button type="submit" class="btn btn-danger" style="padding:8px 14px;font-size:12px;">
                        <i class="fas fa-trash"></i> Remove
                    </button>
                </form>
                <% if ("Available".equalsIgnoreCase(fav.getPetStatus())) { %>
                <form method="post" action="${pageContext.request.contextPath}/my-applications" style="margin:0;">
                    <input type="hidden" name="petId" value="<%= fav.getPetId() %>">
                    <button type="submit" class="btn btn-primary" style="padding:8px 14px;font-size:12px;">
                        <i class="fas fa-file-alt"></i> Apply
                    </button>
                </form>
                <% } %>
            </div>
        </div>
        <% fi++; } %>
    </div>
    <% } %>
</main>
</body>
</html>
