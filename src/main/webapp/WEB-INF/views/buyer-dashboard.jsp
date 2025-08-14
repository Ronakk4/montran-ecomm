<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Buyer Dashboard</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-4">
<h2>Buyer Dashboard</h2>
<a href="cart.jsp" class="btn btn-primary">View Cart</a>
<a href="buyer-orders.jsp" class="btn btn-success">My Orders</a>
<div id="stats" class="mt-4"></div>

<script>
    const token = localStorage.getItem('token');
    const buyerId = localStorage.getItem('userId');

    $.ajax({
        url: `/ecomm.capstone/buyer/orders?buyerId=${buyerId}`,
        headers: { 'Authorization': 'Bearer ' + token },
        success: function(data) {
            $('#stats').append(`<p>Total Orders: ${data.length}</p>`);
        }
    });
</script>
</body>
</html>
