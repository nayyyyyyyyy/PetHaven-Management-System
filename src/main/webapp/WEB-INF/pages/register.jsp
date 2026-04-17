<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Create Account</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="login-body">
    <div class="login-wrapper" style="max-width:460px;">
        <div class="login-card">
            <div class="login-brand-icon"><i class="fas fa-paw" style="color:white;"></i></div>
            <div class="brand">Pet Haven</div>
            <div class="subtitle">Create your free account</div>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error-box">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <input type="text"     name="fullName"        placeholder="Full Name"        required>
                <input type="text"     name="username"        placeholder="Username"         required>
                <input type="email"    name="email"           placeholder="Email Address"    required>
                <input type="password" name="password"        placeholder="Password (min 6)" required>
                <input type="password" name="confirmPassword" placeholder="Confirm Password" required>
                <button type="submit" class="btn-login" style="margin-top:10px;">
                    <i class="fas fa-user-plus"></i> Create Account
                </button>
            </form>

            <div class="login-divider">Already have an account?</div>
            <a href="${pageContext.request.contextPath}/login" class="btn-register">
                <i class="fas fa-sign-in-alt"></i> Back to Login
            </a>

            <div class="login-footer">Pet Haven Management System &copy; 2025</div>
        </div>
    </div>
</body>
</html>
