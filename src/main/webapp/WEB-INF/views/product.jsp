<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Product Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-5">
<div id="productDetails"></div>
<button id="addToCart" class="btn btn-success">Add to Cart</button>

<script>
    const urlParams = new URLSearchParams(window.location.search);
    const productId = urlParams.get('id');
    const token = localStorage.getItem('token');

    $.get(`/ecomm.capstone/products/${productId}`, function(p) {
        $('#productDetails').html(`
            <h2>${p.prodName}</h2>
            <p>${p.prodDescription}</p>
            <p>Price: ₹${p.price}</p>
            <p>Stock: ${p.stockQuantity}</p>
        `);
    });

    $('#addToCart').click(function() {
        $.ajax({
            url: '/ecomm.capstone/cart',
            method: 'POST',
            headers: { 'Authorization': 'Bearer ' + token },
            contentType: 'application/json',
            data: JSON.stringify({ productId, quantity: 1 }),
            success: function() {
                alert('Added to cart');
            }
        });
    });
</script>
</body>
</html>
