<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        }
        .login-container {
            max-width: 400px;
            margin: 5% auto;
            background: #fff;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
        }
        .login-title {
            font-weight: 700;
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }
        .form-select, .form-control {
            border-radius: 10px;
        }
        .btn-custom {
            background: #6c63ff;
            color: white;
            border-radius: 10px;
        }
        .btn-custom:hover {
            background: #5a54e2;
        }
        .footer-text {
            text-align: center;
            font-size: 14px;
            margin-top: 15px;
            color: #555;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2 class="login-title">Welcome Back</h2>
    
    <form>
        <div class="mb-3">
            <label for="loginType" class="form-label">Login as</label>
            <select id="loginType" class="form-select" name="role" required>
                <option value="">Select Role</option>
                <option value="buyer">Buyer</option>
                <option value="seller">Seller</option>
            </select>
        </div>

        <div class="mb-3">
            <label for="username" class="form-label">Email or Username</label>
            <input type="text" id="username" name="username" class="form-control" placeholder="Enter your email or username" required>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
        </div>

        <div class="d-grid">
            <button type="submit" class="btn btn-custom">Login</button>
        </div>

        <p class="footer-text">
            Don't have an account? <a href="register.jsp">Sign up</a>
        </p>
    </form>
</div>

</body>
</html>
