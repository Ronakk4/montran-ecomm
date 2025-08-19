<%--
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

--%>

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
        .form-control.is-valid {
            border-color: #28a745 !important;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.15) !important;
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
        .btn-custom:disabled {
            background: #6c757d;
            transform: none;
            box-shadow: none;
            cursor: not-allowed;
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
        .alert-danger { background-color: #f8d7da !important; color: #721c24 !important; }
        .alert-success { background-color: #d4edda !important; color: #155724 !important; }
        .alert-warning { background-color: #fff3cd !important; color: #856404 !important; }
        .alert-info { background-color: #d1ecf1 !important; color: #0c5460 !important; }

        .form-label { font-weight: 600; color: #333; margin-bottom: 8px; }
        .invalid-feedback { display: block; min-height: 20px; margin-top: 5px; }
        .valid-feedback { 
            display: block; 
            color: #28a745; 
            font-size: 0.875rem; 
            margin-top: 5px; 
            min-height: 20px;
        }
        
        .email-check-indicator {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 16px;
        }
        .email-input-wrapper {
            position: relative;
        }
        
        .spinner-border-sm {
            width: 1rem;
            height: 1rem;
        }
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
                <input type="text" id="name" class="form-control" placeholder="Enter your full name" required>
                <div id="nameError" class="invalid-feedback"></div>
                <div id="nameValid" class="valid-feedback"></div>
            </div>
            <div class="col-md-6 mb-3">
                <label for="email" class="form-label">Email Address</label>
                <div class="email-input-wrapper">
                    <input type="email" id="email" class="form-control" placeholder="Enter your email" required>
                    <span id="emailIndicator" class="email-check-indicator"></span>
                </div>
                <div id="emailError" class="invalid-feedback"></div>
                <div id="emailValid" class="valid-feedback"></div>
            </div>
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" class="form-control" placeholder="Create a strong password" required>
            <small class="text-muted d-block mb-1">Must contain uppercase, lowercase, number, and special character</small>
            <div id="passwordError" class="invalid-feedback"></div>
            <div id="passwordValid" class="valid-feedback"></div>
        </div>

        <div class="mb-3">
            <label for="phoneNumber" class="form-label">Phone Number</label>
            <input type="tel" id="phoneNumber" class="form-control" placeholder="Enter your phone number" required>
            <div id="phoneError" class="invalid-feedback"></div>
            <div id="phoneValid" class="valid-feedback"></div>
        </div>

        <div class="mb-4">
            <label for="shippingAddress" class="form-label">Shipping Address</label>
            <textarea id="shippingAddress" class="form-control" rows="3" placeholder="Enter your complete shipping address" required></textarea>
            <div id="addressError" class="invalid-feedback"></div>
            <div id="addressValid" class="valid-feedback"></div>
        </div>

        <div class="d-grid gap-2">
            <button id="submitBtn" type="submit" class="btn btn-custom">Create Buyer Account</button>
            <a href="${pageContext.request.contextPath}/app/registerseller" class="btn btn-outline-custom">Register as Seller Instead</a>
        </div>

        <p class="footer-text">
            Already have an account? 
            <a href="${pageContext.request.contextPath}/app/login" class="text-decoration-none" style="color: #667eea; font-weight: 600;">Sign In</a>
        </p>
    </form>
</div>

<script>
const $ = (id) => document.getElementById(id);
let emailCheckTimeout;
let isEmailValid = false;
let isFormValid = false;

function showMessage(message, type) {
    const messageDiv = $("messageDiv");
    messageDiv.innerHTML = `
      <div class="alert alert-${type} alert-dismissible fade show" role="alert">
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
      </div>`;
    messageDiv.scrollIntoView({behavior: 'smooth', block: 'start'});
}

function clearFieldValidation(inputId, errId, validId) {
    $(inputId).classList.remove("is-invalid", "is-valid");
    $(errId).textContent = "";
    $(validId).textContent = "";
}

function setFieldError(inputId, errId, validId, msg) {
    $(inputId).classList.remove("is-valid");
    $(inputId).classList.add("is-invalid");
    $(errId).textContent = msg;
    $(validId).textContent = "";
}

function setFieldValid(inputId, errId, validId, msg = "") {
    $(inputId).classList.remove("is-invalid");
    $(inputId).classList.add("is-valid");
    $(errId).textContent = "";
    $(validId).textContent = msg;
}

function showEmailIndicator(type) {
    const indicator = $("emailIndicator");
    switch(type) {
        case 'loading':
            indicator.innerHTML = '<div class="spinner-border spinner-border-sm text-primary" role="status"></div>';
            break;
        case 'valid':
            indicator.innerHTML = '<span style="color: #28a745;">✓</span>';
            break;
        case 'invalid':
            indicator.innerHTML = '<span style="color: #dc3545;">✗</span>';
            break;
        case 'duplicate':
            indicator.innerHTML = '<span style="color: #dc3545;">⚠</span>';
            break;
        default:
            indicator.innerHTML = '';
    }
}

//Replace the checkEmailAvailability function with this:
async function checkEmailAvailability(email) {
    // Temporarily bypass email check - always return true
    setFieldValid("email", "emailError", "emailValid", "Email format is valid");
    showEmailIndicator('valid');
    isEmailValid = true;
    return true;
}

function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
    return emailRegex.test(email);
}

function validateName() {
    const name = $("name").value.trim();
    if (!name) {
        setFieldError("name", "nameError", "nameValid", "Name is required.");
        return false;
    } else if (name.length < 2) {
        setFieldError("name", "nameError", "nameValid", "Name must be at least 2 characters long.");
        return false;
    } else if (!/^[a-zA-Z\s]+$/.test(name)) {
        setFieldError("name", "nameError", "nameValid", "Name can only contain letters and spaces.");
        return false;
    } else {
        setFieldValid("name", "nameError", "nameValid", "Valid name");
        return true;
    }
}

function validateEmail() {
    const email = $("email").value.trim();
    if (!email) {
        setFieldError("email", "emailError", "emailValid", "Email is required.");
        showEmailIndicator('invalid');
        isEmailValid = false;
        return false;
    } else if (!isValidEmail(email)) {
        setFieldError("email", "emailError", "emailValid", "Please enter a valid email address.");
        showEmailIndicator('invalid');
        isEmailValid = false;
        return false;
    } else {
        // Clear error first, then check availability
        clearFieldValidation("email", "emailError", "emailValid");
        
        // Debounce email availability check
        clearTimeout(emailCheckTimeout);
        emailCheckTimeout = setTimeout(() => {
            checkEmailAvailability(email);
        }, 500);
        
        return true; // Format is valid, availability check is async
    }
}

function validatePassword() {
    const password = $("password").value;
    const pwdRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    
    if (!password) {
        setFieldError("password", "passwordError", "passwordValid", "Password is required.");
        return false;
    } else if (password.length < 8) {
        setFieldError("password", "passwordError", "passwordValid", "Password must be at least 8 characters long.");
        return false;
    } else if (!/(?=.*[a-z])/.test(password)) {
        setFieldError("password", "passwordError", "passwordValid", "Password must contain at least one lowercase letter.");
        return false;
    } else if (!/(?=.*[A-Z])/.test(password)) {
        setFieldError("password", "passwordError", "passwordValid", "Password must contain at least one uppercase letter.");
        return false;
    } else if (!/(?=.*\d)/.test(password)) {
        setFieldError("password", "passwordError", "passwordValid", "Password must contain at least one number.");
        return false;
    } else if (!/(?=.*[@$!%*?&])/.test(password)) {
        setFieldError("password", "passwordError", "passwordValid", "Password must contain at least one special character (@$!%*?&).");
        return false;
    } else {
        setFieldValid("password", "passwordError", "passwordValid", "Strong password");
        return true;
    }
}

function validatePhone() {
    const phone = $("phoneNumber").value.trim();
    const phoneDigits = phone.replace(/[^\d]/g, "");
    
    if (!phone) {
        setFieldError("phoneNumber", "phoneError", "phoneValid", "Phone number is required.");
        return false;
    } else if (phoneDigits.length !== 10) {
        setFieldError("phoneNumber", "phoneError", "phoneValid", "Please enter a valid 10-digit phone number.");
        return false;
    } else if (!/^[+\d\s\-()]+$/.test(phone)) {
        setFieldError("phoneNumber", "phoneError", "phoneValid", "Phone number contains invalid characters.");
        return false;
    } else {
        setFieldValid("phoneNumber", "phoneError", "phoneValid", "Valid phone number");
        return true;
    }
}

function validateAddress() {
    const address = $("shippingAddress").value.trim();
    if (!address) {
        setFieldError("shippingAddress", "addressError", "addressValid", "Shipping address is required.");
        return false;
    } else if (address.length < 10) {
        setFieldError("shippingAddress", "addressError", "addressValid", "Please enter a complete shipping address (minimum 10 characters).");
        return false;
    } else if (address.length > 500) {
        setFieldError("shippingAddress", "addressError", "addressValid", "Address is too long (maximum 500 characters).");
        return false;
    } else {
        setFieldValid("shippingAddress", "addressError", "addressValid", "Valid address");
        return true;
    }
}

function validateForm() {
    const nameValid = validateName();
    const emailFormatValid = isValidEmail($("email").value.trim());
    const passwordValid = validatePassword();
    const phoneValid = validatePhone();
    const addressValid = validateAddress();
    
    // Form is valid if all fields are valid AND email is available
    isFormValid = nameValid && emailFormatValid && isEmailValid && passwordValid && phoneValid && addressValid;
    
    // Update submit button state
    const submitBtn = $("submitBtn");
    submitBtn.disabled = !isFormValid;
    
    return isFormValid;
}

async function submitRegistration(e) {
    e.preventDefault();
    
    // Final validation before submission
    if (!validateForm()) {
        showMessage("⚠️ Please fix all highlighted errors before proceeding.", "danger");
        return;
    }

    if (!isEmailValid) {
        showMessage("⚠️ Please ensure your email address is available and valid.", "danger");
        return;
    }

    const submitBtn = $("submitBtn");
    submitBtn.disabled = true;
    submitBtn.textContent = "Creating account...";

    const formData = {
        name: $("name").value.trim(),
        email: $("email").value.trim(),
        password: $("password").value,
        role: "BUYER",
        phoneNumber: $("phoneNumber").value.trim(),
        shippingAddress: $("shippingAddress").value.trim()
    };

    try {
        const response = await fetch('${pageContext.request.contextPath}/users', {
            method: 'POST',
            headers: { 
                'Content-Type': 'application/json',
                'Accept': 'application/json'
            },
            body: JSON.stringify(formData)
        });

        const result = await response.text();

        if (response.ok) {
            showMessage("✅ Registration successful! Redirecting to login...", "success");
            $("registerForm").reset();
            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/app/login';
            }, 1500);
        } else {
            // Handle specific error responses
            if (response.status === 409) {
                showMessage("❌ Email address is already registered. Please use a different email.", "danger");
                setFieldError("email", "emailError", "emailValid", "This email is already registered.");
                showEmailIndicator('duplicate');
                isEmailValid = false;
            } else if (response.status === 400) {
                showMessage(`❌ ${result || "Invalid registration data. Please check your inputs."}`, "danger");
            } else {
                showMessage(`❌ ${result || "Registration failed. Please try again."}`, "danger");
            }
        }
    } catch (error) {
        console.error("Registration error:", error);
        showMessage("❌ Network error. Please check your connection and try again.", "danger");
    } finally {
        submitBtn.disabled = false;
        submitBtn.textContent = "Create Buyer Account";
    }
}

// Real-time validation event listeners
$("name").addEventListener("input", function() {
    validateName();
    validateForm();
});

$("email").addEventListener("input", function() {
    validateEmail();
    validateForm();
});

$("password").addEventListener("input", function() {
    validatePassword();
    validateForm();
});

$("phoneNumber").addEventListener("input", function() {
    validatePhone();
    validateForm();
});

$("shippingAddress").addEventListener("input", function() {
    validateAddress();
    validateForm();
});

// Initialize form validation state
document.addEventListener("DOMContentLoaded", function() {
    validateForm();
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>