<%@ page contentType="text/html;charset=UTF-8"%>
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
    Long sellerId = jwtToken != null ? JwtUtil.getId(jwtToken.getValue()) : null;
%>

<html>
<head>
<title>Seller Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
	background: #f8f9fa;
	font-family: 'Segoe UI', sans-serif;
}

.top-bar {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	padding: 15px 30px;
	background: #fff;
	border-bottom: 1px solid #ddd;
}

.top-bar .username {
	margin-right: 20px;
	font-weight: 500;
}

.stat-card {
	background: #fff;
	border-radius: 12px;
	padding: 20px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
	text-align: center;
}

.stat-card h5 {
	font-size: 14px;
	color: #666;
	margin-bottom: 5px;
}

.stat-card h3 {
	font-weight: bold;
}

.section {
	margin-top: 30px;
}

.table thead {
	background: #f1f3f5;
}

.btn-primary {
	border-radius: 20px;
	padding: 6px 18px;
}
</style>

<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />
</head>
<body>

	<!-- TOP BAR -->
	<div class="top-bar">
		<span class="username">👤 <%= jwtToken != null ? JwtUtil.getUsername(jwtToken.getValue()) : "Guest" %></span>
		<a href="profile" class="btn btn-outline-secondary btn-sm me-2">Profile</a>

<%-- 		<a href=<%=request.getContextPath()%> class="btn btn-danger btn-sm">Logout</a> --%>
		<button class="btn btn-danger btn-sm"
			onclick="window.location.href='<%=request.getContextPath()%>/users/logout'">Logout
	</button>
	</div>

	<div class="container mt-4">

		<!-- STATS -->
		<div class="row g-3">
			<div class="col-md-3">
				<div class="stat-card">
					<h5>Total Orders</h5>
					<h3 id="totalOrders">0</h3>
				</div>
			</div>
			<div class="col-md-3">
				<div class="stat-card">
					<h5>Products Listed</h5>
					<h3 id="totalProducts">0</h3>
				</div>
			</div>
			<div class="col-md-3">
				<div class="stat-card">
					<h5>Total Sales</h5>
					<h3 id="totalSales">₹0</h3>
				</div>
			</div>
			<div class="col-md-3">
				<div class="stat-card">
					<h5>Revenue (This Month)</h5>
					<h3 id="monthlyRevenue">₹0</h3>
				</div>
			</div>
		</div>



		<!-- RECENT ORDERS -->
		<div class="section">
			<div class="d-flex justify-content-between align-items-center">
				<h4>📦 Recent Orders</h4>
				<a href="orders" class="btn btn-primary btn-sm">View All</a>
			</div>
			<table class="table mt-3">
				<thead>
					<tr>
						<th>Order ID</th>
						<th>Buyer</th>
						<th>Product</th>
						<th>Qty</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody id="ordersTable">
					<tr>
						<td colspan="5" class="text-center">Loading...</td>
					</tr>
				</tbody>
			</table>
		</div>

		<!-- PRODUCTS -->
		<div class="section">
			<div class="d-flex justify-content-between align-items-center">
				<h4>🛒 Your Products</h4>
				<a href="products" class="btn btn-primary btn-sm">Manage</a>
			</div>
			<div id="productList" class="row g-3 mt-2">
				<div class="col-12 text-center">Loading...</div>
			</div>
		</div>

	</div>

	<!-- AJAX -->
	<script>
	
	history.pushState(null, null, location.href);
    window.onpopstate = function () {
        window.location.href = '<%=request.getContextPath()%>/'; // home page
    };
    
        $(document).ready(function() {
            const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";
            const sellerId = <%= sellerId != null ? sellerId : "null" %>;

            // Fetch Products
            $.get(`${apiBase}/products?sellerId=${sellerId}`, function(products) {
                let list = $("#productList");
                list.empty();
                $("#totalProducts").text(products.length);

                if (products.length === 0) {
                    list.append("<div class='col-12 text-center text-muted'>No products found.</div>");
                } else {
                    products.forEach(p => {
                        list.append(`
                            <div class="col-md-4">
                        		<div class="stat-card text-start border rounded p-3 shadow-sm">
                        	    <h5 class="mb-2">${p.prodName}</h5>
                        	    <p class="mb-1 text-muted">Stock: ${p.stockQuantity}</p>
                        	    <p class="mb-3 fw-semibold">₹${p.price}</p>

                        	</div>

                            </div>
                        `);
                    });
                }
            });

         // Fetch Orders (Dashboard Preview)
            $.get(`${apiBase}/orders?sellerId=${sellerId}`, function(orders) {
                let table = $("#ordersTable");
                table.empty();
                $("#totalOrders").text(orders.length);

                if (orders.length === 0) {
                    table.append("<tr><td colspan='5' class='text-center text-muted'>No orders yet.</td></tr>");
                } else {
                    orders.slice(0, 5).forEach(order => {
                        let statusClass = "secondary";
                        if (order.status === "DELIVERED") statusClass = "success";
                        else if (order.status === "PENDING") statusClass = "warning";
                        else if (order.status === "CANCELLED") statusClass = "danger";
                        else if (order.status === "SHIPPED") statusClass = "info";
                        else if (order.status === "PLACED") statusClass = "primary";

                        // show first product from order for preview
                        let firstItem = order.items.length > 0 ? order.items[0] : null;

                        table.append(`
                            <tr class="align-middle">
                                <td><strong>#${order.orderId}</strong></td>
                                <td>📍 ${order.shippingAddress || "<span class='text-muted'>N/A</span>"}</td>
                                <td>${firstItem ? "Product ID: " + firstItem.productId : "-"}</td>
                                <td>${firstItem ? firstItem.quantity : "-"}</td>
                                <td><span class="badge bg-${statusClass}">${order.status}</span></td>
                            </tr>
                        `);
                    });
                }
            });
         // Fetch Analytics (Total Sales + Revenue This Month)
            $.get(`${apiBase}/analytics?sellerId=${sellerId}`, function(data) {
                if (data) {
                    $("#totalSales").text(data.totalSales || 0);
                    $("#monthlyRevenue").text("₹" + (data.totalRevenue ? data.totalRevenue.toFixed(2) : "0.00"));
                }
            });

         
        });
        
     

     // Delete product
        function deleteProduct(id) {
            $.ajax({
                url: `http://localhost:8080/ecomm.capstone/api/seller/products/${id}`,
                method: "DELETE",
                success: function() {
                    alert("Deleted!");
                    loadProducts();
                },
                error: function(xhr) {
                    alert("Error: " + xhr.responseText);
                }
            });
        }
    </script>

</body>
</html>

