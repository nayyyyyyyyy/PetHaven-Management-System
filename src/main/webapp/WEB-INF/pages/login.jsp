<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Login</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="login-body">
    <div class="login-wrapper">
        <div class="login-card">
            <div class="login-brand-icon"><i class="fas fa-paw" style="color:white;"></i></div>
            <div class="brand">Pet Haven</div>
            <div class="subtitle">Sign in to your account</div>

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="error-box">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>
            <% if (request.getAttribute("success") != null) { %>
                <div class="error-box" style="background:#e8f8f0;border-color:#2d7a56;color:#2d7a56;">
                    <i class="fas fa-check-circle"></i>
                    <%= request.getAttribute("success") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="text"     name="username" placeholder="Username" required>
                <input type="password" name="password" placeholder="Password" required>
                <button type="submit" class="btn-login">
                    <i class="fas fa-sign-in-alt"></i> Login
                </button>
            </form>

            <div class="login-divider">or</div>
            <a href="${pageContext.request.contextPath}/register" class="btn-register">
                <i class="fas fa-user-plus"></i> Create an Account
            </a>

            <div class="login-footer">Pet Haven Management System &copy; 2025</div>
        </div>
    </div>
</body>
</html>
