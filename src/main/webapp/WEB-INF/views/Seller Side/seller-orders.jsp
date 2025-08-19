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
	function loadOrders() {
	    $.get(`/ecomm.capstone/api/seller/orders?sellerId=${sellerId}`, function(data) {
	        let rows = "";

	        if (data.length === 0) {
	            $("#ordersTable").html(`<tr><td colspan="5" class="text-center text-muted">No orders yet.</td></tr>`);
	            return;
	        }

	        data.forEach(order => {
	            let itemsHtml = "<ul class='list-unstyled mb-0'>";
	            let totalAmount = 0;

	            order.items.forEach(item => {
	                itemsHtml += `
	                    <li class="mb-1">
	                        🛒 <strong>${item.productName || "Product ID: " + item.productId}</strong> 
	                        <span class="text-muted">x${item.quantity}</span>  
	                        <span class="badge bg-light text-dark ms-2">₹${item.price}</span>
	                    </li>
	                `;
	                totalAmount += item.price * item.quantity;
	            });
	            itemsHtml += "</ul>";

	            // status colors
	            let statusClass = "secondary";
	            if (order.status === "DELIVERED") statusClass = "success";
	            else if (order.status === "PENDING") statusClass = "warning";
	            else if (order.status === "CANCELLED") statusClass = "danger";
	            else if (order.status === "SHIPPED") statusClass = "info";

	            rows += `
	                <tr class="align-middle">
	                    <td><strong>#${order.orderId}</strong></td>
	                    <td>📍 ${order.shippingAddress ? order.shippingAddress : "<span class='text-muted'>N/A</span>"}</td>
	                    <td><span class="badge bg-${statusClass}">${order.status}</span></td>
	                    <td><span class=" fw-bold">₹${totalAmount}</span></td>
	                    <td>${itemsHtml}</td>
	                </tr>
	            `;
	        });

	        $("#ordersTable").html(rows);
	    });
	}

    loadOrders();
</script>

</body>
</html>
