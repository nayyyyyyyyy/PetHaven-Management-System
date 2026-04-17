<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pethaven.model.User, java.util.List, java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .charts-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; margin-bottom: 28px; }
        .charts-grid-3 { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 24px; margin-bottom: 28px; }
        .chart-card { background: var(--white); border-radius: var(--radius); padding: 24px; box-shadow: var(--shadow-sm); }
        .chart-card h3 { font-size: 14px; font-weight: 700; color: var(--dark2); margin-bottom: 18px; display:flex; align-items:center; gap:8px; }
        .chart-card h3 i { color: var(--primary-dark); }
        .chart-wrap { position: relative; height: 220px; }
        .chart-wrap-sm { position: relative; height: 180px; }
        .activity-feed { background: var(--white); border-radius: var(--radius); padding: 24px; box-shadow: var(--shadow-sm); }
        .activity-feed h3 { font-size: 14px; font-weight: 700; color: var(--dark2); margin-bottom: 18px; display:flex; align-items:center; gap:8px; }
        .activity-item { display: flex; align-items: center; gap: 14px; padding: 12px 0; border-bottom: 1px solid #f0f4f8; }
        .activity-item:last-child { border-bottom: none; }
        .activity-avatar { width: 38px; height: 38px; border-radius: 12px; background: linear-gradient(135deg,var(--primary),var(--primary-dark)); display:flex; align-items:center; justify-content:center; color:white; font-weight:700; font-size:13px; flex-shrink:0; }
        .activity-info { flex: 1; }
        .activity-info p { font-size: 13px; color: var(--dark); margin: 0; }
        .activity-info p strong { color: var(--primary-text); }
        .activity-info span { font-size: 11px; color: var(--gray); }
        .quick-actions { display: grid; grid-template-columns: repeat(4, 1fr); gap: 14px; margin-bottom: 28px; }
        .quick-btn { background: var(--white); border-radius: var(--radius-sm); padding: 18px 14px; text-align: center; text-decoration: none; color: var(--dark); box-shadow: var(--shadow-sm); transition: var(--transition); border: 2px solid transparent; }
        .quick-btn:hover { border-color: var(--primary-dark); transform: translateY(-3px); box-shadow: var(--shadow-md); }
        .quick-btn i { font-size: 22px; margin-bottom: 8px; display: block; }
        .quick-btn span { font-size: 12px; font-weight: 600; }
        @media(max-width:900px){ .charts-grid,.charts-grid-3,.quick-actions{ grid-template-columns:1fr; } }
    </style>
</head>
<body>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    String displayName = (currentUser != null) ? currentUser.getFullName() : "Admin";
    String initials = (displayName.length() >= 2) ? displayName.substring(0,2).toUpperCase() : "AD";
%>

<aside class="sidebar">
    <div class="sidebar-brand">
        <div class="brand-icon"><i class="fas fa-paw"></i></div>
        <h2>Pet Haven</h2>
        <span>Admin Panel</span>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-label">Main</div>
        <a href="${pageContext.request.contextPath}/dashboard"            class="sidebar-link active"><i class="fas fa-home"></i><span>Dashboard</span></a>
        <a href="${pageContext.request.contextPath}/manage-pets"          class="sidebar-link"><i class="fas fa-dog"></i><span>Manage Pets</span></a>
        <a href="${pageContext.request.contextPath}/admin-appointments"   class="sidebar-link"><i class="fas fa-calendar-check"></i><span>Appointments</span></a>
        <a href="${pageContext.request.contextPath}/admin-users"          class="sidebar-link"><i class="fas fa-users"></i><span>Users</span></a>
    </nav>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/logout" class="sidebar-link"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
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

    <!-- STAT CARDS -->
    <div class="stats-grid" style="grid-template-columns:repeat(3,1fr);margin-bottom:28px;">
        <a href="${pageContext.request.contextPath}/manage-pets" class="stat-card" style="--stat-bg:#e8f8f0;--stat-color:#2d7a56;">
            <div class="stat-icon"><i class="fas fa-paw"></i></div>
            <div class="stat-info"><h3>Total Pets</h3><p>${totalPets != null ? totalPets : 0}</p></div>
        </a>
        <div class="stat-card" style="--stat-bg:#fff3e0;--stat-color:#e67e22;">
            <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
            <div class="stat-info"><h3>Available</h3><p>${availablePets != null ? availablePets : 0}</p></div>
        </div>
        <div class="stat-card" style="--stat-bg:#fde8f0;--stat-color:#c0392b;">
            <div class="stat-icon"><i class="fas fa-home"></i></div>
            <div class="stat-info"><h3>Adopted</h3><p>${adoptedPets != null ? adoptedPets : 0}</p></div>
        </div>
        <a href="${pageContext.request.contextPath}/admin-appointments" class="stat-card" style="--stat-bg:#fef9e7;--stat-color:#d68910;">
            <div class="stat-icon"><i class="fas fa-clock"></i></div>
            <div class="stat-info"><h3>Pending Apps</h3><p>${pendingApps != null ? pendingApps : 0}</p></div>
        </a>
        <a href="${pageContext.request.contextPath}/admin-users" class="stat-card" style="--stat-bg:#eaf2ff;--stat-color:#2980b9;">
            <div class="stat-icon"><i class="fas fa-users"></i></div>
            <div class="stat-info"><h3>Total Users</h3><p>${totalUsers != null ? totalUsers : 0}</p></div>
        </a>
        <a href="${pageContext.request.contextPath}/admin-appointments" class="stat-card" style="--stat-bg:#f0e6ff;--stat-color:#8e44ad;">
            <div class="stat-icon"><i class="fas fa-calendar-alt"></i></div>
            <div class="stat-info"><h3>Scheduled Visits</h3><p>${scheduledVisits != null ? scheduledVisits : 0}</p></div>
        </a>
    </div>

    <!-- QUICK ACTIONS -->
    <div class="quick-actions">
        <a href="${pageContext.request.contextPath}/manage-pets" class="quick-btn">
            <i class="fas fa-plus-circle" style="color:#2d7a56;"></i>
            <span>Add Pet</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin-appointments" class="quick-btn">
            <i class="fas fa-calendar-check" style="color:#2980b9;"></i>
            <span>Appointments</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin-users" class="quick-btn">
            <i class="fas fa-user-cog" style="color:#8e44ad;"></i>
            <span>Manage Users</span>
        </a>
        <a href="${pageContext.request.contextPath}/manage-pets" class="quick-btn">
            <i class="fas fa-list-alt" style="color:#e67e22;"></i>
            <span>Pet Registry</span>
        </a>
    </div>

    <!-- CHARTS ROW 1 -->
    <div class="charts-grid">
        <!-- Applications Over Time (Line) -->
        <div class="chart-card" style="grid-column:1/2;">
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
                <p style="color:var(--gray);font-size:13px;text-align:center;padding:30px 0;">No recent activity</p>
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
</main>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<script>
    Chart.defaults.font.family = "'Poppins', 'Segoe UI', sans-serif";
    Chart.defaults.color = '#8395a7';

    const palette = ['#A8E6CF','#5cb88a','#A29BFE','#FFD3B6','#FFAAA5','#81ecec','#fdcb6e'];

    // Line Chart — Applications over time
    new Chart(document.getElementById('lineChart'), {
        type: 'line',
        data: {
            labels: [${chartMonthLabels}],
            datasets: [{
                label: 'Applications',
                data: [${chartMonthCounts}],
                borderColor: '#5cb88a',
                backgroundColor: 'rgba(168,230,207,0.15)',
                borderWidth: 2.5,
                pointBackgroundColor: '#5cb88a',
                pointRadius: 5,
                tension: 0.4,
                fill: true
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                y: { beginAtZero: true, ticks: { stepSize: 1 }, grid: { color: '#f0f4f8' } },
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
                backgroundColor: ['#A8E6CF','#5cb88a','#A29BFE','#FFD3B6','#FFAAA5'],
                borderRadius: 8,
                borderSkipped: false
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false,
            plugins: { legend: { display: false } },
            scales: {
                y: { beginAtZero: true, ticks: { stepSize: 1 }, grid: { color: '#f0f4f8' } },
                x: { grid: { display: false } }
            }
        }
    });
</script>
</body>
</html>
