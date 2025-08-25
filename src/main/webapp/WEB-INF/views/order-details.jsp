<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Order Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-4">
<h2>Order Details</h2>
<div id="orderInfo"></div>
<table class="table mt-3">
    <thead><tr><th>Product</th><th>Quantity</th><th>Price</th></tr></thead>
    <tbody id="orderItems"></tbody>
</table>

<script>
    const token = localStorage.getItem('token');
    const orderId = new URLSearchParams(window.location.search).get('id');

    $.ajax({
        url: `/ecomm.capstone/api/buyer/orders/${orderId}`,
        headers: { 'Authorization': 'Bearer ' + token },
        success: function(order) {
            $('#orderInfo').html(`
                <p>Order ID: ${order.orderId}</p>
                <p>Status: ${order.status}</p>
                <p>Total Amount: ₹${order.totalAmount}</p>
            `);
            order.items.forEach(item => {
                $('#orderItems').append(`
                    <tr>
                        <td>${item.product.prodName}</td>
                        <td>${item.quantity}</td>
                        <td>₹${item.product.price}</td>
                    </tr>
                `);
            });
        }
    });
</script>
</body>
</html>
