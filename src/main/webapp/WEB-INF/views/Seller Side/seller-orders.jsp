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
<title>Seller Orders</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
	background: #f8f9fa;
	font-family: 'Segoe UI', sans-serif;
}

.page-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 25px;
}

.page-header h2 {
	margin: 0;
	font-weight: 600;
}

.filters {
	display: flex;
	gap: 10px;
	align-items: center;
}

.card-table {
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
	overflow: hidden;
}

table tbody tr:hover {
	background: #f1f3f5;
	transition: 0.2s;
}

.badge {
	font-size: 0.85rem;
}
</style>
</head>
<body class="container mt-4">

	<!-- HEADER -->
	<div class="page-header">
		<div class="d-flex align-items-center gap-2">
			<a href="dashboard" class="btn btn-outline-secondary btn-sm"> ←
				Back to Dashboard </a>
			<h2>📦 Orders</h2>
		</div>



		<div class="filters">
			<input type="text" id="searchBox"
				class="form-control form-control-sm"
				placeholder="🔍 Search Order ID"> <select id="statusFilter"
				class="form-select form-select-sm">
				<option value="">All Status</option>
				<option value="PLACED">Placed</option>
				<option value="PENDING">Pending</option>
				<option value="SHIPPED">Shipped</option>
				<option value="DELIVERED">Delivered</option>
				<option value="CANCELLED">Cancelled</option>
			</select>
		</div>
	</div>

	<!-- ====== ADDED SEARCH BAR FOR ORDERS ====== -->
	<section class="mt-4">
		<h4>Search Orders</h4>
		<form class="row g-2 align-items-center">
			<div class="col-md-3">
				<input type="date" id="startDate" class="form-control">
			</div>
			<div class="col-md-3">
				<input type="date" id="endDate" class="form-control">
			</div>
			<div class="col-md-3">
				<button type="button" class="btn btn-primary w-100"
					id="searchOrdersBtn">Search Orders</button>
			</div>
		</form>
	</section>
	<!-- ====== END OF SEARCH BAR ====== -->

	<!-- ORDERS TABLE -->
	<div class="card-table">
		<table class="table table-hover align-middle mb-0">
			<thead class="table-dark">
				<tr>
					<th>Order ID</th>
					<th>Order Date</th>
					<th>Shipping Address</th>
					<th>Status</th>
					<th>Total Amount</th>
					<th>Items</th>
				</tr>
			</thead>
			<tbody id="ordersTable">
				<tr>
					<td colspan="5" class="text-center text-muted">Loading...</td>
				</tr>
			</tbody>
		</table>
	</div>

	<script>
    const sellerId = <%= sellerId != null ? sellerId : "null" %>;
    let allOrders = [];

    function loadOrders() {
        $.get(`/ecomm.capstone/api/seller/orders?sellerId=${sellerId}`, function(data) {
            allOrders = data;
            renderOrders(allOrders);
            
        });
    }

    function renderOrders(orders) {
        let rows = "";
        if (orders.length === 0) {
            rows = `<tr><td colspan="5" class="text-center text-muted">No orders found.</td></tr>`;
        } else {
            orders.forEach(order => {
            	console.log(order);
                let itemsHtml = "<ul class='list-unstyled mb-0'>";
                let totalAmount = 0;

                order.items.forEach(item => {
                    itemsHtml += `
                        <li>
                            🛒 <strong>${item.productName || "Product ID: " + item.productId}</strong>
                            <span class="text-muted">x${item.quantity}</span> 
                            <span class="badge bg-light text-dark ms-2">₹${item.price}</span>
                        </li>
                    `;
                    totalAmount += item.price * item.quantity;
                });
                itemsHtml += "</ul>";

                // badge color
                let statusClass = "secondary";
                if (order.status === "DELIVERED") statusClass = "success";
                else if (order.status === "PENDING") statusClass = "warning";
                else if (order.status === "CANCELLED") statusClass = "danger";
                else if (order.status === "SHIPPED") statusClass = "info";
                else if (order.status === "PLACED") statusClass = "primary";

                // status cell
                let statusCell = `
                    <span class="badge bg-${statusClass}" id="badge-${order.orderId}">
                        ${order.status}
                    </span>
                `;

                // if not cancelled → add dropdown
                if (order.status !== "CANCELLED") {
                    let statusOptions = ["PLACED", "PENDING", "SHIPPED", "DELIVERED", "CANCELLED"]
                        .map(s => `<option value="${s}" ${s === order.status ? "selected" : ""}>${s}</option>`)
                        .join("");

                    statusCell += `
                        <select class="form-select form-select-sm w-auto order-status-dropdown" 
                                data-order-id="${order.orderId}">
                            ${statusOptions}
                        </select>
                        <div class="spinner-border spinner-border-sm text-secondary ms-2 d-none" 
                             role="status" id="loader-${order.orderId}">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                    `;
                }

                rows += `
                    <tr>
                        <td><strong>#${order.orderId}</strong></td>
                        <td>${formatOrderDate(order.orderDate)}</td>
                        <td>📍 ${order.shippingAddress || "<span class='text-muted'>N/A</span>"}</td>
                        <td><div class="d-flex align-items-center gap-2">${statusCell}</div></td>
                        <td><span class="fw-bold">₹${totalAmount}</span></td>
                        <td>${itemsHtml}</td>
                    </tr>
                `;
            });
        }
        $("#ordersTable").html(rows);

        // dropdown change → update status
        $(".order-status-dropdown").change(function () {
            const orderId = $(this).data("order-id");
            const newStatus = $(this).val();

            $(`#loader-${orderId}`).removeClass("d-none");

            $.ajax({
                url: `/ecomm.capstone/api/seller/order-status?orderId=${orderId}&status=${newStatus}`,
                type: "PUT",
                success: function () {
                    loadOrders();
                },
                error: function (xhr) {
                    alert("❌ Failed to update order status: " + xhr.responseText);
                },
                complete: function () {
                    $(`#loader-${orderId}`).addClass("d-none");
                }
            });
        });
    }




    // --- Filters ---
    $("#statusFilter").change(function() {
        const status = $(this).val();
        let filtered = status ? allOrders.filter(o => o.status === status) : allOrders;
        renderOrders(filtered);
    });

    $("#searchBox").on("keyup", function() {
        const keyword = $(this).val().trim();
        let filtered = keyword ? allOrders.filter(o => o.orderId.toString().includes(keyword)) : allOrders;
        renderOrders(filtered);
    });
    
//  // ===== ADDED ORDER SEARCH =====
// --- Search Orders Button ---
$("#searchOrdersBtn").on("click", function () {
    const params = {
        sellerId: sellerId,
        orderStatus: $("#statusFilter").val(),   // take from dropdown filter
        startDate: $("#startDate").val(),
        endDate: $("#endDate").val()
    };

    $.ajax({
        url: `/ecomm.capstone/api/seller/searchOrders`,
        type: "GET",
        data: params,
        success: function (orders) {
            allOrders = orders;
            renderOrders(allOrders);
        },
        error: function (xhr) {
            console.error("Order search failed:", xhr.responseText);
            alert("❌ Order search failed.");
        }
    });
});

function formatOrderDate(dateString) {
    if (!dateString) return "<span class='text-muted'>N/A</span>";

    // Handles both array format [2025, 8, 13, 10, 30] and ISO string
    let dateObj;
    if (Array.isArray(dateString)) {
        dateObj = new Date(dateString[0], dateString[1] - 1, dateString[2], dateString[3], dateString[4]);
    } else {
        dateObj = new Date(dateString);
    }

    const options = { 
        year: 'numeric', 
        month: 'short', 
        day: 'numeric', 
        hour: '2-digit', 
        minute: '2-digit' 
    };
    return dateObj.toLocaleDateString('en-GB', options);
}
	

    // Init
    loadOrders();
</script>

</body>
</html>
