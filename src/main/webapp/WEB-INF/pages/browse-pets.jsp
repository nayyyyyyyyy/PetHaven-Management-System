<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pethaven.model.Pet, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Browse Pets</title>
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
        .alert { padding: 16px 20px; border-radius: 24px; font-size: 15px; font-weight: 600; margin-bottom: 24px; display: flex; align-items: center; gap: 12px; border: 3px solid; }
        .alert-success { background: #e8f3e5; color: #8fad87; border-color: #c9ddc4; }
        .filter-bar { background: #fffef9; border: 3px solid #e8f3e5; border-radius: 24px; padding: 18px 24px; margin-bottom: 24px; display: flex; gap: 12px; align-items: center; box-shadow: 0 4px 20px rgba(168,197,160,0.12); }
        .filter-bar i { color: #a8c5a0; font-size: 18px; }
        .filter-bar input, .filter-bar select { padding: 10px 16px; background: #faf8f3; border: 3px solid #c9ddc4; border-radius: 50px; color: #5a5a5a; font-size: 14px; font-family: inherit; font-weight: 600; outline: none; transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); }
        .filter-bar input { flex: 1; min-width: 200px; }
        .filter-bar input:focus, .filter-bar select:focus { border-color: #a8c5a0; box-shadow: 0 0 0 4px rgba(168,197,160,0.15); }
        .card { background: #fffef9; border: 3px solid #e8f3e5; border-radius: 24px; padding: 28px; margin-bottom: 24px; box-shadow: 0 4px 20px rgba(168,197,160,0.12); }
        .empty-state { text-align: center; padding: 60px 20px; color: #9a9a9a; }
        .empty-state i { font-size: 64px; margin-bottom: 16px; opacity: 0.3; display: block; color: #a8c5a0; }
        .empty-state h3 { font-size: 20px; font-weight: 700; margin-bottom: 8px; color: #5a5a5a; }
        .empty-state p { font-size: 15px; font-weight: 500; }
        .pets-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 24px; }
        .pet-card { background: #fffef9; border: 3px solid #e8f3e5; border-radius: 24px; overflow: hidden; transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); box-shadow: 0 4px 20px rgba(168,197,160,0.12); }
        .pet-card:hover { transform: translateY(-8px) rotate(-1deg); box-shadow: 0 8px 30px rgba(168,197,160,0.18); border-color: #c9ddc4; }
        .pet-card-header { height: 200px; background: linear-gradient(135deg, #e8f3e5, #ffe8d9); display: flex; align-items: center; justify-content: center; font-size: 72px; position: relative; overflow: hidden; }
        .pet-card-header img { width: 100%; height: 100%; object-fit: cover; }
        .pet-card-body { padding: 20px; }
        .pet-card-body h3 { font-family: 'Caveat', cursive; font-size: 26px; font-weight: 700; color: #5a5a5a; margin-bottom: 12px; letter-spacing: 0.5px; }
        .pet-meta { display: flex; flex-direction: column; gap: 8px; margin-bottom: 14px; }
        .pet-meta-row { display: flex; align-items: center; gap: 10px; font-size: 14px; color: #9a9a9a; font-weight: 600; }
        .pet-meta-row i { width: 20px; color: #a8c5a0; font-size: 16px; }
        .pet-meta-row strong { color: #5a5a5a; }
        .pet-card-footer { padding: 14px 20px; background: #faf8f3; border-top: 3px dashed #c9ddc4; display: flex; gap: 8px; }
        .badge { display: inline-flex; align-items: center; gap: 6px; padding: 6px 16px; border-radius: 50px; font-size: 12px; font-weight: 700; border: 2px solid; }
        .badge-available { background: #e8f3e5; color: #8fad87; border-color: #c9ddc4; }
        .badge-adopted { background: #ffe8f0; color: #d5006d; border-color: #ffc4dd; }
        .btn { display: inline-flex; align-items: center; gap: 8px; padding: 12px 24px; border: none; border-radius: 50px; font-size: 15px; font-weight: 700; cursor: pointer; text-decoration: none; transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); font-family: inherit; }
        .btn-primary { background: linear-gradient(135deg, #a8c5a0, #8fad87); color: white; box-shadow: 0 6px 20px rgba(168,197,160,0.3); }
        .btn-primary:hover { transform: translateY(-3px) scale(1.05); box-shadow: 0 8px 25px rgba(168,197,160,0.4); }
        .btn-warning { background: linear-gradient(135deg, #f4d9a6, #e8c78e); color: white; box-shadow: 0 6px 20px rgba(244,217,166,0.3); }
        .btn-warning:hover { transform: translateY(-3px) scale(1.05); }
        .btn-info { background: linear-gradient(135deg, #90caf9, #42a5f5); color: white; box-shadow: 0 6px 20px rgba(144,202,249,0.3); }
        .btn-info:hover { transform: translateY(-3px) scale(1.05); }
    </style>
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
