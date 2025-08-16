<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
	<!DOCTYPE html>
<html>
<head>
    <title>Home - Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .product-card {
            transition: all 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        }
    </style>
</head>
<body class="bg-light">
 
<!-- Header -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">MyShop</a>
        <div class="ms-auto">
            <a href="${pageContext.request.contextPath}/app/login" class="btn btn-outline-primary me-2">Login</a>
            <a href="signup.jsp" class="btn btn-primary me-2">Sign Up</a>
            <a href="cart.jsp" class="btn btn-outline-success">Cart</a>
        </div>
    </div>
</nav>
 
<!-- Search + Filter -->
<div class="container mt-4">
    <div class="row g-2">
        <div class="col-md-8">
            <input type="text" id="searchBox" class="form-control" placeholder="Search products...">
        </div>
        <div class="col-md-2">
            <button class="btn btn-secondary w-100" id="filterBtn">Filter</button>
        </div>
        <div class="col-md-2">
            <button class="btn btn-primary w-100" id="searchBtn">Search</button>
        </div>
    </div>
</div>
 
<!-- Products Section -->
<div class="container mt-4">
    <div class="row" id="productContainer">
        <!-- Product Card Example -->
        <div class="col-md-3 mb-4">
            <div class="card product-card">
                <img src="https://via.placeholder.com/250x200" class="card-img-top" alt="Product">
                <div class="card-body">
                    <h5 class="card-title">Sample Product</h5>
                    <p class="card-text text-muted">₹ 999</p>
                    <a href="#" class="btn btn-success w-100">Add to Cart</a>
                </div>
            </div>
        </div>
    </div>
</div>
 
<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // AJAX Search
    document.getElementById("searchBtn").addEventListener("click", function() {
        let query = document.getElementById("searchBox").value;
        fetch("searchProducts.jsp?query=" + encodeURIComponent(query))
            .then(res => res.text())
            .then(data => {
                document.getElementById("productContainer").innerHTML = data;
            });
    });
 
    // AJAX Filter
    document.getElementById("filterBtn").addEventListener("click", function() {
        fetch("filterProducts.jsp")
            .then(res => res.text())
            .then(data => {
                document.getElementById("productContainer").innerHTML = data;
            });
    });
</script>
</body>
</html>