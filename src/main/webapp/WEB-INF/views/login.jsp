<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - E-Commerce</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background: linear-gradient(135deg, #74ebd5, #ACB6E5); 		
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
        .buyer-badge {
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
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
            border-color: #74ebd5;
            box-shadow: 0 0 0 0.2rem rgba(116, 235, 213, 0.25);
        }
        .btn-custom { 
            background: linear-gradient(135deg, #74ebd5, #ACB6E5); 
            color: white; 
            border-radius: 10px; 
            padding: 12px;
            font-weight: 600;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-custom:hover { 
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(116, 235, 213, 0.4);
        }
        .btn-outline-custom {
            border: 2px solid #74ebd5;
            color: #74ebd5;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            background: transparent;
            transition: all 0.3s ease;
        }
        .btn-outline-custom:hover {
            background: #74ebd5;
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
        .seller-link {
            color: #f5576c;
            text-decoration: none;
            font-weight: 600;
            padding: 8px 16px;
            border: 2px solid #f5576c;
            border-radius: 8px;
            display: inline-block;
            transition: all 0.3s ease;
        }
        .seller-link:hover {
            background: #f5576c;
            color: white;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="login-container">
        <div class="text-center">
            <span class="buyer-badge">BUYER PORTAL</span>
        </div>
        <h2 class="login-title">Welcome Back</h2>
        
        <form id="loginForm">
            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" id="email" class="form-control" placeholder="Enter your email" required>
            </div>

            <div class="mb-4">
                <label for="password" class="form-label">Password</label>
                <input type="password" id="password" class="form-control" placeholder="Enter your password" required>
            </div>

            <div class="d-grid">
                <button type="button" class="btn btn-custom" onclick="submitLogin()">Sign In</button>
            </div>

            <div class="switch-role">
                <p class="text-muted mb-3">Are you a seller?</p>
                <a href="${pageContext.request.contextPath}/app/seller-login" class="seller-link">Seller Login</a>
            </div>

            <p class="footer-text">
                Don't have an account? <a href="${pageContext.request.contextPath}/app/register" class="text-decoration-none" style="color: #74ebd5; font-weight: 600;">Sign up as Buyer</a>
            </p>

            <!-- Error Box -->
            <div id="errorMsg" class="alert alert-danger mt-3" style="display:none;"></div>
        </form>
    </div>
</div>
 
<script>
function validateForm(email, password) {
    let errorMsg = "";

 
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailPattern.test(email)) {
        errorMsg = "Please enter a valid email address.";
    } 
    else if(email==null || email.trim()===""){
    	errorMsg = "Please enter a email address.";
    	
    }
    else if(password==null || password.trim()==""){
    	errorMsg = "Please enter password";
    	
    }
   

    return errorMsg;
}

function submitLogin() {
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    const role = "BUYER";


    const validationError = validateForm(email, password);
    if (validationError) {
        showError(validationError);
        return;
    }

    fetch('${pageContext.request.contextPath}/users/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ email: email, password: password, role: role })
    })
    .then(res => {
        if (res.ok) {
         
            window.location.href = '${pageContext.request.contextPath}';
        } else {
           
            return res.json().catch(() => ({ message: "Invalid email or password" }));
        }
    })
    .then(data => {
        if (data && data.message) {
            showError(data.message);
        }
    })
    .catch(err => {
        showError("Server error: " + err.message);
    });
}

function showError(msg) {
    const errorBox = document.getElementById("errorMsg");
    errorBox.style.display = "block";
    errorBox.innerText = msg;
}
</script>

</body>
</html>
