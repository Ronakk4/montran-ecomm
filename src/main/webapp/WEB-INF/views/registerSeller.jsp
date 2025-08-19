<%--
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
        .alert-danger {
            background-color: #f8d7da !important;
            color: #842029 !important;
            border: 1px solid #f5c2c7 !important;
        }
        .alert-success {
            background-color: #d1e7dd !important;
            color: #0f5132 !important;
            border: 1px solid #badbcc !important;
        }
        .alert-warning {
            background-color: #fff3cd !important;
            color: #664d03 !important;
            border: 1px solid #ffecb5 !important;
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

        <!-- Single reusable message box -->
        <div id="msgBox" class="alert mt-3" style="display:none;"></div>
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
        // continue anyway
    }

    const sellerData = {
        name, email, password, role: "SELLER", shopName, shopDescription, gstNumber
    };

    fetch('${pageContext.request.contextPath}/users/register/seller', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(sellerData)
    })
    .then(response => {
        if (response.ok) {
            return response.text();
        } else {
            throw new Error('Registration failed');
        }
    })
    .then(() => {
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

function showMessage(msg, type) {
    const msgBox = document.getElementById("msgBox");
    msgBox.style.display = "block";
    msgBox.className = "alert alert-" + type + " mt-3";
    msgBox.innerText = msg;
}
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

--%>

<%--
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
        .form-control.is-invalid {
            border-color: #dc3545 !important;
            box-shadow: 0 0 0 0.2rem rgba(220,53,69,.15) !important;
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
        .form-label { font-weight: 600; color: #333; margin-bottom: 8px; }
        .section-title {
            color: #f5576c;
            font-weight: 600;
            font-size: 18px;
            margin-bottom: 20px;
            border-bottom: 2px solid #f5576c;
            padding-bottom: 10px;
        }
        .alert { border-radius: 10px; border: none; }
        .invalid-feedback { display: block; }
    </style>
</head>
<body>

<div class="register-container">
    <h2 class="register-title">Join as Seller</h2>
    
    <form id="registerForm" novalidate onsubmit="submitRegistration(event)">
        <!-- Personal Information Section -->
        <div class="section-title">Personal Information</div>
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

        <div class="mb-4">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" class="form-control" placeholder="Create a strong password">
            <small class="text-muted">Must contain uppercase, lowercase, number, and special character</small>
            <div id="passwordError" class="invalid-feedback"></div>
        </div>

        <!-- Business Information Section -->
        <div class="section-title">Business Information</div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="shopName" class="form-label">Shop Name</label>
                <input type="text" id="shopName" class="form-control" placeholder="Enter your shop name">
                <div id="shopError" class="invalid-feedback"></div>
            </div>
            <div class="col-md-6 mb-3">
                <label for="gstNumber" class="form-label">GST Number</label>
                <input type="text" id="gstNumber" class="form-control" placeholder="Enter GST number">
                <div id="gstError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="mb-4">
            <label for="shopDescription" class="form-label">Shop Description</label>
            <textarea id="shopDescription" class="form-control" rows="3" placeholder="Describe your business and products"></textarea>
            <div id="descError" class="invalid-feedback"></div>
        </div>

        <div class="d-grid gap-2">
            <button id="submitBtn" type="submit" class="btn btn-custom">Create Seller Account</button>
            <a href="${pageContext.request.contextPath}/app/register" class="btn btn-outline-custom">Register as Buyer Instead</a>
        </div>

        <p class="footer-text">
            Already have an account? <a href="${pageContext.request.contextPath}/app/seller-login" class="text-decoration-none" style="color: #f5576c; font-weight: 600;">Seller Sign In</a>
        </p>

        <!-- Single reusable message box -->
        <div id="msgBox" class="mt-3"></div>
    </form>
</div>

<script>
const $ = (id) => document.getElementById(id);

function showMessage(msg, type) {
    const box = $("msgBox");
    box.innerHTML = `<div class="alert alert-${type}">${msg}</div>`;
    box.scrollIntoView({behavior: "smooth", block: "start"});
}

function clearErrors() {
    ["name","email","password","shopName","gstNumber","shopDescription"].forEach(id=>{
        $(id).classList.remove("is-invalid");
        $(id+"Error").textContent = "";
    });
}

function setError(id,msg){
    $(id).classList.add("is-invalid");
    $(id+"Error").textContent = msg;
}

function validate(){
    clearErrors();
    let valid = true;
    const name = $("name").value.trim();
    const email = $("email").value.trim();
    const password = $("password").value;
    const shopName = $("shopName").value.trim();
    const gstNumber = $("gstNumber").value.trim();
    const shopDescription = $("shopDescription").value.trim();

    const emailRegex=/^[^\\s@]+@[^\\s@]+\\.[^\\s@]{2,}$/;
    const pwdRegex=/^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$/;
    const gstRegex=/^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/;

    if(name.length<2){setError("name","Enter full name (min 2 chars)"); valid=false;}
    if(!emailRegex.test(email)){setError("email","Enter valid email"); valid=false;}
    if(!pwdRegex.test(password)){setError("password","Password must be 8+ chars with uppercase, lowercase, number, special char."); valid=false;}
    if(shopName.length<2){setError("shopName","Enter valid shop name"); valid=false;}
    if(!gstRegex.test(gstNumber)){setError("gstNumber","Invalid GST format"); valid=false;}
    if(shopDescription.length<10){setError("shopDescription","Description must be at least 10 chars"); valid=false;}

    return {valid,data:{name,email,password,role:"SELLER",shopName,gstNumber,shopDescription}};
}

async function submitRegistration(e){
    e.preventDefault();
    const {valid,data}=validate();
    if(!valid){showMessage("⚠ Please fix highlighted errors.","danger"); return;}
    const btn=$("submitBtn");
    btn.disabled=true; btn.textContent="Creating account...";
    try{
        const res=await fetch('${pageContext.request.contextPath}/users/register/seller',{
            method:"POST", headers:{"Content-Type":"application/json"}, body:JSON.stringify(data)
        });
        const text=await res.text();
        if(res.ok){
            showMessage("Seller registration successful! Redirecting...","success");
            setTimeout(()=>window.location.href='${pageContext.request.contextPath}/app/seller-login',1500);
        }else{
            showMessage(text||"Registration failed","danger");
        }
    }catch(err){
        console.error(err);
        showMessage("Network error. Try again.","danger");
    }finally{
        btn.disabled=false; btn.textContent="Create Seller Account";
    }
}
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
        .form-control.is-invalid {
            border-color: #dc3545 !important;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.15) !important;
        }
        .form-control.is-valid {
            border-color: #28a745 !important;
            box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.15) !important;
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
        .btn-custom:disabled {
            background: #6c757d;
            transform: none;
            box-shadow: none;
            cursor: not-allowed;
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
        .alert {
            border-radius: 10px;
            border: none;
        }
        .alert-danger { background-color: #f8d7da !important; color: #842029 !important; }
        .alert-success { background-color: #d1e7dd !important; color: #0f5132 !important; }
        .alert-warning { background-color: #fff3cd !important; color: #664d03 !important; }
        .alert-info { background-color: #d1ecf1 !important; color: #0c5460 !important; }
        
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
    <h2 class="register-title">Join as Seller</h2>
    
    <!-- Global message (success / general error) -->
    <div id="messageDiv" class="mb-3"></div>
    
    <form id="registerForm" novalidate onsubmit="submitRegistration(event)">
        <!-- Personal Information Section -->
        <div class="section-title">Personal Information</div>
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

        <div class="mb-4">
            <label for="password" class="form-label">Password</label>
            <input type="password" id="password" class="form-control" placeholder="Create a strong password" required>
            <small class="text-muted">Must contain uppercase, lowercase, number, and special character</small>
            <div id="passwordError" class="invalid-feedback"></div>
            <div id="passwordValid" class="valid-feedback"></div>
        </div>

        <!-- Business Information Section -->
        <div class="section-title">Business Information</div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label for="shopName" class="form-label">Shop Name</label>
                <input type="text" id="shopName" class="form-control" placeholder="Enter your shop name" required>
                <div id="shopNameError" class="invalid-feedback"></div>
                <div id="shopNameValid" class="valid-feedback"></div>
            </div>
            <div class="col-md-6 mb-3">
                <label for="gstNumber" class="form-label">GST Number</label>
                <input type="text" id="gstNumber" class="form-control" placeholder="Enter GST number" required>
                <small class="text-muted">Format: 15 characters </small>
                <div id="gstError" class="invalid-feedback"></div>
                <div id="gstValid" class="valid-feedback"></div>
            </div>
        </div>

        <div class="mb-4">
            <label for="shopDescription" class="form-label">Shop Description</label>
            <textarea id="shopDescription" class="form-control" rows="3" placeholder="Describe your business and products" required></textarea>
            <div id="descError" class="invalid-feedback"></div>
            <div id="descValid" class="valid-feedback"></div>
        </div>

        <div class="d-grid gap-2">
            <button id="submitBtn" type="submit" class="btn btn-custom">Create Seller Account</button>
            <a href="${pageContext.request.contextPath}/app/register" class="btn btn-outline-custom">Register as Buyer Instead</a>
        </div>

        <p class="footer-text">
            Already have an account? 
            <a href="${pageContext.request.contextPath}/app/seller-login" class="text-decoration-none" style="color: #f5576c; font-weight: 600;">Seller Sign In</a>
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
        clearFieldValidation("email", "emailError", "emailValid");
        
        // Debounce email availability check
        clearTimeout(emailCheckTimeout);
        emailCheckTimeout = setTimeout(() => {
            checkEmailAvailability(email);
        }, 500);
        
        return true;
    }
}

function validatePassword() {
    const password = $("password").value;
    
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

function validateShopName() {
    const shopName = $("shopName").value.trim();
    if (!shopName) {
        setFieldError("shopName", "shopNameError", "shopNameValid", "Shop name is required.");
        return false;
    } else if (shopName.length < 2) {
        setFieldError("shopName", "shopNameError", "shopNameValid", "Shop name must be at least 2 characters long.");
        return false;
    } else if (shopName.length > 100) {
        setFieldError("shopName", "shopNameError", "shopNameValid", "Shop name cannot exceed 100 characters.");
        return false;
    } else {
        setFieldValid("shopName", "shopNameError", "shopNameValid", "Valid shop name");
        return true;
    }
}

function validateGSTNumber() {
    const gstNumber = $("gstNumber").value.trim().toUpperCase();
    $("gstNumber").value = gstNumber; // Auto-format to uppercase
    
    const gstRegex = /^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/;
    
    if (!gstNumber) {
        setFieldError("gstNumber", "gstError", "gstValid", "GST number is required.");
        return false;
    } else if (!gstRegex.test(gstNumber)) {
        setFieldError("gstNumber", "gstError", "gstValid", "Please enter a valid 15-character GST number.");
        return false;
    } else {
        setFieldValid("gstNumber", "gstError", "gstValid", "Valid GST number");
        return true;
    }
}

function validateShopDescription() {
    const description = $("shopDescription").value.trim();
    if (!description) {
        setFieldError("shopDescription", "descError", "descValid", "Shop description is required.");
        return false;
    } else if (description.length < 20) {
        setFieldError("shopDescription", "descError", "descValid", "Please provide a detailed description (minimum 20 characters).");
        return false;
    } else if (description.length > 1000) {
        setFieldError("shopDescription", "descError", "descValid", "Description is too long (maximum 1000 characters).");
        return false;
    } else {
        setFieldValid("shopDescription", "descError", "descValid", "Good description");
        return true;
    }
}

function validateForm() {
    const nameValid = validateName();
    const emailFormatValid = isValidEmail($("email").value.trim());
    const passwordValid = validatePassword();
    const shopNameValid = validateShopName();
    const gstValid = validateGSTNumber();
    const descValid = validateShopDescription();
    
    // Form is valid if all fields are valid AND email is available
    isFormValid = nameValid && emailFormatValid && isEmailValid && passwordValid && shopNameValid && gstValid && descValid;
    
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
        role: "SELLER",
        shopName: $("shopName").value.trim(),
        shopDescription: $("shopDescription").value.trim(),
        gstNumber: $("gstNumber").value.trim().toUpperCase()
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
            showMessage("✅ Seller registration successful! Redirecting to login...", "success");
            $("registerForm").reset();
            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/app/seller-login';
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
        submitBtn.textContent = "Create Seller Account";
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

$("shopName").addEventListener("input", function() {
    validateShopName();
    validateForm();
});

$("gstNumber").addEventListener("input", function() {
    validateGSTNumber();
    validateForm();
});

$("shopDescription").addEventListener("input", function() {
    validateShopDescription();
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