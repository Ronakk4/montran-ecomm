<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .profile-card {
            max-width: 500px;
            margin: auto;
            margin-top: 50px;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            background-color: white;
        }
        .profile-img {
            width: 120px;
            height: 120px;
            object-fit: cover;
            border-radius: 50%;
            margin-bottom: 15px;
        }
        .btn-group-vertical .btn {
            margin-bottom: 10px;
        }
    </style>
</head>
<body class="bg-light">

<div class="container">
    <div class="profile-card text-center">
        <img src="${user.profileImageUrl != null ? user.profileImageUrl : 'https://via.placeholder.com/120'}" alt="Profile Picture" class="profile-img">
        <h4 class="mb-1">${user.fullName}</h4>
        <p class="text-muted mb-3">${user.email}</p>

        <table class="table table-borderless text-start">
            <tr>
                <th>Username</th>
                <td>${user.username}</td>
            </tr>
            <tr>
                <th>Phone</th>
                <td>${user.phone}</td>
            </tr>
            <tr>
                <th>Address</th>
                <td>${user.address}</td>
            </tr>
            <tr>
                <th>Account Type</th>
                <td>${user.accountType}</td>
            </tr>
        </table>

        <div class="btn-group-vertical w-100">
            <a href="editProfile.jsp" class="btn btn-primary">Edit Profile</a>
            <a href="changePassword.jsp" class="btn btn-warning">Change Password</a>
            <a href="logout.jsp" class="btn btn-outline-danger">Logout</a>
        </div>

        <!-- Centered My Orders / Order History -->
        <div class="mt-3">
            <c:choose>
                <c:when test="${user.accountType == 'Buyer'}">
                    <a href="myOrders.jsp" class="btn btn-success px-4">My Orders</a>
                </c:when>
                <c:when test="${user.accountType == 'Seller'}">
                    <a href="orderHistory.jsp" class="btn btn-success px-4">Order History</a>
                </c:when>
            </c:choose>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
