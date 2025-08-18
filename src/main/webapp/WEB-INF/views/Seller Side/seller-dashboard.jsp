
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.capstone.util.JwtUtil" %>

<%
    Cookie jwtToken = null;
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if ("jwtToken".equals(cookie.getName())) {
                jwtToken = cookie;
                break;
            }
        }
    }
%>

<h2>Welcome, <%= jwtToken != null ? jwtToken : "Guest" %>!</h2>
<html>
<head>
    <title>Seller Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <!-- HEADER / NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light px-3">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/seller/dashboard">Seller Dashboard</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="products">Products</a></li>
                <li class="nav-item"><a class="nav-link" href="orders">Orders</a></li>
                <li class="nav-item"><a class="nav-link" href="profile">Profile</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout">Logout</a></li>
            </ul>
        </div>
    </nav>

    <!-- DASHBOARD CONTENT -->
    <div class="container mt-4">
        <h2>Welcome, <%= jwtToken != null ? JwtUtil.getUsername(jwtToken.getValue()) : "Guest" %>!</h2>


        <!-- QUICK STATS -->
        <div class="row mt-3">
            <div class="col-md-3">Total Orders: <b id="totalOrders">0</b></div>
            <div class="col-md-3">Products Listed: <b id="totalProducts">0</b></div>
            <div class="col-md-3">Total Sales: <b id="totalSales">₹0</b></div>
            <div class="col-md-3">Revenue This Month: <b id="monthlyRevenue">₹0</b></div>
        </div>

        <hr/>

        <!-- RECENT ORDERS -->
        <h4>Recent Orders</h4>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Buyer</th>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody id="ordersTable">
                <tr><td colspan="5" class="text-center">Loading...</td></tr>
            </tbody>
        </table>
        <a href="${pageContext.request.contextPath}/seller/orders">View All Orders</a>

        <hr/>

        <!-- PRODUCTS SUMMARY -->
        <h4>Your Products</h4>
        <ul id="productList">
            <li>Loading...</li>
        </ul>
        <a href="${pageContext.request.contextPath}/seller/products">Manage Products</a>

        <hr/>

       
        

    </div>

    <!-- AJAX -->
    <script>
        $(document).ready(function() {
//             const sellerId = "${sessionScope.sellerId}";
            const sellerId = 16;
            const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";

            // Fetch Products
            $.get(`${apiBase}/products?sellerId=${sellerId}`, function(products) {
                let list = $("#productList");
                list.empty();
                $("#totalProducts").text(products.length);

                if (products.length === 0) {
                    list.append("<li>No products found.</li>");
                } else {
                    products.forEach(p => {
                        list.append(`<li>${p.prodName} - Stock: ${p.stockQuantity}</li>`);
                    });
                }
            });

            // Fetch Orders
            $.get(`${apiBase}/orders?sellerId=${sellerId}`, function(orders) {
                let table = $("#ordersTable");
                table.empty();
                $("#totalOrders").text(orders.length);

                if (orders.length === 0) {
                    table.append("<tr><td colspan='5' class='text-center'>No orders yet.</td></tr>");
                } else {
                    orders.slice(0,5).forEach(o => {
                        table.append(`
                            <tr>
                                <td>${o.orderHeader.orderId}</td>
                                <td>${o.orderHeader.buyer.name}</td>
                                <td>${o.product.prodName}</td>
                                <td>${o.quantity}</td>
                                <td>${o.orderHeader.status}</td>
                            </tr>
                        `);
                    });
                }
            });
        });
        
        
    </script>
</body>
</html>

