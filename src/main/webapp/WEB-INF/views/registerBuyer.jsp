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
        .form-control.is-invalid {
            border-color: #dc3545 !important;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.15) !important;
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
        /* Ensure alerts are visible on white card */
        .alert-danger { background-color: #f8d7da !important; color: #721c24 !important; }
        .alert-success { background-color: #d4edda !important; color: #155724 !important; }
        .alert-warning { background-color: #fff3cd !important; color: #856404 !important; }
        .alert-info    { background-color: #d1ecf1 !important; color: #0c5460 !important; }

        .form-label { font-weight: 600; color: #333; margin-bottom: 8px; }
        /* Always show invalid-feedback block so it reserves space under inputs */
        .invalid-feedback { display: block; }
    </style>
</head>
<body>

<div class="register-container">
    <h2 class="register-title">Join as Buyer</h2>

    <!-- Global message (success / general error) -->
    <div id="messageDiv" class="mb-3"></div>

    <form id="registerForm" novalidate onsubmit="submitRegistration(event)">
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="name" class="form-label">Full Name</label>
                <input type="text" id="name" class="form-control" placeholder="Enter your full name">
                <div id="nameError" class="invalid-feedback"></div>
            </div>
            <div class="col-md-6 mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" id="email" class="form-control" placeholder="Enter your email">
                <div id="emailError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" class="form-control" placeholder="Create a strong password">
            <small class="text-muted d-block mb-1">Must contain uppercase, lowercase, number, and special character</small>
            <div id="passwordError" class="invalid-feedback"></div>
        </div>

        <div class="mb-3">
            <label for="phoneNumber" class="form-label">Phone Number</label>
            <input type="tel" id="phoneNumber" class="form-control" placeholder="Enter your phone number">
            <div id="phoneError" class="invalid-feedback"></div>
        </div>

        <div class="mb-4">
            <label for="shippingAddress" class="form-label">Shipping Address</label>
            <textarea id="shippingAddress" class="form-control" rows="3" placeholder="Enter your complete shipping address"></textarea>
            <div id="addressError" class="invalid-feedback"></div>
        </div>

        <div class="d-grid gap-2">
            <button id="submitBtn" type="submit" class="btn btn-custom">Create Buyer Account</button>
            <a href="${pageContext.request.contextPath}/app/register-seller" class="btn btn-outline-custom">Register as Seller Instead</a>
        </div>

        <p class="footer-text">
            Already have an account? 
            <a href="${pageContext.request.contextPath}/app/login" class="text-decoration-none" style="color: #667eea; font-weight: 600;">Sign In</a>
        </p>
    </form>
</div>

<script>
const $ = (id) => document.getElementById(id);

function showMessage(message, type) {
    const messageDiv = $("messageDiv");
    messageDiv.innerHTML = `
      <div class="alert alert-${type} alert-dismissible fade show" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>`;
    messageDiv.scrollIntoView({behavior: 'smooth', block: 'start'});
}

function clearErrors() {
    const fields = [
        {id:"name", err:"nameError"},
        {id:"email", err:"emailError"},
        {id:"password", err:"passwordError"},
        {id:"phoneNumber", err:"phoneError"},
        {id:"shippingAddress", err:"addressError"}
    ];
    fields.forEach(f => {
        $(f.id).classList.remove("is-invalid");
        $(f.err).textContent = "";
    });
}

function setError(inputId, errId, msg) {
    $(inputId).classList.add("is-invalid");
    $(errId).textContent = msg;
}

function validate() {
    clearErrors();
    let valid = true;

    const name = $("name").value.trim();
    const email = $("email").value.trim();
    const password = $("password").value;
    const phone = $("phoneNumber").value.trim();
    const address = $("shippingAddress").value.trim();

    // Email & password regex
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
    const pwdRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    // Accept 10-15 digits, allow +, spaces, dashes
    const phoneDigits = phone.replace(/[^\d]/g, "");

    if (!name || name.length < 2) {
        setError("name", "nameError", "Please enter your full name (min 2 characters).");
        valid = false;
    }
    if (!emailRegex.test(email)) {
        setError("email", "emailError", "Please enter a valid email address.");
        valid = false;
    }
    if (!pwdRegex.test(password)) {
        setError("password", "passwordError", "Password must be 8+ chars with uppercase, lowercase, number, and special character.");
        valid = false;
    }
    if (phoneDigits.length != 10 ) {
        setError("phoneNumber", "phoneError", "Enter a valid phone number (10 digits).");
        valid = false;
    }
    if (!address || address.length < 10) {
        setError("shippingAddress", "addressError", "Please enter a complete shipping address (min 10 characters).");
        valid = false;
    }

    return { valid, data: { name, email, password, role: "BUYER", phoneNumber: phone, shippingAddress: address } };
}

async function submitRegistration(e) {
    e.preventDefault();
    const { valid, data } = validate();
    if (!valid) {
        showMessage("⚠️ Please fix the highlighted errors.", "danger");
        return;
    }

    const btn = $("submitBtn");
    btn.disabled = true;
    btn.textContent = "Creating account...";

    try {
        const res = await fetch('${pageContext.request.contextPath}/users', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(data)
        });

        const text = await res.text();

        if (res.ok) {
            showMessage("Registration successful! Redirecting to login...", "success");
            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/app/login';
            }, 1500);
        } else {
            // Show server-provided message if any
            showMessage(` ${text || "Registration failed. Please try again."}`, "danger");
        }
    } catch (err) {
        console.error("Registration error:", err);
        showMessage(" Network error. Please check your connection and try again.", "danger");
    } finally {
        btn.disabled = false;
        btn.textContent = "Create Buyer Account";
    }
}

// live validation on input
["name","email","password","phoneNumber","shippingAddress"].forEach(id => {
    $(id).addEventListener("input", () => {
        // re-validate only this field
        const before = { class: $(id).className };
        const fakeForm = validate(); // sets errors for all; we’ll immediately clear others but keep this field’s state
        // Clear others except current
        ["name","email","password","phoneNumber","shippingAddress"].forEach(other => {
            if (other !== id) {
                $(other).classList.remove("is-invalid");
                $(other + "Error").textContent = "";
            }
        });
    });
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
