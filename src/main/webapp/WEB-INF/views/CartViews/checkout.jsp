<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="com.capstone.util.JwtUtil"%>
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
    Long userId = jwtToken != null ? JwtUtil.getId(jwtToken.getValue()) : null;
    String token = jwtToken != null ? jwtToken.getValue() : "";
    
%>

<html>
<head>
    <title>Checkout</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-light">

<div class="container mt-4">
    <h2 class="text-primary">Checkout</h2>

    <!-- User Info -->
    <div id="userInfo" class="mb-4 p-3 border rounded bg-white shadow-sm"></div>

    <!-- Cart Info -->
    <h4 class="mt-3">Order Summary</h4>
    <div id="cartSummary" class="p-3 border rounded bg-white shadow-sm"></div>

    <div class="mt-3">
        <button id="placeOrderBtn" class="btn btn-success">Confirm & Place Order</button>
        <a href="${pageContext.request.contextPath}/app/cart" class="btn btn-secondary">Back to Cart</a>
    </div>
</div>

<script>
const token = "<%= jwtToken != null ? jwtToken.getValue() : "" %>";
let cartItems = [];
let grandTotal = 0;
let userID = 0;

// Load User Info
function loadUser() {
    const uid = <%= userId != null ? userId : "null" %>;
    if (!uid) return;

    $.ajax({
        url: `${pageContext.request.contextPath}/users/id/${uid}`,
        type: "GET",
        headers: { 'Authorization': 'Bearer ' + token },
        success: function(user) {
            let html = "<h5>User Details</h5>" +
                       "<p><b>Username:</b> " + user.name + "</p>" +
                       "<p><b>Shipping Address:</b> " + user.shippingAddress + "</p>";
            $("#userInfo").html(html);
            userID = user.id;
        },
        error: function(xhr) {
            console.error("Error loading user:", xhr.responseText);
            $("#userInfo").html("<div class='alert alert-danger'>Could not load user info.</div>");
        }
    });
}

// Load Cart & render summary
function loadCart() {
    $.ajax({
        url: `${pageContext.request.contextPath}/api/cart`,
        type: "GET",
        headers: { 'Authorization': 'Bearer ' + token },
        success: function(data) {
            if (!data || data.length === 0) {
                $("#cartSummary").html("<div class='alert alert-warning'>Your cart is empty.</div>");
                cartItems = [];
                grandTotal = 0;
                $("#placeOrderBtn").prop("disabled", true).addClass("disabled-btn");
                return;
            }

            cartItems = data;
            grandTotal = 0;
            let html = "<table class='table table-bordered'>" +
                       "<thead class='table-dark'><tr><th>Product</th><th>Quantity</th><th>Price</th><th>Total</th></tr></thead><tbody>";

            $.each(data, function(i, item) {
                const lineTotal = (item.productPrice * item.quantity).toFixed(2);
                grandTotal += parseFloat(lineTotal);

                html += `<tr>
                            <td>${item.productName}</td>
                            <td>${item.quantity}</td>
                            <td>${item.productPrice.toFixed(2)}</td>
                            <td>${lineTotal}</td>
                         </tr>`;
            });

            html += `<tr><td colspan='3' class='text-end'><b>Grand Total</b></td><td><b>${grandTotal.toFixed(2)}</b></td></tr>`;
            html += "</tbody></table>";

            $("#cartSummary").html(html);
            $("#placeOrderBtn").prop("disabled", false).removeClass("disabled-btn");
        },
        error: function(xhr) {
            console.error("Error loading cart:", xhr.responseText);
            $("#cartSummary").html("<div class='alert alert-danger'>Could not load cart items.</div>");
        }
    });
}

// Place Order
function placeOrder() {
    if (!cartItems || cartItems.length === 0) {
        alert("Your cart is empty. Add items before placing an order.");
        return;
    }

    // Fetch sellerId for each product
    const sellerPromises = cartItems.map(item =>
        $.ajax({
            url: `${pageContext.request.contextPath}/api/seller/products/${item.productId}`,
            type: "GET",
            headers: { 'Authorization': 'Bearer ' + token }
        }).then(product => ({
            productId: item.productId,
            sellerId: product.sellerId,
            quantity: item.quantity,
            price: item.productPrice
        }))
    );

    Promise.all(sellerPromises).then(orderItems => {
        const orderData = {
            status: "PENDING",
            totalAmount: grandTotal,
            buyerId: userID,
            items: orderItems
        };

        $.ajax({
            url: `${pageContext.request.contextPath}/buyer/orders`,
            type: "POST",
            headers: { 'Authorization': 'Bearer ' + token },
            contentType: "application/json",
            data: JSON.stringify(orderData),
            success: function(response) {
                alert("Order placed successfully!");
                window.location.href = `${pageContext.request.contextPath}/order-success`;
            },
            error: function(xhr) {
                console.error("Error placing order:", xhr.responseText);
                alert("Failed to place order. Please try again.");
            }
        });
    }).catch(err => {
        console.error("Error fetching sellerId:", err);
        alert("Could not fetch seller info. Try again later.");
    });
}

$(document).ready(function() {
    loadUser();
    loadCart();

    $("#placeOrderBtn").click(placeOrder);
});
</script>
</body>
</html>
