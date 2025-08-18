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
    
    Long sellerId = jwtToken != null ? JwtUtil.getId(jwtToken.getValue()) : null;

%>
<html>
<head>
    <title>Seller Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="container mt-4">

    <h2 class="mb-4">📦 Orders</h2>

    <table class="table table-striped table-bordered align-middle">
        <thead class="table-dark">
        <tr>
            <th>Order ID</th>
            <th>Shipping Address</th>
            <th>Status</th>
            <th>Total Amount</th>
            <th>Items</th>
        </tr>
        </thead>
        <tbody id="ordersTable"></tbody>
    </table>

<script>
	const sellerId = <%= sellerId != null ? sellerId : "null" %>;
	console.log(sellerId)
    function loadOrders() {
        $.get(`/ecomm.capstone/api/seller/orders?sellerId=${sellerId}`, function(data) {
            let rows = "";
            let total
            data.forEach(order => {
                let itemsHtml = "<ul class='mb-0'>";
                let totalAmount = 0;
                order.items.forEach(item => {
                    itemsHtml += `<li>Product ID: ${item.productId} - Qty: ${item.quantity}, Price: ₹${item.price}</li>`;
                    totalAmount+= item.price*item.quantity;
                });
                itemsHtml += "</ul>";

                rows += `
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.shippingAddress ? order.shippingAddress : "N/A"}</td>
                        <td><span class="badge bg-info text-dark">${order.status}</span></td>
                        <td>₹${totalAmount}</td>
                        <td>${itemsHtml}</td>
                    </tr>`;
            });
            $("#ordersTable").html(rows);
        });
    }

    loadOrders();
</script>

</body>
</html>
