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
    <style>
        body {
            background: #f8f9fa;
            font-family: 'Segoe UI', sans-serif;
        }
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .page-header h2 {
            margin: 0;
            font-weight: 600;
        }
        .filters {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .card-table {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
            overflow: hidden;
        }
        table tbody tr:hover {
            background: #f1f3f5;
            transition: 0.2s;
        }
        .badge {
            font-size: 0.85rem;
        }
    </style>
</head>
<body class="container mt-4">

    <!-- HEADER -->
    <div class="page-header">
        <div class="d-flex align-items-center gap-2">
            <a href="dashboard" 
               class="btn btn-outline-secondary btn-sm">
               ← Back to Dashboard
            </a>
            <h2>📦 Orders</h2>
        </div>

        <div class="filters">
            <input type="text" id="searchBox" class="form-control form-control-sm" placeholder="🔍 Search Order ID">
            <select id="statusFilter" class="form-select form-select-sm">
                <option value="">All Status</option>
                <option value="PLACED">Placed</option>
                <option value="PENDING">Pending</option>
                <option value="SHIPPED">Shipped</option>
                <option value="DELIVERED">Delivered</option>
                <option value="CANCELLED">Cancelled</option>
            </select>
        </div>
    </div>

    <!-- ORDERS TABLE -->
    <div class="card-table">
        <table class="table table-hover align-middle mb-0">
            <thead class="table-dark">
                <tr>
                    <th>Order ID</th>
                    <th>Shipping Address</th>
                    <th>Status</th>
                    <th>Total Amount</th>
                    <th>Items</th>
                </tr>
            </thead>
            <tbody id="ordersTable">
                <tr>
                    <td colspan="5" class="text-center text-muted">Loading...</td>
                </tr>
            </tbody>
        </table>
    </div>

<script>
    const sellerId = <%= sellerId != null ? sellerId : "null" %>;
    let allOrders = [];

    function loadOrders() {
        $.get(`/ecomm.capstone/api/seller/orders?sellerId=${sellerId}`, function(data) {
            allOrders = data;
            renderOrders(allOrders);
        });
    }

    function renderOrders(orders) {
        let rows = "";
        if (orders.length === 0) {
            rows = `<tr><td colspan="5" class="text-center text-muted">No orders found.</td></tr>`;
        } else {
            orders.forEach(order => {
                let itemsHtml = "<ul class='list-unstyled mb-0'>";
                let totalAmount = 0;

                order.items.forEach(item => {
                    itemsHtml += `
                        <li>
                            🛒 <strong>${item.productName || "Product ID: " + item.productId}</strong>
                            <span class="text-muted">x${item.quantity}</span> 
                            <span class="badge bg-light text-dark ms-2">₹${item.price}</span>
                        </li>
                    `;
                    totalAmount += item.price * item.quantity;
                });
                itemsHtml += "</ul>";

                // status badge color
                let statusClass = "secondary";
                if (order.status === "DELIVERED") statusClass = "success";
                else if (order.status === "PENDING") statusClass = "warning";
                else if (order.status === "CANCELLED") statusClass = "danger";
                else if (order.status === "SHIPPED") statusClass = "info";
                else if (order.status === "PLACED") statusClass = "primary";

                rows += `
                    <tr>
                        <td><strong>#${order.orderId}</strong></td>
                        <td>📍 ${order.shippingAddress || "<span class='text-muted'>N/A</span>"}</td>
                        <td><span class="badge bg-${statusClass}">${order.status}</span></td>
                        <td><span class="fw-bold">₹${totalAmount}</span></td>
                        <td>${itemsHtml}</td>
                    </tr>
                `;
            });
        }
        $("#ordersTable").html(rows);
    }

    // --- Filters ---
    $("#statusFilter").change(function() {
        const status = $(this).val();
        let filtered = status ? allOrders.filter(o => o.status === status) : allOrders;
        renderOrders(filtered);
    });

    $("#searchBox").on("keyup", function() {
        const keyword = $(this).val().trim();
        let filtered = keyword ? allOrders.filter(o => o.orderId.toString().includes(keyword)) : allOrders;
        renderOrders(filtered);
    });

    // Init
    loadOrders();
</script>

</body>
</html>
