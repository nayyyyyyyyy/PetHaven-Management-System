<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pet Haven | Create Account</title>
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
            width: 450px;
            height: 450px;
            background: radial-gradient(circle, rgba(244,217,166,0.15) 0%, transparent 70%);
            border-radius: 52% 48% 61% 39%;
            top: -120px;
            left: -100px;
            animation: float 22s ease-in-out infinite;
        }
        
        body::after {
            content: '';
            position: absolute;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(168,197,160,0.12) 0%, transparent 70%);
            border-radius: 38% 62% 55% 45%;
            bottom: -150px;
            right: -120px;
            animation: float 28s ease-in-out infinite reverse;
        }
        
        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(25px, -25px) rotate(4deg); }
        }
        
        .register-container {
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
            font-size: 68px;
            font-weight: 700;
            line-height: 1.1;
            margin-bottom: 24px;
            color: #5a5a5a;
        }
        
        .hero-side .accent {
            color: #f4d9a6;
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
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
            margin-top: 48px;
        }
        
        .stat-box {
            background: #fffef9;
            border: 3px solid #e8f3e5;
            border-radius: 24px;
            padding: 28px;
            box-shadow: 0 4px 20px rgba(168,197,160,0.12);
        }
        
        .stat-box .number {
            font-family: 'Caveat', cursive;
            font-size: 48px;
            font-weight: 700;
            color: #a8c5a0;
            margin-bottom: 8px;
        }
        
        .stat-box .label {
            font-size: 15px;
            color: #9a9a9a;
            font-weight: 600;
        }
        
        .form-side {
            flex: 0 0 480px;
            background: #fffef9;
            border: 3px solid #e8f3e5;
            border-radius: 28px;
            padding: 48px 44px;
            position: relative;
            box-shadow: 0 12px 40px rgba(168,197,160,0.15);
        }
        
        .form-header {
            text-align: center;
            margin-bottom: 36px;
        }
        
        .logo-mark {
            width: 68px;
            height: 68px;
            background: linear-gradient(135deg, #f4d9a6, #fcedc7);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 18px;
            font-size: 32px;
            color: white;
            box-shadow: 0 6px 20px rgba(244,217,166,0.35);
            border: 4px solid #fcedc7;
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
            background: #ffe8f0;
            border: 3px solid #ffc4dd;
            color: #d5006d;
            font-weight: 600;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
            margin-bottom: 18px;
        }
        
        .form-group {
            margin-bottom: 18px;
        }
        
        .form-group label {
            display: block;
            font-size: 12px;
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
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #f4d9a6;
            font-size: 16px;
        }
        
        input {
            width: 100%;
            padding: 15px 16px 15px 48px;
            background: #faf8f3;
            border: 3px solid #e8f3e5;
            border-radius: 50px;
            color: #5a5a5a;
            font-size: 14px;
            font-family: inherit;
            font-weight: 600;
            outline: none;
            transition: all 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
        }
        
        input:focus {
            border-color: #f4d9a6;
            background: white;
            box-shadow: 0 0 0 4px rgba(244,217,166,0.15);
            transform: scale(1.02);
        }
        
        input::placeholder {
            color: #c9ddc4;
        }
        
        .btn-register {
            width: 100%;
            padding: 18px;
            background: linear-gradient(135deg, #f4d9a6, #e8c78e);
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
            box-shadow: 0 6px 20px rgba(244,217,166,0.3);
        }
        
        .btn-register:hover {
            background: linear-gradient(135deg, #e8c78e, #f4d9a6);
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 25px rgba(244,217,166,0.4);
        }
        
        .divider {
            display: flex;
            align-items: center;
            gap: 18px;
            margin: 28px 0;
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
            border-color: #a8c5a0;
            background: #e8f3e5;
            color: #8fad87;
            transform: scale(1.05);
        }
        
        .footer-text {
            text-align: center;
            margin-top: 24px;
            font-size: 13px;
            color: #9a9a9a;
            font-weight: 600;
        }
        
        @media (max-width: 900px) {
            .register-container { flex-direction: column; padding: 20px; gap: 40px; }
            .hero-side { text-align: center; }
            .hero-side h1 { font-size: 52px; }
            .form-side { flex: 1; width: 100%; max-width: 500px; }
            .form-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="hero-side">
            <h1>Join the<br><span class="accent">Pet Haven</span><br>Community</h1>
            <p>Create your free account and start your journey to finding the perfect companion. Our platform makes pet adoption simple, safe, and rewarding.</p>
            
            <div class="stats-grid">
                <div class="stat-box">
                    <div class="number">500+</div>
                    <div class="label">Pets Adopted</div>
                </div>
                <div class="stat-box">
                    <div class="number">1,200+</div>
                    <div class="label">Happy Families</div>
                </div>
                <div class="stat-box">
                    <div class="number">50+</div>
                    <div class="label">Partner Shelters</div>
                </div>
                <div class="stat-box">
                    <div class="number">24/7</div>
                    <div class="label">Support Available</div>
                </div>
            </div>
        </div>
        
        <div class="form-side">
            <div class="form-header">
                <div class="logo-mark">
                    <i class="fas fa-paw"></i>
                </div>
                <h2>Create Account</h2>
                <p>Fill in your details to get started</p>
            </div>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert-box">
                    <i class="fas fa-exclamation-circle"></i>
                    <span><%= request.getAttribute("error") %></span>
                </div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label>Full Name</label>
                    <div class="input-wrapper">
                        <i class="fas fa-user"></i>
                        <input type="text" name="fullName" placeholder="John Doe" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Username</label>
                        <div class="input-wrapper">
                            <i class="fas fa-at"></i>
                            <input type="text" name="username" placeholder="johndoe" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Email</label>
                        <div class="input-wrapper">
                            <i class="fas fa-envelope"></i>
                            <input type="email" name="email" placeholder="john@example.com" required>
                        </div>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label>Password</label>
                        <div class="input-wrapper">
                            <i class="fas fa-lock"></i>
                            <input type="password" name="password" placeholder="Min 6 characters" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label>Confirm</label>
                        <div class="input-wrapper">
                            <i class="fas fa-lock"></i>
                            <input type="password" name="confirmPassword" placeholder="Re-enter password" required>
                        </div>
                    </div>
                </div>
                
                <button type="submit" class="btn-register">
                    <i class="fas fa-user-plus"></i>
                    <span>Create Account</span>
                </button>
            </form>
            
            <div class="divider">Already have an account?</div>
            
            <a href="${pageContext.request.contextPath}/login" class="link-secondary">
                Sign In Instead
            </a>
            
            <div class="footer-text">
                Pet Haven &copy; 2025 • Islington College
            </div>
        </div>
    </div>
</body>
</html>
