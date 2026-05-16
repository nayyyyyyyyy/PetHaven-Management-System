<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.pethaven.model.Pet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Manage Pets</title>
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
        .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; padding-bottom: 16px; border-bottom: 3px dashed #c9ddc4; }
        .card-header h2 { font-family: 'Caveat', cursive; font-size: 28px; font-weight: 700; color: #5a5a5a; letter-spacing: 0.5px; display: flex; align-items: center; gap: 10px; }
        .card-header h2 i { color: #a8c5a0; }
        .card-header span { font-size: 13px; color: #9a9a9a; }
        .add-form-bar { display: flex; gap: 12px; flex-wrap: wrap; background: #e8f3e5; border: 3px dashed #c9ddc4; border-radius: 24px; padding: 20px; }
        .add-form-bar input, .add-form-bar select { flex: 1; min-width: 140px; padding: 12px 18px; background: #fffef9; border: 3px solid #c9ddc4; border-radius: 50px; color: #5a5a5a; font-size: 14px; font-family: inherit; font-weight: 600; outline: none; transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); }
        .add-form-bar input:focus, .add-form-bar select:focus { border-color: #a8c5a0; box-shadow: 0 0 0 4px rgba(168,197,160,0.15); transform: scale(1.02); }
        .filter-bar { background: #fffef9; border: 3px solid #e8f3e5; border-radius: 24px; padding: 18px 24px; margin-bottom: 24px; display: flex; gap: 12px; align-items: center; box-shadow: 0 4px 20px rgba(168,197,160,0.12); }
        .filter-bar i { color: #a8c5a0; font-size: 18px; }
        .filter-bar input, .filter-bar select { padding: 10px 16px; background: #faf8f3; border: 3px solid #c9ddc4; border-radius: 50px; color: #5a5a5a; font-size: 14px; font-family: inherit; font-weight: 600; outline: none; transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); }
        .filter-bar input { flex: 1; min-width: 200px; }
        .filter-bar input:focus, .filter-bar select:focus { border-color: #a8c5a0; box-shadow: 0 0 0 4px rgba(168,197,160,0.15); }
        .table-wrap { background: #fffef9; border: 3px solid #e8f3e5; border-radius: 24px; overflow: hidden; box-shadow: 0 4px 20px rgba(168,197,160,0.12); }
        .table-wrap .card-header { padding: 16px 22px; border-bottom: 3px dashed #c9ddc4; }
        table { width: 100%; border-collapse: collapse; }
        thead th { background: #e8f3e5; color: #8fad87; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; padding: 16px 20px; text-align: left; border-bottom: 3px solid #c9ddc4; }
        tbody td { padding: 16px 20px; font-size: 15px; font-weight: 600; color: #5a5a5a; border-bottom: 2px solid #e8f3e5; }
        tbody tr:last-child td { border-bottom: none; }
        tbody tr:hover { background: #faf8f3; }
        .status-select { padding: 8px 14px; background: #fffef9; border: 3px solid #c9ddc4; border-radius: 50px; color: #5a5a5a; font-size: 13px; font-family: inherit; font-weight: 700; cursor: pointer; outline: none; }
        .btn { display: inline-flex; align-items: center; gap: 8px; padding: 12px 24px; border: none; border-radius: 50px; font-size: 15px; font-weight: 700; cursor: pointer; text-decoration: none; transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); font-family: inherit; }
        .btn-primary { background: linear-gradient(135deg, #a8c5a0, #8fad87); color: white; box-shadow: 0 6px 20px rgba(168,197,160,0.3); }
        .btn-primary:hover { transform: translateY(-3px) scale(1.05); box-shadow: 0 8px 25px rgba(168,197,160,0.4); }
        .btn-edit { background: linear-gradient(135deg, #ffd4b8, #ffe8d9); color: white; box-shadow: 0 6px 20px rgba(255,212,184,0.3); }
        .btn-edit:hover { transform: translateY(-3px) scale(1.05); }
        .btn-danger { background: linear-gradient(135deg, #f5a5a5, #f08080); color: white; box-shadow: 0 6px 20px rgba(245,165,165,0.3); }
        .btn-danger:hover { transform: translateY(-3px) scale(1.05); }
        .btn-soft { background: #e8f3e5; color: #8fad87; border: 3px solid #c9ddc4; }
        .btn-soft:hover { background: #c9ddc4; transform: scale(1.05); }
        .empty-state { text-align: center; padding: 60px 20px; color: #9a9a9a; }
        .empty-state i { font-size: 64px; margin-bottom: 16px; opacity: 0.3; display: block; color: #a8c5a0; }
        .empty-state h3 { font-size: 20px; font-weight: 700; margin-bottom: 8px; color: #5a5a5a; }
        .empty-state p { font-size: 15px; font-weight: 500; }
        .modal-overlay { display: none; position: fixed; inset: 0; background: rgba(90,90,90,0.6); backdrop-filter: blur(8px); z-index: 2000; align-items: center; justify-content: center; }
        .modal-overlay.open { display: flex; }
        .modal { background: #fffef9; border: 3px solid #e8f3e5; border-radius: 24px; padding: 32px; width: 100%; max-width: 560px; box-shadow: 0 8px 30px rgba(168,197,160,0.18); }
        .modal h2 { font-family: 'Caveat', cursive; font-size: 32px; font-weight: 700; color: #5a5a5a; margin-bottom: 20px; letter-spacing: 0.5px; }
        .form-row { display: flex; gap: 12px; margin-bottom: 14px; }
        .form-row input, .form-row select { flex: 1; min-width: 140px; padding: 12px 18px; background: #faf8f3; border: 3px solid #c9ddc4; border-radius: 50px; color: #5a5a5a; font-size: 14px; font-family: inherit; font-weight: 600; outline: none; transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1); }
        .form-row input:focus, .form-row select:focus { border-color: #a8c5a0; box-shadow: 0 0 0 4px rgba(168,197,160,0.15); }
        .modal-footer { display: flex; gap: 12px; justify-content: flex-end; margin-top: 20px; }
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
        <a href="${pageContext.request.contextPath}/dashboard" class="sidebar-link"><i class="fas fa-home"></i><span>Dashboard</span></a>
        <a href="${pageContext.request.contextPath}/manage-pets" class="sidebar-link active"><i class="fas fa-dog"></i><span>Manage Pets</span></a>
        <a href="${pageContext.request.contextPath}/admin-appointments" class="sidebar-link"><i class="fas fa-calendar-check"></i><span>Appointments</span></a>
        <a href="${pageContext.request.contextPath}/admin-users" class="sidebar-link"><i class="fas fa-users"></i><span>Users</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
    </div>
</aside>

<main class="main-content">
    <div class="topbar">
        <div class="topbar-left">
            <h1>Manage Pets</h1>
            <p>Add, update, or remove pets from the shelter registry</p>
        </div>
    </div>

    <!-- ADD PET FORM -->
    <div class="card" style="margin-bottom:24px;">
        <div class="card-header">
            <h2><i class="fas fa-plus-circle"></i>Add New Pet</h2>
        </div>
        <form action="${pageContext.request.contextPath}/manage-pets" method="post">
            <input type="hidden" name="formAction" value="add">
            <div class="add-form-bar">
                <input type="text"   name="name"     placeholder="Pet Name *" required>
                <input type="number" name="age"      placeholder="Age" style="max-width:80px;" min="0">
                <input type="text"   name="breed"    placeholder="Breed">
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
                <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i> Add Pet</button>
            </div>
        </form>
    </div>

    <!-- SEARCH & SORT BAR -->
    <div class="filter-bar">
        <i class="fas fa-search"></i>
        <input type="text" id="searchInput" placeholder="Search by name or breed..." oninput="filterTable()">
        <select id="typeFilter" onchange="filterTable()">
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
        <select id="statusFilter" onchange="filterTable()">
            <option value="">All Statuses</option>
            <option value="Available">Available</option>
            <option value="Adopted">Adopted</option>
        </select>
        <select id="sortSelect" onchange="sortTable()">
            <option value="">Sort by...</option>
            <option value="name-asc">Name A→Z</option>
            <option value="name-desc">Name Z→A</option>
            <option value="age-asc">Age ↑</option>
            <option value="age-desc">Age ↓</option>
        </select>
    </div>

    <!-- PET TABLE -->
    <div class="table-wrap">
        <div class="card-header">
            <h2><i class="fas fa-list"></i>Pet Registry</h2>
            <span id="petCountLabel">
                <% List<Pet> petCount = (List<Pet>) request.getAttribute("petList"); %>
                <%= petCount != null ? petCount.size() : 0 %> pets total
            </span>
        </div>
        <table id="petTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Type</th>
                    <th>Breed</th>
                    <th>Age</th>
                    <th>Gender</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="petTableBody">
                <%
                    List<Pet> pets = (List<Pet>) request.getAttribute("petList");
                    if (pets != null && !pets.isEmpty()) {
                        for (Pet p : pets) {
                %>
                <tr data-name="<%= p.getName().toLowerCase() %>"
                    data-breed="<%= p.getBreed() != null ? p.getBreed().toLowerCase() : "" %>"
                    data-type="<%= p.getType() != null ? p.getType() : "" %>"
                    data-status="<%= p.getStatus() != null ? p.getStatus() : "" %>"
                    data-age="<%= p.getAge() %>">
                    <td><span style="font-size:12px;color:var(--gray);">#<%= p.getPetId() %></span></td>
                    <td><strong><%= p.getName() %></strong></td>
                    <td><%= p.getType() != null ? p.getType() : "-" %></td>
                    <td><%= p.getBreed() != null ? p.getBreed() : "-" %></td>
                    <td><%= p.getAge() %> yr</td>
                    <td><%= p.getGender() != null ? p.getGender() : "-" %></td>
                    <td>
                        <form action="${pageContext.request.contextPath}/manage-pets" method="post" style="margin:0;">
                            <input type="hidden" name="formAction" value="update">
                            <input type="hidden" name="petId" value="<%= p.getPetId() %>">
                            <select name="status" class="status-select" onchange="this.form.submit()">
                                <option value="Available" <%= "Available".equals(p.getStatus()) ? "selected" : "" %>>Available</option>
                                <option value="Adopted"   <%= "Adopted".equals(p.getStatus())   ? "selected" : "" %>>Adopted</option>
                            </select>
                        </form>
                    </td>
                    <td style="display:flex;gap:6px;align-items:center;">
                        <button class="btn btn-edit" style="padding:7px 12px;font-size:12px;"
                            onclick="openEdit(<%= p.getPetId() %>,'<%= p.getName().replace("'","\\'") %>',<%= p.getAge() %>,'<%= p.getBreed() != null ? p.getBreed().replace("'","\\'") : "" %>','<%= p.getType() != null ? p.getType() : "" %>','<%= p.getGender() != null ? p.getGender() : "" %>','<%= p.getImageUrl() != null ? p.getImageUrl().replace("'","\\'") : "" %>')">
                            <i class="fas fa-pen"></i> Edit
                        </button>
                        <form action="${pageContext.request.contextPath}/manage-pets" method="post" style="margin:0;">
                            <input type="hidden" name="formAction" value="delete">
                            <input type="hidden" name="petId" value="<%= p.getPetId() %>">
                            <button type="submit" class="btn btn-danger" style="padding:7px 12px;font-size:12px;"
                                    onclick="return confirm('Delete <%= p.getName() %>?')">
                                <i class="fas fa-trash"></i>
                            </button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr><td colspan="8">
                    <div class="empty-state">
                        <i class="fas fa-paw"></i>
                        <h3>No pets in the registry yet</h3>
                        <p>Use the form above to add your first pet.</p>
                    </div>
                </td></tr>
                <% } %>
            </tbody>
        </table>
    </div>
</main>

<!-- EDIT MODAL -->
<div class="modal-overlay" id="editModal">
    <div class="modal">
        <h2><i class="fas fa-pen"></i>Edit Pet</h2>
        <form action="${pageContext.request.contextPath}/manage-pets" method="post">
            <input type="hidden" name="formAction" value="edit">
            <input type="hidden" name="petId" id="editPetId">
            <div class="form-row">
                <input type="text" name="name" id="editName" placeholder="Pet Name" required>
                <input type="number" name="age" id="editAge" placeholder="Age" style="max-width:90px;" min="0">
            </div>
            <div class="form-row">
                <input type="text" name="breed" id="editBreed" placeholder="Breed">
                <select name="type" id="editType">
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
                <select name="gender" id="editGender">
                    <option value="">-- Gender --</option>
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Unknown">Unknown</option>
                </select>
            </div>
            <div class="form-row">
                <input type="url" name="imageUrl" id="editImageUrl" placeholder="Image URL (optional)">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-soft" onclick="closeEdit()">Cancel</button>
                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Changes</button>
            </div>
        </form>
    </div>
</div>

<script>
function openEdit(id, name, age, breed, type, gender, imageUrl) {
    document.getElementById('editPetId').value    = id;
    document.getElementById('editName').value     = name;
    document.getElementById('editAge').value      = age;
    document.getElementById('editBreed').value    = breed;
    document.getElementById('editImageUrl').value = imageUrl;
    var typeEl   = document.getElementById('editType');
    var genderEl = document.getElementById('editGender');
    for (var i = 0; i < typeEl.options.length; i++)
        typeEl.options[i].selected = (typeEl.options[i].value === type);
    for (var i = 0; i < genderEl.options.length; i++)
        genderEl.options[i].selected = (genderEl.options[i].value === gender);
    document.getElementById('editModal').classList.add('open');
}

function closeEdit() {
    document.getElementById('editModal').classList.remove('open');
}

document.getElementById('editModal').addEventListener('click', function(e) {
    if (e.target === this) closeEdit();
});

function filterTable() {
    var search = document.getElementById('searchInput').value.toLowerCase();
    var type   = document.getElementById('typeFilter').value;
    var status = document.getElementById('statusFilter').value;
    var rows   = document.querySelectorAll('#petTableBody tr[data-name]');
    var visible = 0;
    rows.forEach(function(row) {
        var nameMatch   = row.dataset.name.includes(search) || row.dataset.breed.includes(search);
        var typeMatch   = !type   || row.dataset.type   === type;
        var statusMatch = !status || row.dataset.status === status;
        var show = nameMatch && typeMatch && statusMatch;
        row.style.display = show ? '' : 'none';
        if (show) visible++;
    });
    document.getElementById('petCountLabel').textContent = visible + ' pets shown';
}

function sortTable() {
    var val  = document.getElementById('sortSelect').value;
    var tbody = document.getElementById('petTableBody');
    var rows  = Array.from(tbody.querySelectorAll('tr[data-name]'));
    if (!val) return;
    rows.sort(function(a, b) {
        if (val === 'name-asc')  return a.dataset.name.localeCompare(b.dataset.name);
        if (val === 'name-desc') return b.dataset.name.localeCompare(a.dataset.name);
        if (val === 'age-asc')   return parseInt(a.dataset.age) - parseInt(b.dataset.age);
        if (val === 'age-desc')  return parseInt(b.dataset.age) - parseInt(a.dataset.age);
    });
    rows.forEach(function(r) { tbody.appendChild(r); });
}
</script>
</body>
</html>
