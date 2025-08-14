<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>My Profile</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-5">
<h2>My Profile</h2>
<form id="profileForm">
    <input type="hidden" id="userId">
    <div class="mb-3">
        <label>Name</label>
        <input type="text" id="name" class="form-control" required/>
    </div>
    <div class="mb-3">
        <label>Email</label>
        <input type="email" id="email" class="form-control" required/>
    </div>
    <div class="mb-3">
        <label>Password</label>
        <input type="password" id="password" class="form-control"/>
    </div>
    <button type="submit" class="btn btn-primary">Update</button>
</form>

<script>
    const token = localStorage.getItem('token');
    const userId = localStorage.getItem('userId');
    $.ajax({
        url: `/ecomm.capstone/users/${userId}`,
        headers: { 'Authorization': 'Bearer ' + token },
        success: function(user) {
            $('#userId').val(user.id);
            $('#name').val(user.name);
            $('#email').val(user.email);
        }
    });

    $('#profileForm').submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: `/ecomm.capstone/users/${userId}`,
            method: 'PUT',
            headers: { 'Authorization': 'Bearer ' + token },
            contentType: 'application/json',
            data: JSON.stringify({
                id: $('#userId').val(),
                name: $('#name').val(),
                email: $('#email').val(),
                password: $('#password').val()
            }),
            success: function() {
                alert('Profile updated successfully');
            }
        });
    });
</script>
</body>
</html>
