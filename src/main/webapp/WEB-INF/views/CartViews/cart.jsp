<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>

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
String token = jwtToken != null ? jwtToken.getValue() : null;
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
    <a id="checkoutBtn" href="${pageContext.request.contextPath}/app/cart/checkout" 
       class="btn btn-success">Proceed to Checkout</a>
    <a href="${pageContext.request.contextPath}" class="btn btn-primary">Go To Home</a>
  </div>
</div>

<script>

const jwtToken = "<%= token %>";
if (jwtToken && jwtToken !== "null") {
	  $.ajaxSetup({
	    beforeSend: function(xhr) {
	      xhr.setRequestHeader("Authorization", "Bearer " + jwtToken);
	    }
	  });
	}
function loadCart() {
  $.get("${pageContext.request.contextPath}/api/cart", function(data) {
    renderCart(data);
    validateCart(data);
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

    html += "<tr>"
          + "<td>" + item.productName + "</td>"
          + "<td>" + item.productPrice.toFixed(2) + "</td>"
          + "<td>"
              + "<button class='btn btn-sm btn-success " + disableDecrease + "' "
              + "onclick='decrease(" + item.productId + ", " + item.quantity + ")'>-</button>"
            + "</td>"
          + "<td>" + item.quantity + stockError + "</td>"
          + "<td>"
              + "<button class='btn btn-sm btn-success " + disableIncrease + "' "
              + "onclick='increase("+ item.productId + ", " + item.quantity + ", " + item.stockQuantity + ")'>+</button>"
            + "</td>"
          + "<td>" + lineTotal + "</td>"
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
      return false;
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

function increase(productId, quantity, stockQuantity) {
  if (quantity >= stockQuantity) return;
  $.ajax({
    url: "${pageContext.request.contextPath}/api/cart",
    type: "PUT",
    contentType: "application/json",
    data: JSON.stringify({
      productId: productId,
      quantity: quantity + 1
    }),
    success: function() { loadCart(); },
    error: function(xhr) { console.error("Error:", xhr.responseText); }
  });
}

function decrease(productId, quantity) {
  if (quantity <= 1) return;
  $.ajax({
    url: "${pageContext.request.contextPath}/api/cart",
    type: "PUT",
    contentType: "application/json",
    data: JSON.stringify({
      productId: productId,
      quantity: quantity - 1
    }),
    success: function() { loadCart(); },
    error: function(xhr) { console.error("Error:", xhr.responseText); }
  });
}

$(document).ready(loadCart);
</script>
</body>
</html>
