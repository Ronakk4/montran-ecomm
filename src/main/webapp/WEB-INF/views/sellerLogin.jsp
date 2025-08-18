<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seller Login - E-Commerce</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .login-container { 
            max-width: 420px; 
            margin: 0 auto; 
            background: #fff; 
            border-radius: 15px; 
            padding: 40px; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.15); 
        }
        .login-title { 
            font-weight: 700; 
            color: #333; 
            text-align: center; 
            margin-bottom: 30px; 
            font-size: 28px;
        }
        .seller-badge {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            display: inline-block;
            margin-bottom: 20px;
        }
        .form-control { 
            border-radius: 10px; 
            border: 2px solid #e1e5e9;
            padding: 12px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #f5576c;
            box-shadow: 0 0 0 0.2rem rgba(245, 87, 108, 0.25);
        }
        .btn-custom { 
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); 
            color: white; 
            border-radius: 10px; 
            padding: 12px;
            font-weight: 600;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-custom:hover { 
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(245, 87, 108, 0.4);
        }
        .btn-outline-custom {
            border: 2px solid #f5576c;
            color: #f5576c;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            background: transparent;
            transition: all 0.3s ease;
        }
        .btn-outline-custom:hover {
            background: #f5576c;
            color: white;
        }
        .footer-text { 
            text-align: center; 
            font-size: 14px; 
            margin-top: 20px; 
            color: #666; 
        }
        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        .switch-role {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #e1e5e9;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="login-container">
        <div class="text-center">
            <span class="seller-badge">SELLER PORTAL</span>
        </div>
        <h2 class="login-title">Welcome Back, Seller</h2>
        
        <form id="loginForm">
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" id="email" class="form-control" placeholder="Enter your business email" required>
            </div>

            <div class="mb-4">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" class="form-control" placeholder="Enter your password" required>
            </div>

            <div class="d-grid gap-2">
                <button type="button" class="btn btn-custom" onclick="submitLogin()">Sign In to Dashboard</button>
            </div>

            <div class="switch-role">
                <p class="text-muted mb-2">Not a seller?</p>
                <a href="${pageContext.request.contextPath}/app/login" class="btn btn-outline-custom btn-sm">Buyer Login</a>
</div>
            

            <p class="footer-text">
                Don't have a seller account? <a href="${pageContext.request.contextPath}/app/register-seller" class="text-decoration-none" style="color: #f5576c; font-weight: 600;">Register as Seller</a>
            </p>
            

            <div id="errorMsg" class="alert alert-danger mt-3" style="display:none;"></div>
        </form>
    </div>
</div>
  <!-- ✅ Put script at bottom -->
    <script>
    function validateForm(email, password) {
        let errorMsg = "";

        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (email == null || email.trim() === "") {
            errorMsg = "Please enter an email address.";
        } 
        else if (!emailPattern.test(email)) {
            errorMsg = "Please enter a valid email address.";
        } 
        else if (password == null || password.trim() === "") {
            errorMsg = "Please enter password.";
        }

        return errorMsg;
    }

    function submitLogin() {
        const email = document.getElementById("email").value;
        const password = document.getElementById("password").value;
        const role = "SELLER";
        
        const validationError = validateForm(email, password);
        if (validationError) {
            showError(validationError);
            return;
        }

        fetch('/ecomm.capstone/users/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email: email, password: password, role: role })
        })
        .then(res => {
            if(res.status === 200) {
                window.location.href = '/ecomm.capstone/app/seller/dashboard';
            } else if(res.status === 401) {
            	 return res.json().catch(() => ({ message: "Invalid email or password" }));
            }
        })
        .then(data => {
            if(data && data.message) {
                showError(data.message);
            }
        })
        .catch(err => {
            showError("Server error: " + err);
        });
    }

    function showError(message) {
        const errorDiv = document.getElementById("errorMsg");
        errorDiv.style.display = "block";
        errorDiv.innerText = message;
    }
    </script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>