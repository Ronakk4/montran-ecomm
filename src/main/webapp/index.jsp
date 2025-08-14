<%--
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>SOECP - Home</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
    <script src="<c:url value='/resources/js/bootstrap.bundle.min.js'/>"></script>
</head>
<body>
<div class="container mt-4">
    <h1 class="mb-3">Welcome to Secure Online E-Commerce Platform</h1>
    <a href="login.jsp" class="btn btn-primary me-2">Login</a>
    <a href="register.jsp" class="btn btn-secondary">Register</a>

    <h3 class="mt-5">Browse Products</h3>
    <div id="productList" class="row"></div>
</div>

<script>
    $.get('/ecomm.capstone/products', function(data) {
        $('#productList').empty();
        data.forEach(function(p) {
            $('#productList').append(`
                <div class="col-md-4 mb-3">
                    <div class="card">
                        <div class="card-body">
                            <h5>${p.prodName}</h5>
                            <p>${p.prodDescription}</p>
                            <p><b>₹${p.price}</b></p>
                            <a href="product.jsp?id=${p.id}" class="btn btn-sm btn-info">View</a>
                        </div>
                    </div>
                </div>
            `);
        });
    });
</script>
</body>
</html>
--%>


<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>SOECP - Page Preview Links</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
</head>
<body class="container mt-4">
    <h1>SOECP UI Pages - Preview</h1>
    <p class="text-muted">Click on any page to view its UI (static preview, not functional backend).</p>
    <div class="list-group">

        <!-- Public Pages -->
        <a href="login.jsp" class="list-group-item list-group-item-action">Login</a>
        <a href="register.jsp" class="list-group-item list-group-item-action">Register</a>
        <a href="product-list.jsp" class="list-group-item list-group-item-action">Product List</a>
        <a href="product.jsp" class="list-group-item list-group-item-action">Product Details</a>
        <a href="search-results.jsp" class="list-group-item list-group-item-action">Search Results</a>
        <a href="about.jsp" class="list-group-item list-group-item-action">About Us</a>
        <a href="contact.jsp" class="list-group-item list-group-item-action">Contact Us</a>

        <!-- Profile -->
        <a href="profile.jsp" class="list-group-item list-group-item-action">User Profile</a>

        <!-- Seller Pages -->
        <a href="seller-dashboard.jsp" class="list-group-item list-group-item-action">Seller Dashboard</a>
        <a href="seller-products.jsp" class="list-group-item list-group-item-action">Seller Products</a>
        <a href="seller-orders.jsp" class="list-group-item list-group-item-action">Seller Orders</a>
        <a href="add-product.jsp" class="list-group-item list-group-item-action">Add Product</a>
        <a href="edit-product.jsp" class="list-group-item list-group-item-action">Edit Product</a>

        <!-- Buyer Pages -->
        <a href="buyer-dashboard.jsp" class="list-group-item list-group-item-action">Buyer Dashboard</a>
        <a href="cart.jsp" class="list-group-item list-group-item-action">Cart</a>
        <a href="buyer-orders.jsp" class="list-group-item list-group-item-action">Buyer Orders</a>
        <a href="order-details.jsp" class="list-group-item list-group-item-action">Order Details</a>
        <a href="checkout.jsp" class="list-group-item list-group-item-action">Checkout</a>

        <!-- Extra -->
        <a href="error.jsp" class="list-group-item list-group-item-action text-danger">Error Page</a>

    </div>
</body>
</html>
