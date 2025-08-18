<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Buyer Registration - E-Commerce</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            min-height: 100vh;
        }
        .register-container { 
            max-width: 500px; 
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
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-custom { 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); 
            color: white; 
            border-radius: 10px; 
            padding: 12px;
            font-weight: 600;
            border: none;
            transition: all 0.3s ease;
        }
        .btn-custom:hover { 
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
        }
        .btn-outline-custom {
            border: 2px solid #667eea;
            color: #667eea;
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-outline-custom:hover {
            background: #667eea;
            color: white;
        }
        .footer-text { 
            text-align: center; 
            font-size: 14px; 
            margin-top: 20px; 
            color: #666; 
        }
        .alert {
            border-radius: 10px;
            border: none;
        }
        .form-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2 class="register-title">Join as Buyer</h2>
    
    <form id="registerForm">
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

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" class="form-control" placeholder="Create a strong password" required>
            <small class="text-muted">Must contain uppercase, lowercase, number, and special character</small>
        </div>

        <div class="mb-3">
            <label for="phoneNumber" class="form-label">Phone Number</label>
            <input type="tel" id="phoneNumber" class="form-control" placeholder="Enter your phone number" required>
        </div>

        <div class="mb-4">
            <label for="shippingAddress" class="form-label">Shipping Address</label>
            <textarea id="shippingAddress" class="form-control" rows="3" placeholder="Enter your complete shipping address" required></textarea>
        </div>

        <div class="d-grid gap-2">
            <button type="button" class="btn btn-custom" onclick="submitRegistration()">Create Buyer Account</button>
            <a href="${pageContext.request.contextPath}/app/register-seller" class="btn btn-outline-custom">Register as Seller Instead</a>
        </div>

        <p class="footer-text">
            Already have an account? <a href="${pageContext.request.contextPath}/app/login" class="text-decoration-none" style="color: #667eea; font-weight: 600;">Sign In</a>
        </p>

        <div id="messageDiv" class="mt-3"></div>
    </form>
</div>

<script>
function submitRegistration() {
    const name = document.getElementById("name").value.trim();
    const email = document.getElementById("email").value.trim();
    const password = document.getElementById("password").value;
    const phoneNumber = document.getElementById("phoneNumber").value.trim();
    const shippingAddress = document.getElementById("shippingAddress").value.trim();

    // Basic validation
    if (!name || !email || !password || !phoneNumber || !shippingAddress) {
        showMessage("All fields are required", "danger");
        return;
    }

    // Password validation
    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    if (!passwordRegex.test(password)) {
        showMessage("Password must be at least 8 characters with uppercase, lowercase, number, and special character", "danger");
        return;
    }

    const buyerData = {
        name: name,
        email: email,
        password: password,
        role: "BUYER",
        phoneNumber: phoneNumber,
        shippingAddress: shippingAddress
    };

    fetch('${pageContext.request.contextPath}/users', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(buyerData)
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
        showMessage("Registration successful! Redirecting to login...", "success");
        setTimeout(() => {
            window.location.href = '${pageContext.request.contextPath}/app/login';
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