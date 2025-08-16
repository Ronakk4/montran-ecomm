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
