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
        <button class="btn btn-success">Confirm & Place Order</button>
        <a href="${pageContext.request.contextPath}/app/cart" class="btn btn-secondary">Back to Cart</a>
    </div>
</div>

<script>




function loadCart() {
    $.get("${pageContext.request.contextPath}/api/cart", function(data) {
        if (!data || data.length === 0) {
            $("#cartSummary").html("<div class='alert alert-warning'>Your cart is empty.</div>");
            return;
        }

        let html = "<table class='table table-bordered'>" +
                   "<thead class='table-dark'>" +
                   "<tr><th>Product</th><th>Quantity</th><th>Price</th><th>Total</th></tr></thead><tbody>";

        let grandTotal = 0;

        $.each(data, function(i, item) {
            let lineTotal = (item.productPrice * item.quantity).toFixed(2);
            grandTotal += parseFloat(lineTotal);

            html += "<tr>" +
                        "<td>" + item.productName + "</td>" +
                        "<td>" + item.quantity + "</td>" +
                        "<td>" + item.productPrice + "</td>" +
                        "<td>" + lineTotal + "</td>" +
                    "</tr>";
        });

        html += "<tr><td colspan='3' class='text-end'><b>Grand Total</b></td><td><b>" + grandTotal.toFixed(2) + "</b></td></tr>";
        html += "</tbody></table>";

        $("#cartSummary").html(html);
    });
}

function loadUser() {
	 const userId = <%= userId != null ? userId : "null" %>;
	 $.get(`${pageContext.request.contextPath}/users/id/\${userId}`, function(user) {
       let html = "<h5>User Details</h5>" +
                  "<p><b>Username:</b> " + user.name + "</p>" +
                  "<p><b>Shipping Address:</b> " + user.shippingAddress + "</p>";
       $("#userInfo").html(html);
   });
}

$(document).ready(function() {
    loadUser();
    loadCart();
});
</script>

</body>
</html>
