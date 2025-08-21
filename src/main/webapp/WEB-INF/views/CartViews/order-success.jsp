<!--<html>-->
<!--<head><title>Order Success</title></head>-->
<!--<body>-->
<!--<div style="margin: 50px; text-align:center;">-->
<!--  <h2>Your order has been placed successfully!</h2>-->
<!--  <a href="index.jsp">Back to Home</a>-->
<!--</div>-->
<!--</body>-->
<!--</html>-->

<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
  <title>Order Success</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5 text-center">
  <h2 class="text-success">Your order has been placed successfully!</h2>
  <a href="${pageContext.request.contextPath}" class="btn btn-primary mt-3">Continue Shopping</a>
</div>
</body>
</html>
