<!--<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>-->
<!--<html>-->
<!--<head>-->
<!--  <title>Checkout</title>-->
<!--  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">-->
<!--  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>-->
<!--</head>-->
<!--<body class="bg-light">-->

<!--<div class="container mt-4">-->
<!--  <h2 class="mb-3 text-success">Order Summary</h2>-->
<!--  <div id="checkoutSummary"></div>-->
<!--  <button class="btn btn-primary mt-3" onclick="placeOrder()">Place Order</button>-->
<!--</div>-->

<!--<script>-->
<!--function loadCheckout() {-->
<!--  $.get("${pageContext.request.contextPath}/cart/data", function(data) {-->
<!--    if (!data.cart || data.cart.length === 0) {-->
<!--      $("#checkoutSummary").html("<div class='alert alert-warning'>No items in cart.</div>");-->
<!--      return;-->
<!--    }-->
<!--    let html = "<ul class='list-group'>";-->
<!--    $.each(data.cart, function(i,item){-->
<!--      html += "<li class='list-group-item d-flex justify-content-between'>" -->
<!--           + item.productName + " x " + item.quantity -->
<!--           + "<span>" + item.lineTotal + "</span></li>";-->
<!--    });-->
<!--    html += "<li class='list-group-item d-flex justify-content-between'><b>Total</b><b>" + data.grandTotal + "</b></li></ul>";-->
<!--    $("#checkoutSummary").html(html);-->
<!--  });-->
<!--}-->

<!--function placeOrder() {-->
<!--  $.get("${pageContext.request.contextPath}/cart/data", function(data) {-->
<!--    $.ajax({-->
<!--      url: "${pageContext.request.contextPath}/buyer/orders",-->
<!--      type: "POST",-->
<!--      contentType: "application/json",-->
<!--      data: JSON.stringify({-->
<!--        buyerId: 1,  // Replace with logged-in buyer ID dynamically-->
<!--        products: data.cart,-->
<!--        totalAmount: data.grandTotal-->
<!--      }),-->
<!--      success: function(res){-->
<!--        alert("Order placed successfully!");-->
<!--        $.post("${pageContext.request.contextPath}/cart/clear");-->
<!--        window.location.href="order-success.jsp";-->
<!--      }-->
<!--    });-->
<!--  });-->
<!--}-->

<!--$(document).ready(loadCheckout);-->
<!--</script>-->
<!--</body>-->
<!--</html>-->


<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
  <title>Checkout</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="bg-light">
<div class="container mt-4">
  <h2 class="mb-3 text-success">Order Summary</h2>
  <div id="checkoutSummary"></div>
  <button class="btn btn-primary mt-3" onclick="placeOrder()">Place Order</button>
</div>
<script>
function loadCheckout() {
  $.get("${pageContext.request.contextPath}/cart/data", function(data) {
    if (!data.cartItems || data.cartItems.length === 0) {
      $("#checkoutSummary").html("<div class='alert alert-warning'>No items in cart.</div>");
      return;
    }
    let html = "<ul class='list-group'>";
    $.each(data.cartItems, function(i,item){
      html += "<li class='list-group-item d-flex justify-content-between'>" 
           + item.productName + " x " + item.quantity 
           + "<span>" + item.lineTotal + "</span></li>";
    });
    html += "<li class='list-group-item d-flex justify-content-between'><b>Total</b><b>" + data.grandTotalAmount + "</b></li></ul>";
    $("#checkoutSummary").html(html);
  });
}
function placeOrder() {
  $.post("${pageContext.request.contextPath}/buyer/checkout", function(res){
    alert("Order placed successfully!");
    window.location.href="${pageContext.request.contextPath}/cart/order-success";
  }).fail(function(){
    alert("Failed to place order. Cart might be empty.");
  });
}
$(document).ready(loadCheckout);
</script>
</body>
</html>
