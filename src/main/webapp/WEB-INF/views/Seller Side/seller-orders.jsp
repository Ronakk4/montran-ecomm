<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Manage Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="container mt-4">

    <h2>Orders</h2>

    <table class="table table-bordered">
        <thead>
        <tr>
            <th>Order ID</th>
            <th>Buyer</th>
            <th>Status</th>
            <th>Total</th>
            <th>Items</th>
        </tr>
        </thead>
        <tbody id="ordersTable"></tbody>
    </table>

<script>
    // Replace with logged-in sellerId from session or context
    const sellerId = 14;  

    // Fetch seller orders
    function loadOrders() {
        $.get(`/ecomm.capstone/api/seller/orders?sellerId=${sellerId}`, function(data) {
            let rows = "";
            data.forEach(order => {
                let itemsHtml = "<ul>";
                order.items.forEach(item => {
                    itemsHtml += `<li>${item.product.name} - Qty: ${item.quantity}, Price: ${item.price}</li>`;
                });
                itemsHtml += "</ul>";

                rows += `
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.buyer ? order.buyer.name : "N/A"}</td>
                        <td>${order.status}</td>
                        <td>${order.totalAmount}</td>
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
