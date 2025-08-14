<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Seller Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-4">
<h2>Orders for My Products</h2>
<table class="table table-striped">
    <thead><tr><th>Order ID</th><th>Status</th><th>Total Amount</th></tr></thead>
    <tbody id="orderTable"></tbody>
</table>

<script>
    const token = localStorage.getItem('token');
    const sellerId = localStorage.getItem('userId');

    $.ajax({
        url: `/ecomm.capstone/seller/orders?sellerId=${sellerId}`,
        headers: { 'Authorization': 'Bearer ' + token },
        success: function(data) {
            data.forEach(o => {
                $('#orderTable').append(`
                    <tr>
                        <td>${o.orderId}</td>
                        <td>${o.status}</td>
                        <td>₹${o.totalAmount}</td>
                    </tr>
                `);
            });
        }
    });
</script>
</body>
</html>
