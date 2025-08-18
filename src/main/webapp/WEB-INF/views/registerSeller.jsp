
<%--
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Register Seller</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-5">

<h2>Register as Seller</h2>
<form id="registerSellerForm">
    <div class="mb-3">
        <label>Name</label>
        <input type="text" name="name" class="form-control" required/>
    </div>
    <div class="mb-3">
        <label>Email</label>
        <input type="email" name="email" class="form-control" required/>
    </div>
    <div class="mb-3">
        <label>Password</label>
        <input type="password" name="password" class="form-control" required/>
    </div>
    <div class="mb-3">
        <label>Shop Name</label>
        <input type="text" name="shopName" class="form-control" required/>
    </div>
    <div class="mb-3">
        <label>Shop Description</label>
        <textarea name="shopDescription" class="form-control"></textarea>
    </div>
    <div class="mb-3">
        <label>GST Number</label>
        <input type="text" name="gstNumber" class="form-control"/>
    </div>

    <button class="btn btn-primary">Register</button>
</form>

<script>
    $('#registerSellerForm').submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: '/ecomm.capstone/registerSeller',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                name: $('input[name="name"]').val(),
                email: $('input[name="email"]').val(),
                password: $('input[name="password"]').val(),
                role: 'SELLER', // fixed role
                shopName: $('input[name="shopName"]').val(),
                shopDescription: $('textarea[name="shopDescription"]').val(),
                gstNumber: $('input[name="gstNumber"]').val()
            }),
            success: function() {
                alert('Seller registration successful!');
                window.location.href = 'login.jsp';
            },
            error: function(err) {
                alert(err.responseJSON?.message || 'Registration failed');
            }
        });
    });
</script>

</body>
</html>
--%>



<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Seller Registration - E-Commerce</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            min-height: 100vh;
        }
        .register-container { 
            max-width: 600px; 
            margin: 3% auto; 
            background: #fff; 
            border-radius: 15px; 
            padding: 40px; 
            box-shadow: 0 8px 32px rgba(0,0,0,0.1); 
        }
        .register-title { 
            font-weight: 700; 
            color: #333; 
            text-align: center; 
            margin-bottom: 30px; 
            font-size: 28px;
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
        .section-title {
            color: #f5576c;
            font-weight: 600;
            font-size: 18px;
            margin-bottom: 20px;
            border-bottom: 2px solid #f5576c;
            padding-bottom: 10px;
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2 class="register-title">Join as Seller</h2>
    
    <form id="registerForm">
        <!-- Personal Information Section -->
        <div class="section-title">Personal Information</div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="name" class="form-label">Full Name</label>
                <input type="text" id="name" class="form-control" placeholder="Enter your full name" required>
            </div>
            <div class="col-md-6 mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" id="email" class="form-control" placeholder="Enter your email" required>
            </div>
        </div>

        <div class="mb-4">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" class="form-control" placeholder="Create a strong password" required>
            <small class="text-muted">Must contain uppercase, lowercase, number, and special character</small>
        </div>

        <!-- Business Information Section -->
        <div class="section-title">Business Information</div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="shopName" class="form-label">Shop Name</label>
                <input type="text" id="shopName" class="form-control" placeholder="Enter your shop name" required>
            </div>
            <div class="col-md-6 mb-3">
                <label for="gstNumber" class="form-label">GST Number</label>
                <input type="text" id="gstNumber" class="form-control" placeholder="Enter GST number" required>
            </div>
        </div>

        <div class="mb-4">
            <label for="shopDescription" class="form-label">Shop Description</label>
            <textarea id="shopDescription" class="form-control" rows="3" placeholder="Describe your business and products" required></textarea>
        </div>

        <div class="d-grid gap-2">
            <button type="button" class="btn btn-custom" onclick="submitRegistration()">Create Seller Account</button>
            <a href="${pageContext.request.contextPath}/app/register" class="btn btn-outline-custom">Register as Buyer Instead</a>
        </div>

        <p class="footer-text">
            Already have an account? <a href="${pageContext.request.contextPath}/app/seller-login" class="text-decoration-none" style="color: #f5576c; font-weight: 600;">Seller Sign In</a>
        </p>

        <div id="messageDiv" class="mt-3"></div>
    </form>
</div>

<script>
function submitRegistration() {
    const name = document.getElementById("name").value.trim();
    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value;
    const shopName = document.getElementById("shopName").value.trim();
    const shopDescription = document.getElementById("shopDescription").value.trim();
    const gstNumber = document.getElementById("gstNumber").value.trim();

    // Basic validation
    if (!name || !email || !password || !shopName || !shopDescription || !gstNumber) {
        showMessage("All fields are required", "danger");
        return;
    }

    // Password validation
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    if (!passwordRegex.test(password)) {
        showMessage("Password must be at least 8 characters with uppercase, lowercase, number, and special character", "danger");
        return;
    }

    // GST validation (basic format check)
    const gstRegex = /^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/;
    if (!gstRegex.test(gstNumber)) {
        showMessage("Please enter a valid GST number format", "warning");
        // Allow to continue as GST format can vary
    }

    const sellerData = {
        name: name,
        email: email,
        password: password,
        role: "SELLER",
        shopName: shopName,
        shopDescription: shopDescription,
        gstNumber: gstNumber
    };

    fetch('${pageContext.request.contextPath}/users/register/seller', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(sellerData)
    })
    .then(response => {
        if (response.ok) {
            return response.text();
        } else if (response.status === 400) {
            return response.text().then(text => {
                throw new Error(text || 'Registration failed');
            });
        } else {
            throw new Error('Server error occurred');
        }
    })
    .then(data => {
        showMessage("Seller registration successful! Redirecting to login...", "success");
        setTimeout(() => {
            window.location.href = '${pageContext.request.contextPath}/app/seller-login';
        }, 2000);
    })
    .catch(error => {
        console.error('Registration error:', error);
        showMessage(error.message || "Registration failed. Please try again.", "danger");
    });
}

function showMessage(message, type) {
    const messageDiv = document.getElementById("messageDiv");
    messageDiv.innerHTML = `<div class="alert alert-${type} alert-dismissible fade show" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>`;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
