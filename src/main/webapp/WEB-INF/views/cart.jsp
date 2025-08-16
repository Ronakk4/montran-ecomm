<%@ page isELIgnored="false" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>

</head>
<body class="bg-light">

<!-- Header -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home.jsp">MyShop</a>
        <div class="ms-auto">
            <a href="login.jsp" class="btn btn-outline-primary me-2">Login</a>
            <a href="signup.jsp" class="btn btn-primary me-2">Sign Up</a>
            <a href="cart.jsp" class="btn btn-outline-success">Cart</a>
        </div>
    </div>
</nav>

<!-- Cart Content -->
<div class="container mt-5">
    <h2 class="mb-4 fw-bold">Your Cart</h2>

    <c:choose>
        <c:when test="${not empty cart.items}">
            <div class="table-responsive bg-white rounded shadow-sm p-3">
                <table class="table table-borderless cart-table">
                    <thead class="border-bottom">
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th width="120">Quantity</th>
                            <th>Subtotal</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cart.items}" varStatus="loop">
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="${item.imageUrl}" class="product-thumb me-3" alt="${item.title}">
                                        <div>
                                            <div class="product-title">${item.title}</div>
                                            <small class="text-muted">SKU: ${item.sku}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>₹ ${item.price}</td>
                                <td>
                                    <form method="post" action="updateQuantity.jsp" class="d-flex">
                                        <input type="hidden" name="id" value="${item.id}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" class="form-control form-control-sm">
                                    </form>
                                </td>
                                <td>₹ ${item.subtotal}</td>
                                <td>
                                    <form method="post" action="removeFromCart.jsp">
                                        <input type="hidden" name="id" value="${item.id}">
                                        <button class="btn btn-sm btn-outline-danger">Remove</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Summary -->
            <div class="mt-4 bg-white rounded shadow-sm p-4">
                <h5>Order Summary</h5>
                <div class="d-flex justify-content-between">
                    <span>Subtotal</span>
                    <span>₹ ${cart.subtotal}</span>
                </div>
                <div class="d-flex justify-content-between">
                    <span>Shipping</span>
                    <span>Calculated at checkout</span>
                </div>
                <hr>
                <div class="d-flex justify-content-between fw-bold">
                    <span>Total</span>
                    <span>₹ ${cart.total}</span>
                </div>
                <a href="checkout.jsp" class="btn btn-primary w-100 mt-3">Proceed to Checkout</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-cart bg-white rounded shadow-sm">
                Your cart is empty.
                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-outline-primary">Continue Shopping</a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

