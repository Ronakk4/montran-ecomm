<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>My Cart</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-4">
<h2>My Cart</h2>
<table class="table">
    <thead><tr><th>Product</th><th>Quantity</th><th>Price</th></tr></thead>
    <tbody id="cartTable"></tbody>
</table>
<button id="checkout" class="btn btn-success">Checkout</button>

<script>
    const token = localStorage.getItem('token');
    $('#checkout').click(function(){
        $.ajax({
            url: '/ecomm.capstone/buyer/orders',
            method: 'POST',
            headers: { 'Authorization': 'Bearer ' + token },
            contentType: 'application/json',
            data: JSON.stringify({ /* cart data here */ }),
            success: function() {
                alert('Order placed!');
                window.location.href = 'buyer-orders.jsp';
            }
        });
    });
</script>
</body>
</html>
