<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Quicksand:wght@400;500;600;700&family=Caveat:wght@600;700&display=swap');
        
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Quicksand', sans-serif;
            background: linear-gradient(135deg, #faf8f3 0%, #f5f2ed 100%);
            min-height: 100vh;
            display: flex;
            position: relative;
            overflow-x: hidden;
        }
        
        body::before {
            content: '';
            position: absolute;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(168,197,160,0.15) 0%, transparent 70%);
            border-radius: 38% 62% 55% 45%;
            top: -150px;
            right: -100px;
            animation: float 25s ease-in-out infinite;
        }
        
        body::after {
            content: '';
            position: absolute;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(244,217,166,0.12) 0%, transparent 70%);
            border-radius: 61% 39% 48% 52%;
            bottom: -100px;
            left: -80px;
            animation: float 20s ease-in-out infinite reverse;
        }
        
        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(20px, -20px) rotate(3deg); }
        }
        
        .login-container {
            display: flex;
            width: 100%;
            max-width: 1200px;
            margin: auto;
            padding: 40px;
            gap: 80px;
            align-items: center;
            position: relative;
            z-index: 1;
        }
        
        .hero-side {
            flex: 1;
            color: #5a5a5a;
        }
        
        .hero-side h1 {
            font-family: 'Caveat', cursive;
            font-size: 72px;
            font-weight: 700;
            line-height: 1.1;
            margin-bottom: 24px;
            color: #5a5a5a;
        }
        
        .hero-side .accent {
            color: #a8c5a0;
            position: relative;
            display: inline-block;
        }
        
        .hero-side p {
            font-size: 19px;
            color: #9a9a9a;
            line-height: 1.8;
            margin-bottom: 36px;
            font-weight: 500;
        }
        
        .feature-list {
            list-style: none;
            margin-top: 48px;
        }
        
        .feature-list li {
            display: flex;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 20px;
            font-size: 16px;
            color: #5a5a5a;
            font-weight: 600;
        }
        
        .feature-list .icon-box {
            width: 48px;
            height: 48px;
            background: #e8f3e5;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #a8c5a0;
            font-size: 20px;
            flex-shrink: 0;
            border: 3px solid #c9ddc4;
        }
        
        .form-side {
            flex: 0 0 440px;
            background: #fffef9;
            border: 3px solid #e8f3e5;
            border-radius: 28px;
            padding: 48px 44px;
            position: relative;
            box-shadow: 0 12px 40px rgba(168,197,160,0.15);
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 40px;
        }
        
        .logo-mark {
            width: 68px;
            height: 68px;
            background: linear-gradient(135deg, #a8c5a0, #c9ddc4);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 18px;
            font-size: 32px;
            color: white;
            box-shadow: 0 6px 20px rgba(168,197,160,0.35);
            border: 4px solid #e8f3e5;
        }
        
        .form-header h2 {
            font-family: 'Caveat', cursive;
            font-size: 36px;
            font-weight: 700;
            color: #5a5a5a;
            margin-bottom: 8px;
        }
        
        .form-header p {
            font-size: 15px;
            color: #9a9a9a;
            font-weight: 600;
        }
        
        .alert-box {
            padding: 16px 18px;
            border-radius: 20px;
            font-size: 14px;
            margin-bottom: 28px;
            display: flex;
            align-items: center;
            gap: 12px;
            border: 3px solid;
            font-weight: 600;
        }
        
        .alert-error {
            background: #ffe8f0;
            border-color: #ffc4dd;
            color: #d5006d;
        }
        
        .alert-success {
            background: #e8f3e5;
            border-color: #c9ddc4;
            color: #8fad87;
        }
        
        .form-group {
            margin-bottom: 22px;
        }
        
        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 700;
            color: #5a5a5a;
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }
        
        .input-wrapper {
            position: relative;
        }
        
        .input-wrapper i {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #a8c5a0;
            font-size: 17px;
        }
        
        input {
            width: 100%;
            padding: 16px 18px 16px 52px;
            background: #faf8f3;
            border: 3px solid #e8f3e5;
            border-radius: 50px;
            color: #5a5a5a;
            font-size: 15px;
            font-family: inherit;
            font-weight: 600;
            outline: none;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        }
        
        input:focus {
            border-color: #a8c5a0;
            background: white;
            box-shadow: 0 0 0 4px rgba(168,197,160,0.15);
            transform: scale(1.02);
        }
        
        input::placeholder {
            color: #c9ddc4;
        }
        
        .btn-login {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #a8c5a0, #8fad87);
            border: none;
            border-radius: 50px;
            color: white;
            font-size: 17px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            margin-top: 12px;
            font-family: inherit;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 6px 20px rgba(168,197,160,0.3);
        }
        
        .btn-login:hover {
            background: linear-gradient(135deg, #8fad87, #a8c5a0);
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 25px rgba(168,197,160,0.4);
        }
        
        .divider {
            display: flex;
            align-items: center;
            gap: 18px;
            margin: 32px 0;
            color: #9a9a9a;
            font-size: 14px;
            font-weight: 600;
        }
        
        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 3px;
            background: #e8f3e5;
            border-radius: 10px;
        }
        
        .link-secondary {
            display: block;
            text-align: center;
            padding: 14px;
            background: transparent;
            border: 3px solid #e8f3e5;
            border-radius: 50px;
            color: #5a5a5a;
            text-decoration: none;
            font-size: 15px;
            font-weight: 700;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        }
        
        .link-secondary:hover {
            border-color: #f4d9a6;
            background: #fcedc7;
            color: #e8c78e;
            transform: scale(1.05);
        }
        
        .footer-text {
            text-align: center;
            margin-top: 28px;
            font-size: 13px;
            color: #9a9a9a;
            font-weight: 600;
        }
        
        @media (max-width: 900px) {
            .login-container { flex-direction: column; padding: 20px; gap: 40px; }
            .hero-side { text-align: center; }
            .hero-side h1 { font-size: 56px; }
            .form-side { flex: 1; width: 100%; max-width: 460px; }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="hero-side">
            <h1>Welcome to<br><span class="accent">Pet Haven</span></h1>
            <p>Your trusted partner in pet adoption and shelter management. Connect with loving companions and make a real difference.</p>
            
            <ul class="feature-list">
                <li>
                    <div class="icon-box"><i class="fas fa-paw"></i></div>
                    <div>
                        <strong>Browse Available Pets</strong><br>
                        <span style="color:#9a9a9a;font-size:14px;font-weight:500;">Discover pets waiting for their forever home</span>
                    </div>
                </li>
                <li>
                    <div class="icon-box"><i class="fas fa-heart"></i></div>
                    <div>
                        <strong>Save Your Favorites</strong><br>
                        <span style="color:#9a9a9a;font-size:14px;font-weight:500;">Keep track of pets you're interested in</span>
                    </div>
                </li>
                <li>
                    <div class="icon-box"><i class="fas fa-calendar-check"></i></div>
                    <div>
                        <strong>Schedule Visits</strong><br>
                        <span style="color:#9a9a9a;font-size:14px;font-weight:500;">Book shelter visits at your convenience</span>
                    </div>
                </li>
            </ul>
        </div>
        
        <div class="form-side">
            <div class="form-header">
                <div class="logo-mark">
                    <i class="fas fa-paw"></i>
                </div>
                <h2>Sign In</h2>
                <p>Enter your credentials to continue</p>
            </div>
            
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert-box alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    <span><%= request.getAttribute("errorMessage") %></span>
                </div>
            <% } %>
            
            <% if (request.getAttribute("success") != null) { %>
                <div class="alert-box alert-success">
                    <i class="fas fa-check-circle"></i>
                    <span><%= request.getAttribute("success") %></span>
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label>Username</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user"></i>
                        <input type="text" name="username" placeholder="Enter your username" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Password</label>
                    <div class="input-wrapper">
                        <i class="fas fa-lock"></i>
                        <input type="password" name="password" placeholder="Enter your password" required>
                    </div>
                </div>
                
                <button type="submit" class="btn-login">
                    <i class="fas fa-sign-in-alt"></i>
                    <span>Sign In</span>
                </button>
            </form>
            
            <div class="divider">New to Pet Haven?</div>
            
            <a href="${pageContext.request.contextPath}/register" class="link-secondary">
                Create an Account
            </a>
            
            <div class="footer-text">
                Pet Haven &copy; 2025 • Islington College
            </div>
        </div>
    </div>
</body>
</html>
