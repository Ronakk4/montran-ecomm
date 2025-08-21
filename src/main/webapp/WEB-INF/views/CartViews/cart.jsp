<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%
    // Extract JWT token from cookie
    Cookie jwtCookie = null;
    if(request.getCookies() != null){
        for(Cookie c : request.getCookies()){
            if("jwtToken".equals(c.getName())){
                jwtCookie = c;
                break;
            }
        }
    }
    String token = jwtCookie != null ? jwtCookie.getValue() : "";
%>
<html>
<head>
  <title>Your Cart</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    .disabled-btn { opacity: 0.5; pointer-events: none; }
    .cart-table th, .cart-table td { vertical-align: middle; text-align: center; }
    .qty-cell { min-width: 120px; }
    .stock-msg { font-size: 0.8rem; color: #dc3545; margin-top: 3px; display: block; }
  </style>
</head>
<body class="bg-light">
<div class="container mt-4">
  <h2 class="mb-3 text-primary">Your Cart</h2>
  <div id="cartTable"></div>
  <div class="mt-3">
    <button id="checkoutBtn" class="btn btn-success">Proceed to Checkout</button>
    <a href="${pageContext.request.contextPath}" class="btn btn-primary">Go To Home</a>
  </div>
</div>

<script>
function loadCart() {
  $.ajax({
    url: "${pageContext.request.contextPath}/api/cart",
    type: "GET",
    headers: { 'Authorization': 'Bearer <%= token %>' },
    success: function(data) {
      renderCart(data);
      validateCart(data);
      updateTotals(data);
    },
    error: function(xhr) { console.error("Error loading cart:", xhr.responseText); }
  });
}

function renderCart(data) {
  if (!data || data.length === 0) {
    $("#cartTable").html("<div class='alert alert-warning'>Your cart is empty.</div>");
    $("#checkoutBtn").addClass("disabled-btn").prop("disabled", true);
    return;
  }

  var html = "<table class='table table-bordered table-striped shadow cart-table'>" +
               "<thead class='table-dark'>" +
                 "<tr>" +
                   "<th>Product</th>" +
                   "<th>Price</th>" +
                   "<th>Decrease</th>"+ 
                   "<th class='qty-cell'>Qty</th>" +
                   "<th>Increase</th>"+  
                   "<th>Total</th>" +
                   "<th>Action</th>" +           
                 "</tr>" +
               "</thead><tbody>";

  $.each(data, function(i, item) {
    var lineTotal = (item.productPrice * item.quantity).toFixed(2);
    var disableDecrease = item.quantity <= 1 ? "disabled-btn" : "";
    var disableIncrease = item.quantity >= item.stockQuantity ? "disabled-btn" : "";
    var stockError = item.quantity >= item.stockQuantity 
        ? "<small class='stock-msg'>Only " + item.stockQuantity + " in stock</small>" 
        : "";

    html += "<tr data-id='"+ item.productId +"'>"
          + "<td>" + item.productName + "</td>"
          + "<td class='price'>" + item.productPrice.toFixed(2) + "</td>"
          + "<td>"
              + "<button class='btn btn-sm btn-success "+ disableDecrease +"' "
              + "onclick='decrease(" + item.productId + ", " + item.quantity + ")'>-</button>"
            + "</td>"
          + "<td class='quantity-cell'>" + item.quantity + stockError + "</td>"
          + "<td>"
              + "<button class='btn btn-sm btn-success "+ disableIncrease +"' "
              + "onclick='increase("+ item.productId + ", " + item.quantity + ", " + item.stockQuantity + ")'>+</button>"
            + "</td>"
          + "<td class='line-total'>" + lineTotal + "</td>"
          + "<td><button class='btn btn-sm btn-danger' onclick='removeItem(" + item.productId + ")'>Remove</button></td>"
          + "</tr>";
  });

  html += "</tbody></table>";
  $("#cartTable").html(html);
}

function updateTotals(data) {
  let subtotal = 0;
  $.each(data, function(i, item) {
    subtotal += item.productPrice * item.quantity;
  });
  $("#checkoutBtn").prop("disabled", subtotal === 0).toggleClass("disabled-btn", subtotal === 0);
}

function validateCart(data) {
  let invalid = false;
  $.each(data, function(i, item) {
    if(item.quantity < 1 || item.productPrice < 0) invalid = true;
  });
  $("#checkoutBtn").prop("disabled", invalid).toggleClass("disabled-btn", invalid);
}

function removeItem(id) {
  $.ajax({
    url: "${pageContext.request.contextPath}/api/cart?prodId=" + id,
    type: "DELETE",
    headers: { 'Authorization': 'Bearer <%= token %>' },
    success: loadCart,
    error: function(xhr) { console.error("Error removing item:", xhr.responseText); }
  });
}

function increase(productId, quantity, stockQuantity) {
  if(quantity >= stockQuantity) return;
  updateQuantity(productId, quantity + 1);
}

function decrease(productId, quantity) {
  if(quantity <= 1) return;
  updateQuantity(productId, quantity - 1);
}

function updateQuantity(productId, quantity) {
  $.ajax({
    url: "${pageContext.request.contextPath}/api/cart",
    type: "PUT",
    headers: { 'Authorization': 'Bearer <%= token %>' },
    contentType: "application/json",
    data: JSON.stringify({ productId: productId, quantity: quantity }),
    success: loadCart,
    error: function(xhr) { console.error("Error updating quantity:", xhr.responseText); }
  });
}

$(document).ready(function() {
  loadCart();

  $("#checkoutBtn").click(function() {
    window.location.href = "${pageContext.request.contextPath}/app/cart/checkout";
  });
});
</script>
</body>
</html>
