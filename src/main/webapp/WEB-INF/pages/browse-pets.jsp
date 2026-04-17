<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pethaven.model.Pet, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Browse Pets</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<!-- SIDEBAR -->
<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon"><i class="fas fa-paw"></i></div>
        <h2>Pet Haven</h2>
        <span>Adoption Portal</span>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-label">Menu</div>
        <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link">
            <i class="fas fa-home"></i><span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/browse-pets" class="sidebar-link active">
            <i class="fas fa-search"></i><span>Browse Pets</span>
        </a>
        <a href="${pageContext.request.contextPath}/my-applications" class="sidebar-link">
            <i class="fas fa-file-alt"></i><span>My Applications</span>
        </a>
        <a href="${pageContext.request.contextPath}/my-favourites" class="sidebar-link">
            <i class="fas fa-heart"></i><span>Favourites</span>
        </a>
        <a href="${pageContext.request.contextPath}/my-visits" class="sidebar-link">
            <i class="fas fa-calendar-alt"></i><span>My Visits</span>
        </a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link">
            <i class="fas fa-sign-out-alt"></i><span>Logout</span>
        </a>
    </div>
</aside>

<!-- MAIN CONTENT -->
<main class="main-content">
    <div class="topbar">
        <div class="topbar-left">
            <h1>Browse Pets</h1>
            <p>Find your perfect companion and start the adoption journey</p>
        </div>
    </div>

    <% if (request.getAttribute("message") != null) { %>
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${message}
        </div>
    <% } %>

    <!-- SEARCH & FILTER BAR -->
    <div class="filter-bar">
        <i class="fas fa-search" style="color:var(--green-mid);"></i>
        <input type="text" id="searchInput" placeholder="Search by name or breed..." oninput="filterPets()">
        <select id="typeFilter" onchange="filterPets()">
            <option value="">All Types</option>
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
        <select id="genderFilter" onchange="filterPets()">
            <option value="">All Genders</option>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
        </select>
        <select id="sortSelect" onchange="sortPets()">
            <option value="">Sort by...</option>
            <option value="name-asc">Name A→Z</option>
            <option value="name-desc">Name Z→A</option>
            <option value="age-asc">Age ↑</option>
            <option value="age-desc">Age ↓</option>
        </select>
    </div>

    <%
        List<Pet> pets = (List<Pet>) request.getAttribute("pets");
        // Color palettes for pet card headers — cycles through 6 gradients
        String[] gradients = {
            "linear-gradient(135deg,#A8E6CF,#5cb88a)",
            "linear-gradient(135deg,#FFD3B6,#e17055)",
            "linear-gradient(135deg,#A29BFE,#6c5ce7)",
            "linear-gradient(135deg,#FFAAA5,#d63031)",
            "linear-gradient(135deg,#81ecec,#00b894)",
            "linear-gradient(135deg,#fdcb6e,#e17055)"
        };
        int idx = 0;
        if (pets == null || pets.isEmpty()) {
    %>
        <div class="card">
            <div class="empty-state">
                <i class="fas fa-paw"></i>
                <h3>No pets available right now</h3>
                <p>Check back soon — new pets are added regularly!</p>
            </div>
        </div>
    <%
        } else {
    %>
    <div class="pets-grid" id="petsGrid">
        <% for (Pet pet : pets) {
               String grad = gradients[idx % gradients.length];
               String petType = pet.getType() != null ? pet.getType().toLowerCase() : "";
               String icon;
               if (petType.contains("dog")) icon = "fa-dog";
               else if (petType.contains("cat")) icon = "fa-cat";
               else if (petType.contains("bird") || petType.contains("parrot") || petType.contains("canary")) icon = "fa-dove";
               else if (petType.contains("rabbit") || petType.contains("bunny")) icon = "fa-carrot";
               else if (petType.contains("fish")) icon = "fa-fish";
               else if (petType.contains("turtle")) icon = "fa-shield-halved";
               else if (petType.contains("hamster") || petType.contains("guinea")) icon = "fa-paw";
               else icon = "fa-paw";
               idx++;
        %>
        <div class="pet-card"
             data-name="<%= pet.getName().toLowerCase() %>"
             data-breed="<%= pet.getBreed() != null ? pet.getBreed().toLowerCase() : "" %>"
             data-type="<%= pet.getType() != null ? pet.getType() : "" %>"
             data-gender="<%= pet.getGender() != null ? pet.getGender() : "" %>"
             data-age="<%= pet.getAge() %>">
            <div class="pet-card-header" style="background:<%= grad %>;padding:0;overflow:hidden;">
                <% if (pet.getImageUrl() != null && !pet.getImageUrl().trim().isEmpty()) { %>
                    <img src="<%= pet.getImageUrl() %>" alt="<%= pet.getName() %>"
                         style="width:100%;height:100%;object-fit:cover;display:block;"
                         onerror="this.style.display='none';this.nextElementSibling.style.display='flex';">
                    <div style="display:none;width:100%;height:100%;align-items:center;justify-content:center;font-size:48px;background:<%= grad %>;">
                        <i class="fas <%= icon %>" style="color:rgba(255,255,255,0.9);"></i>
                    </div>
                <% } else { %>
                    <div style="width:100%;height:100%;display:flex;align-items:center;justify-content:center;font-size:48px;">
                        <i class="fas <%= icon %>" style="color:rgba(255,255,255,0.9);"></i>
                    </div>
                <% } %>
                <% if ("Available".equalsIgnoreCase(pet.getStatus())) { %>
                <span class="badge badge-available" style="position:absolute;top:12px;right:12px;">Available</span>
                <% } else { %>
                <span class="badge badge-adopted" style="position:absolute;top:12px;right:12px;">Adopted</span>
                <% } %>
            </div>
            <div class="pet-card-body">
                <h3><%= pet.getName() %></h3>
                <div class="pet-meta">
                    <div class="pet-meta-row">
                        <i class="fas fa-tag"></i>
                        <span>Type: <strong><%= pet.getType() != null ? pet.getType() : "-" %></strong></span>
                    </div>
                    <div class="pet-meta-row">
                        <i class="fas fa-dna"></i>
                        <span>Breed: <strong><%= pet.getBreed() != null ? pet.getBreed() : "-" %></strong></span>
                    </div>
                    <div class="pet-meta-row">
                        <i class="fas fa-birthday-cake"></i>
                        <span>Age: <strong><%= pet.getAge() %> yr(s)</strong></span>
                    </div>
                    <div class="pet-meta-row">
                        <i class="fas fa-venus-mars"></i>
                        <span>Gender: <strong><%= pet.getGender() != null ? pet.getGender() : "-" %></strong></span>
                    </div>
                </div>
            </div>
            <% if ("Available".equalsIgnoreCase(pet.getStatus())) { %>
            <div class="pet-card-footer">
                <form method="post" action="${pageContext.request.contextPath}/my-applications" style="margin:0;">
                    <input type="hidden" name="petId" value="<%= pet.getPetId() %>">
                    <button type="submit" class="btn btn-primary" style="padding:8px 14px;font-size:12px;">
                        <i class="fas fa-file-alt"></i> Apply
                    </button>
                </form>
                <form method="post" action="${pageContext.request.contextPath}/my-favourites" style="margin:0;">
                    <input type="hidden" name="petId" value="<%= pet.getPetId() %>">
                    <input type="hidden" name="action" value="add">
                    <button type="submit" class="btn btn-warning" style="padding:8px 14px;font-size:12px;">
                        <i class="fas fa-heart"></i> Save
                    </button>
                </form>
                <a href="${pageContext.request.contextPath}/my-visits?petId=<%= pet.getPetId() %>" class="btn btn-info" style="padding:8px 14px;font-size:12px;">
                    <i class="fas fa-calendar-alt"></i> Visit
                </a>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
    <% } %>
</main>
<script>
function filterPets() {
    var search = document.getElementById('searchInput').value.toLowerCase();
    var type   = document.getElementById('typeFilter').value;
    var gender = document.getElementById('genderFilter').value;
    var cards  = document.querySelectorAll('#petsGrid .pet-card[data-name]');
    cards.forEach(function(card) {
        var nameMatch   = card.dataset.name.includes(search) || card.dataset.breed.includes(search);
        var typeMatch   = !type   || card.dataset.type   === type;
        var genderMatch = !gender || card.dataset.gender === gender;
        card.style.display = (nameMatch && typeMatch && genderMatch) ? '' : 'none';
    });
}

function sortPets() {
    var val  = document.getElementById('sortSelect').value;
    var grid = document.getElementById('petsGrid');
    var cards = Array.from(grid.querySelectorAll('.pet-card[data-name]'));
    if (!val) return;
    cards.sort(function(a, b) {
        if (val === 'name-asc')  return a.dataset.name.localeCompare(b.dataset.name);
        if (val === 'name-desc') return b.dataset.name.localeCompare(a.dataset.name);
        if (val === 'age-asc')   return parseInt(a.dataset.age) - parseInt(b.dataset.age);
        if (val === 'age-desc')  return parseInt(b.dataset.age) - parseInt(a.dataset.age);
    });
    cards.forEach(function(c) { grid.appendChild(c); });
}
</script>
</body>
</html>
