<%@page import="com.capstone.util.JwtUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .order-card {
            transition: transform 0.2s;
        }
        .order-card:hover {
            transform: scale(1.02);
        }
        .product-image {    
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
        }
        .product-item {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body class="container mt-5">

<%
    String token = null;
    if (request.getCookies() != null) {
        for (Cookie c : request.getCookies()) {
            if ("jwtToken".equals(c.getName())) {
                token = c.getValue();
                break;
            }
        }
    }

    Long buyerId = null;
    if (token != null) {
        try {
            buyerId = JwtUtil.getId(token);
        } catch (Exception e) {
            buyerId = null;
        }
    }
%>

<h2 class="mb-4 text-center">My Orders</h2>

<div id="ordersContainer" class="row g-4">
    <!-- Orders will be rendered here dynamically -->
</div>

<script>
$(document).ready(function() {
    const buyerId = <%= buyerId != null ? buyerId : "null" %>;

    if (!buyerId) {
        $("#ordersContainer").html('<div class="col-12 text-center text-muted">Please log in to view your orders.</div>');
        return;
    }

    function renderOrders(orders) {
        if (!orders || orders.length === 0) {
            $("#ordersContainer").html('<div class="col-12 text-center text-muted">No orders found.</div>');
            return;
        }

        let html = "";
        orders.forEach(order => {
            let totalAmount = 0;
            let productsHtml = "";

            order.items.forEach(item => {
                totalAmount += item.price * item.quantity;
                productsHtml += `
                    <div class="product-item">
                        ${item.imageUrl ? `<img src="${item.imageUrl}" class="product-image">` : ""}
                        <div>
                            <strong>${item.name || "Product name: " + item.productName}</strong><br>
                            <small class="text-muted">${item.description || ""}</small><br>
                            <span class="badge bg-light text-dark">x${item.quantity}</span>
                            <span class="badge bg-light text-dark">x${item.sellerName}</span>
                            <span class="badge bg-primary ms-1">₹${item.price}</span>
                        </div>
                    </div>
                `;
            });

            let statusClass = "secondary";
            switch(order.status) {
                case "DELIVERED": statusClass = "success"; break;
                case "PENDING": statusClass = "warning"; break;
                case "CANCELLED": statusClass = "danger"; break;
                case "SHIPPED": statusClass = "info"; break;
                case "PLACED": statusClass = "primary"; break;
            }

            let cancelButton = '';
            if(order.status === 'PLACED' || order.status=="PENDING") {
                cancelButton = `<button class="btn btn-danger btn-sm cancel-order-btn mt-2" data-order-id="${order.orderId}">Cancel Order</button>`;
            }

            // Form for Print PDF button
            let printButton = `
                <form method="get" action="/ecomm.capstone/buyer/orders/${order.orderId}/pdf" style="display:inline;">
                    <button type="submit" class="btn btn-success btn-sm mt-2 ms-2">Print PDF</button>
                </form>
            `;

            html += `
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="card order-card shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <h5 class="card-title mb-0">Order #${order.orderId}</h5>
                                <span class="badge bg-${statusClass} order-status-badge">${order.status}</span>
                            </div>
                            <p class="mb-2"><strong>Shipping:</strong> ${order.shippingAddress || "N/A"}</p>
                            <p class="mb-3"><strong>Total:</strong> ₹${totalAmount.toFixed(2)}</p>
                            <button class="btn btn-outline-primary btn-sm mb-2 toggle-products-btn">View Products</button>
                            <div class="products-container d-none">
                                ${productsHtml}
                            </div>
                            <div>
                                ${cancelButton} ${printButton}
                            </div>
                        </div>
                    </div>
                </div>
            `;
        });

        $("#ordersContainer").html(html);
    }

    function loadOrders() {
        $.get(`/ecomm.capstone/buyer/orders?buyerId=${buyerId}`, function(data) {
            renderOrders(data);
        }).fail(function() {
            $("#ordersContainer").html('<div class="col-12 text-center text-danger">Failed to load orders.</div>');
        });
    }

    loadOrders();

    $(document).on("click", ".toggle-products-btn", function() {
        $(this).siblings(".products-container").toggleClass("d-none");
        $(this).text($(this).text() === "View Products" ? "Hide Products" : "View Products");
    });

    $(document).on("click", ".cancel-order-btn", function() {
        const orderId = $(this).data("order-id");
        const btn = $(this);
        if(!confirm("Are you sure you want to cancel this order?")) return;

        $.ajax({
            url: `/ecomm.capstone/buyer/orders/${orderId}/`,
            type: "PUT",
            success: function() {
                btn.closest(".card").find(".order-status-badge")
                   .removeClass()
                   .addClass("badge bg-danger order-status-badge")
                   .text("CANCELLED");
                btn.remove(); // remove cancel button after cancellation
            },
            error: function() {
                alert("Failed to cancel the order.");
            }
        });	
    });
});
</script>

</body>
</html>
