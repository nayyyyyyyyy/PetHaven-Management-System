<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.pethaven.model.Pet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Manage Pets</title>
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
            <h2><i class="fas fa-plus-circle" style="color:var(--green-mid);margin-right:8px;"></i>Add New Pet</h2>
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
        <i class="fas fa-search" style="color:var(--green-mid);"></i>
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
        <div class="card-header" style="padding:16px 22px; border-bottom:1px solid var(--green-pale);">
            <h2><i class="fas fa-list" style="color:var(--green-mid);margin-right:8px;"></i>Pet Registry</h2>
            <span style="font-size:13px;color:var(--gray);" id="petCountLabel">
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
        <h2><i class="fas fa-pen" style="color:var(--yellow);margin-right:8px;"></i>Edit Pet</h2>
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
