<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>My Orders</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-4">
<h2>My Orders</h2>
<table class="table">
    <thead><tr><th>Order ID</th><th>Status</th><th>Actions</th></tr></thead>
    <tbody id="ordersTable"></tbody>
</table>

<script>
    const token = localStorage.getItem('token');
    const buyerId = localStorage.getItem('userId');

    $.ajax({
        url: `/ecomm.capstone/buyer/orders?buyerId=${buyerId}`,
        headers: { 'Authorization': 'Bearer ' + token },
        success: function(data) {
            data.forEach(o => {
                $('#ordersTable').append(`
                    <tr>
                        <td>${o.orderId}</td>
                        <td>${o.status}</td>
                        <td><a href="order-details.jsp?id=${o.orderId}" class="btn btn-info btn-sm">View</a></td>
                    </tr>
                `);
            });
        }
    });
</script>
</body>
</html>
