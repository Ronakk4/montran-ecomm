<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Checkout</title>
<%--    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>"> --%>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-4">
<h2>Checkout</h2>
<form id="checkoutForm">
    <div class="mb-3">
        <label>Shipping Address</label>
        <textarea id="address" class="form-control" required></textarea>
    </div>
    <div class="mb-3">
        <label>Payment Method</label>
        <select id="paymentMethod" class="form-select">
            <option value="COD">Cash on Delivery</option>
            <option value="CARD">Credit/Debit Card</option>
        </select>
    </div>
    <button type="submit" class="btn btn-success">Place Order</button>
</form>

<script>
    const token = localStorage.getItem('token');
    $('#checkoutForm').submit(function(e){
        e.preventDefault();
        $.ajax({
            url: '/ecomm.capstone/api/buyer/orders',
            method: 'POST',
            headers: { 'Authorization': 'Bearer ' + token },
            contentType: 'application/json',
            data: JSON.stringify({
                shippingAddress: $('#address').val(),
                paymentMethod: $('#paymentMethod').val()
            }),
            success: function() {
                alert('Order placed successfully!');
                window.location.href = 'buyer-orders.jsp';
            }
        });
    });
</script>
</body>
</html>