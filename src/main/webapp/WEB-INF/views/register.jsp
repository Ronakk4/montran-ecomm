<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-5">
<h2>Register</h2>
<form id="registerForm">
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
        <label>Role</label>
        <select name="role" class="form-select">
            <option value="BUYER">Buyer</option>
            <option value="SELLER">Seller</option>
        </select>
    </div>
    <button type="submit" class="btn btn-primary">Register</button>
</form>

<script>
    $('#registerForm').submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: '/ecomm.capstone/register',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                name: $('input[name="name"]').val(),
                email: $('input[name="email"]').val(),
                password: $('input[name="password"]').val(),
                role: $('select[name="role"]').val()
            }),
            success: function() {
                alert('Registration successful!');
                window.location.href = 'login.jsp';
            },
            error: function(err) {
                alert(err.responseJSON.message || 'Registration failed');
            }
        });
    });
</script>
</body>
</html>
