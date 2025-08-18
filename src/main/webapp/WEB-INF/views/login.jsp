<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - E-Commerce</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #74ebd5, #ACB6E5); font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .login-container { max-width: 400px; margin: 5% auto; background: #fff; border-radius: 15px; padding: 30px; box-shadow: 0 4px 20px rgba(0,0,0,0.2); }
        .login-title { font-weight: 700; color: #333; text-align: center; margin-bottom: 20px; }
        .form-select, .form-control { border-radius: 10px; }
        .btn-custom { background: #6c63ff; color: white; border-radius: 10px; }
        .btn-custom:hover { background: #5a54e2; }
        .footer-text { text-align: center; font-size: 14px; margin-top: 15px; color: #555; }
    </style>
</head>
<body>
 
<div class="login-container">
    <h2 class="login-title">Welcome Back</h2>
    
    <form id="loginForm">
        <div class="mb-3">
            <label for="loginType" class="form-label">Login as</label>
            <select id="loginType" class="form-select" required>
                <option value="">Select Role</option>
                <option value="buyer">Buyer</option>
                <option value="seller">Seller</option>
            </select>
        </div>
 
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="text" id="email" class="form-control" placeholder="Enter your email" required>
        </div>
 
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" class="form-control" placeholder="Enter your password" required>
        </div>
 
        <div class="d-grid">
            <button type="button" class="btn btn-custom" onclick="submitLogin()">Login</button>
        </div>
 
        <p class="footer-text">
            Don't have an account? <a href="signup.jsp">Sign up</a>
        </p>

 
        <div id="errorMsg" class="text-danger mt-2"></div>
    </form>
</div>
 
<script>
function submitLogin() {
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    const role = document.getElementById("loginType").value;

    fetch('${pageContext.request.contextPath}/users/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ email: email, password: password, role: role })
    })
    .then(res => {
        if(res.status === 200) {
            // redirect to homepage or dashboard
            window.location.href = '${pageContext.request.contextPath}/app/buyer/';

        } else if(res.status === 401) {
            return res.json();
        }
    })
    .then(data => {
        if(data && data.message) {
            document.getElementById("errorMsg").innerText = data.message;
        }
    })
    .catch(err => {
        document.getElementById("errorMsg").innerText = "Server error: " + err;
    });
}
</script>

</body>
</html>
 
 