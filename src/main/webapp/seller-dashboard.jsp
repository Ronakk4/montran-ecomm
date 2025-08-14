<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Seller Dashboard</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-4">
<h2>Seller Dashboard</h2>
<div class="row">
    <div class="col-md-6">
        <a href="seller-products.jsp" class="btn btn-primary w-100 mb-3">Manage Products</a>
    </div>
    <div class="col-md-6">
        <a href="seller-orders.jsp" class="btn btn-success w-100 mb-3">View Orders</a>
    </div>
</div>
<div id="stats" class="mt-4"></div>

<script>
    const token = localStorage.getItem('token');
    const sellerId = localStorage.getItem('userId');

    $.ajax({
        url: `/ecomm.capstone/seller/products`,
        headers: { 'Authorization': 'Bearer ' + token },
        success: function(products) {
            $('#stats').append(`<p>Total Products: ${products.length}</p>`);
        }
    });

    $.ajax({
        url: `/ecomm.capstone/seller/orders?sellerId=${sellerId}`,
        headers: { 'Authorization': 'Bearer ' + token },
        success: function(orders) {
            $('#stats').append(`<p>Total Orders: ${orders.length}</p>`);
        }
    });
</script>
</body>
</html>
