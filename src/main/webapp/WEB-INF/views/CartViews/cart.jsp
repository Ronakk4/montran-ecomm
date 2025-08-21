<!--<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>-->
<!--<html>-->
<!--<head>-->
<!--  <title>Your Cart</title>-->
<!--  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">-->
<!--  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>-->
<!--</head>-->
<!--<body class="bg-light">-->

<!--<div class="container mt-4">-->
<!--  <h2 class="mb-3 text-primary">Your Cart</h2>-->
<!--  <div id="cartTable"></div>-->
<!--  <div class="mt-3">-->
<!--    <a href="checkout.jsp" class="btn btn-success">Proceed to Checkout</a>-->
<!--  </div>-->
<!--</div>-->

<!--<script>-->
<!--function loadCart() {-->
<!--  $.get("${pageContext.request.contextPath}/cart/data", function(data) {-->
<!--    renderCart(data);-->
<!--  });-->
<!--}-->

<!--function renderCart(data) {-->
<!--  if (!data.cart || data.cart.length === 0) {-->
<!--    $("#cartTable").html("<div class='alert alert-warning'>Your cart is empty.</div>");-->
<!--    return;-->
<!--  }-->

<!--  let html = "<table class='table table-bordered table-striped shadow'><thead class='table-dark'><tr><th>Name</th><th>Seller</th><th>Price</th><th>Qty</th><th>Total</th><th>Action</th></tr></thead><tbody>";-->
<!--  $.each(data.cart, function(i, item) {-->
<!--    html += "<tr>"-->
<!--          + "<td>" + item.productName + "</td>"-->
<!--          + "<td>" + item.sellerId + "</td>"-->
<!--          + "<td>" + item.price + "</td>"-->
<!--          + "<td>"-->
<!--          + "<button class='btn btn-sm btn-secondary' onclick='decrease(" + item.productId + ")'>-</button> "-->
<!--          + item.quantity -->
<!--          + " <button class='btn btn-sm btn-success' onclick='increase(" + item.productId + ")'>+</button>"-->
<!--          + "</td>"-->
<!--          + "<td>" + item.lineTotal + "</td>"-->
<!--          + "<td><button class='btn btn-sm btn-danger' onclick='removeItem(" + item.productId + ")'>Remove</button></td>"-->
<!--          + "</tr>";-->
<!--  });-->
<!--  html += "<tr><td colspan='4' align='right'><b>Grand Total</b></td><td colspan='2'><b>" + data.grandTotal + "</b></td></tr>";-->
<!--  html += "</tbody></table><button class='btn btn-warning' onclick='clearCart()'>Clear Cart</button>";-->
  
<!--  $("#cartTable").html(html);-->
<!--}-->

<!--function increase(id) { $.post("${pageContext.request.contextPath}/cart/add", { productId: id }, loadCart); }-->
<!--function decrease(id) { $.post("${pageContext.request.contextPath}/cart/decrease", { productId: id }, loadCart); }-->
<!--function removeItem(id) { $.post("${pageContext.request.contextPath}/cart/remove", { productId: id }, loadCart); }-->
<!--function clearCart() { $.post("${pageContext.request.contextPath}/cart/clear", loadCart); }-->

<!--$(document).ready(loadCart);-->
<!--</script>-->
<!--</body>-->
<!--</html>-->

<!--<h2>Your Cart</h2>-->
<!--<c:forEach var="item" items="${cart}">-->
<!--    <p>${item.product.name} - Qty: ${item.quantity}</p>-->
<!--    <form action="${pageContext.request.contextPath}/cart/remove/${item.product.id}" method="post">-->
<!--        <button type="submit">Remove</button>-->
<!--    </form>-->
<!--</c:forEach>-->
<!--<form action="${pageContext.request.contextPath}/buyer/checkout" method="post">-->
<!--    <button type="submit">Proceed to Checkout</button>-->
<!--</form>-->





<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
  <title>Your Cart</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    .error-msg { color: red; font-size: 0.85rem; margin-top: 3px; }
    .disabled-btn { opacity: 0.5; pointer-events: none; }
  </style>
</head>
<body class="bg-light">
<div class="container mt-4">
  <h2 class="mb-3 text-primary">Your Cart</h2>
  <div id="cartTable"></div>
  <div class="mt-3">
    <a id="checkoutBtn" href="${pageContext.request.contextPath}/app/cart/checkout" 
       class="btn btn-success">Proceed to Checkout</a>
       <a href="${pageContext.request.contextPath}" class="btn btn-primary ">Go To Home</a>
  </div>
</div>
<script>
function loadCart() {
  $.get("${pageContext.request.contextPath}/api/cart", function(data) {
    renderCart(data);
    validateCart(data); // run validation after rendering
  });
}

function renderCart(data) {
  if (!data || data.length === 0) {
    $("#cartTable").html("<div class='alert alert-warning'>Your cart is empty.</div>");
    $("#checkoutBtn").addClass("disabled-btn").prop("disabled", true);
    return;
  }

  var html = "<table class='table table-bordered table-striped shadow'>" +
               "<thead class='table-dark'>" +
                 "<tr>" +
                   "<th>Name</th>" +
                   "<th>Price</th>" +
                   "<th>Decrease Qty</th>"+
                   "<th>Qty</th>" +
                   "<th>Increase Qty</th>"+  
                   "<th>Total</th>" +
                   "<th>Action</th>" +           
                 "</tr>" +
               "</thead><tbody>";

  $.each(data, function(i, item) {
    var lineTotal = (item.productPrice * item.quantity).toFixed(2);
    var disableClass = item.quantity <= 1 ? "disabled-btn" : "";

    // Validation messages placeholders
    var priceError = item.productPrice < 0 ? "<div class='error-msg'>Price cannot be negative</div>" : "";
    var qtyError = item.quantity < 1 ? "<div class='error-msg'>Quantity must be at least 1</div>" : "";

    html += "<tr>"
          + "<td>" + item.productName + "</td>"
          + "<td> ₹" + item.productPrice + priceError + "</td>"
          + "<td class='text-center'>"
              + "<button class='btn btn-sm btn-success decBtn " + disableClass + "' "
              + "onclick='decrease(" + item.productId + ", " + item.quantity + ")'>-</button>"
            + "</td>"
          + "<td>" + item.quantity + qtyError + "</td>"
          + "<td class='text-center'>"
              + "<button class='btn btn-sm btn-success' onclick='increase("+ item.productId + ", " + item.quantity +  ")'>+</button>"
            + "</td>"
          + "<td> ₹" + lineTotal + "</td>"
          + "<td><button class='btn btn-sm btn-danger' onclick='removeItem(" + item.productId + ")'>Remove</button></td>"
          + "</tr>";
  });

  html += "</tbody></table>";
  $("#cartTable").html(html);
}

function validateCart(data) {
  var invalid = false;

  $.each(data, function(i, item) {
    if (item.quantity < 1 || item.productPrice < 0) {
      invalid = true;
      return false; // break loop
    }
  });

  if (invalid || data.length === 0) {
    $("#checkoutBtn").addClass("disabled-btn").prop("disabled", true);
  } else {
    $("#checkoutBtn").removeClass("disabled-btn").prop("disabled", false);
  }
}

function removeItem(id) {
  $.ajax({
    url: "${pageContext.request.contextPath}/api/cart?prodId=" + id,
    type: "DELETE",
    success: function() {
      loadCart(); 
    },
    error: function(xhr) {
      console.error("Error removing item:", xhr.responseText);
    }
  });
}

function increase(productId, quantity) {
  $.ajax({
    url: "${pageContext.request.contextPath}/api/cart",
    type: "PUT",
    contentType: "application/json",
    data: JSON.stringify({
      productId: productId,
      quantity: quantity + 1
    }),
    success: function() {
      loadCart();
    },
    error: function(xhr) {
      console.error("Error:", xhr.responseText);
    }
  });
}

function decrease(productId, quantity) {
  if (quantity <= 1) {
    return; // block invalid action
  }
  $.ajax({
    url: "${pageContext.request.contextPath}/api/cart",
    type: "PUT",
    contentType: "application/json",
    data: JSON.stringify({
      productId: productId,
      quantity: quantity - 1
    }),
    success: function() {
      loadCart();
    },
    error: function(xhr) {
      console.error("Error:", xhr.responseText);
    }
  });
}

$(document).ready(loadCart);
</script>
</body>
</html>

