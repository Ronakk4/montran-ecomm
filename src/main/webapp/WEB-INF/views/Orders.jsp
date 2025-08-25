<%@page import="com.capstone.util.JwtUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Cookie jwtCookie = null;
    if(request.getCookies() != null) {
        for(Cookie c : request.getCookies()) {
            if("jwtToken".equals(c.getName())) {
                jwtCookie = c;
                break;
            }
        }
    }
    boolean isLoggedIn = (jwtCookie != null);
    Long userId = null;
    String tokenValue = null;
    if (isLoggedIn) {
        try {
            userId = JwtUtil.getId(jwtCookie.getValue());
            tokenValue = jwtCookie.getValue();
        } catch (Exception e) {
            // expired or invalid token
            isLoggedIn = false;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Orders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body { background: linear-gradient(to right, #e3f2fd, #f8f9fa); min-height: 100vh; }
        .order-card { 
            transition: transform 0.2s, box-shadow 0.2s; 
            border-radius: 15px; 
        }
        .order-card:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 6px 20px rgba(0,0,0,0.15);
        }
        .product-image { width: 60px; height: 60px; object-fit: cover; border-radius: 10px; }
        .product-item { display: flex; align-items: center; gap: 15px; margin-bottom: 10px; }
        .btn { border-radius: 10px; }
        .back-btn { position: absolute; left: 20px; top: 20px; }
        .page-title { color: #0d6efd; text-shadow: 1px 1px 2px rgba(0,0,0,0.1); }
        .badge { font-size: 0.85rem; }
    </style>
</head>
<body class="container mt-5 position-relative">

<%
    // Get buyerId and token again for use in JavaScript
    String token = null;
    if (request.getCookies() != null) {
        for (Cookie c : request.getCookies()) {
            if ("jwtToken".equals(c.getName())) { token = c.getValue(); break; }
        }
    }

    Long buyerId = null;
    if (token != null) {
        try { buyerId = JwtUtil.getId(token); } catch (Exception e) { buyerId = null; }
    }
%>

<!-- ✅ Back button -->
<a href="/ecomm.capstone/" class="btn btn-outline-dark back-btn shadow">&larr; Back</a>

<h2 class="mb-4 text-center fw-bold page-title">📦 My Orders</h2>

<div id="ordersContainer" class="row g-4">
    <!-- Orders will be rendered here dynamically -->
</div>

<script>
$(document).ready(function() {
    const buyerId = <%= buyerId != null ? buyerId : "null" %>;
    const jwtToken = "<%= token != null ? token : "" %>";

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
                    <div class="product-item border-bottom pb-2 mb-2">
                        ${item.imageUrl ? `<img src="${item.imageUrl}" class="product-image shadow-sm border border-2 border-light">` : ""}
                        <div>
                            <strong class="text-dark">${item.name || "Product name: " + item.productName}</strong><br>
                            <small class="text-muted">${item.description || ""}</small><br>
                            <span class="badge bg-secondary">Qty: ${item.quantity}</span>
                            <span class="badge bg-info text-dark">Seller: ${item.sellerName}</span>
                            <span class="badge bg-primary ms-1">₹${item.price}</span>
                        </div>
                    </div>
                `;
            });

            // Badge color
            let statusClass = "secondary";
            switch(order.status) {
                case "DELIVERED": statusClass = "success"; break;
                case "PENDING": statusClass = "warning text-dark"; break;
                case "CANCELLED": statusClass = "danger"; break;
                case "SHIPPED": statusClass = "info text-dark"; break;
                case "PLACED": statusClass = "primary"; break;
            }

            // Cancel button only if status is PLACED or PENDING
            let cancelButton = '';
            if(order.status === 'PLACED' || order.status==='PENDING') {
                cancelButton = `<button class="btn btn-danger btn-sm cancel-order-btn mt-2 w-100 shadow-sm" data-order-id="${order.orderId}">❌ Cancel Order</button>`;
            }

            // ✅ Download PDF button
            let pdfButton = `<button class="btn btn-success btn-sm mt-2 w-100 download-pdf-btn shadow-sm" data-order-id="${order.orderId}">📄 Download PDF</button>`;

            html += `
                <div class="col-12 col-md-6 col-lg-4">
                    <div class="card order-card shadow-sm h-100 border-0">
                        <div class="card-body d-flex flex-column bg-light">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h5 class="card-title mb-0 text-primary">Order #${order.orderId}</h5>
                                <span class="badge bg-${statusClass} order-status-badge px-3 py-2">${order.status}</span>
                            </div>
                            <p class="mb-2"><strong> Shipping:</strong> ${order.shippingAddress || "N/A"}</p>
                            <p class="mb-3"><strong> Total:</strong> <span class="text-success fw-bold">₹${totalAmount.toFixed(2)}</span></p>
                            <button class="btn btn-outline-primary btn-sm mb-2 toggle-products-btn">👀 View Products</button>
                            <div class="products-container d-none">
                                ${productsHtml}
                            </div>
                            <div class="mt-auto">
                                ${cancelButton}
                                ${pdfButton}
                            </div>
                        </div>
                    </div>
                </div>
            `;
        });

        $("#ordersContainer").html(html);
    }

    function loadOrders() {
        $.ajax({
            url: `/ecomm.capstone/api/buyer/orders?buyerId=${buyerId}`,
            type: "GET",
            headers: {
                "Authorization": "Bearer " + jwtToken
            },
            success: function(data) {
                renderOrders(data);
            },
            error: function() {
                $("#ordersContainer").html(
                    '<div class="col-12 text-center text-danger">Failed to load orders.</div>'
                );
            }
        });
    }

    loadOrders();

    // Toggle products visibility
    $(document).on("click", ".toggle-products-btn", function() {
        $(this).siblings(".products-container").toggleClass("d-none");
        $(this).text($(this).text().includes("View") ? "🙈 Hide Products" : "👀 View Products");
    });

    // Cancel order
    $(document).on("click", ".cancel-order-btn", function() {
        const orderId = $(this).data("order-id");
        const btn = $(this);
        if(!confirm("Are you sure you want to cancel this order?")) return;

        $.ajax({
            url: `/ecomm.capstone/api/buyer/orders/${orderId}/`,
            type: "PUT",
            headers: {
                "Authorization": "Bearer " + jwtToken
            },
            success: function() {
                btn.closest(".card").find(".order-status-badge")
                   .removeClass()
                   .addClass("badge bg-danger order-status-badge px-3 py-2")
                   .text("CANCELLED");
                btn.remove();
            },
            error: function() {
                alert("Failed to cancel the order.");
            }
        });
    });

    // ✅ Download PDF
    $(document).on("click", ".download-pdf-btn", function() {
    	 const orderId = $(this).data("order-id");
    	   $.ajax({
    	        url: `/ecomm.capstone/buyer/orders/${orderId}/pdf`,
    	        type: "GET",
    	        
    	       // xhrFields: { responseType: "blob" }, // backend returns PDF as blob
    	        headers: {
    	            "Authorization": "Bearer " + jwtToken   // reuse the same jwtToken you declared earlier
    	        },
    	        success: function (data) {
    	        	 window.location.href = `/ecomm.capstone/buyer/orders/${orderId}/pdf`;
    			
    	        },
    	        error: function () {
    	            alert("Failed to download PDF.");
    	        }
    	    });
    });
});

</script>

</body>
</html>
