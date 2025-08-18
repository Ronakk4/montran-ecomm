<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.capstone.util.JwtUtil" %>

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
    <title>Add New Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="container mt-4">

    <h2>Add New Product</h2>

    <form id="newProductForm">
        <div class="mb-3">
            <label class="form-label">Product Name</label>
            <input type="text" name="prodName" required class="form-control" />
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="prodDescription" class="form-control" rows="3"></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Price</label>
            <input type="number" step="0.01" name="price" required class="form-control" />
        </div>

        <div class="mb-3">
            <label class="form-label">Stock Quantity</label>
            <input type="number" name="stockQuantity" required class="form-control" />
        </div>

        <div class="mb-3">
            <label class="form-label">Category</label>
            <select id="categoryDropdown" name="category" class="form-select mb-2"></select>
            <input type="text" id="customCategory" placeholder="Or enter a new category" class="form-control" />
        </div>

        <button type="submit" class="btn btn-success">Save Product</button>
        <a href="seller-products.jsp" class="btn btn-secondary">Cancel</a>
    </form>

<script>
	const sellerId = <%= sellerId != null ? sellerId : "null" %>;
    const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";
    console.log(sellerId);

    // Load categories
    function loadCategories() {
        $.get(`${apiBase}/category`, function(categories) {
            let options = `<option value="">--Select Category--</option>`;
            categories.forEach(c => {
                options += `<option value="${c}">${c}</option>`;
            });
            $("#categoryDropdown").html(options);
        });
    }

    $("#newProductForm").submit(function(e) {
        e.preventDefault();

        // Use dropdown if selected, else take custom category
        let category = $("#categoryDropdown").val();
        if (!category) {
            category = $("#customCategory").val();
        }

        const product = {
            prodName: $("input[name='prodName']").val(),
            prodDescription: $("textarea[name='prodDescription']").val(),
            price: parseFloat($("input[name='price']").val()),
            stockQuantity: parseInt($("input[name='stockQuantity']").val()),
            category: category,
            sellerId: sellerId
        };

        $.ajax({
            url: `${apiBase}/products`,
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(product),
            success: function() {
                alert("Product added successfully!");
                window.location.href = "http://localhost:8080/ecomm.capstone/app/seller/products"; // redirect back
            },
            error: function(xhr) {
                alert("Error: " + xhr.responseText);
            }
        });
    });

    // Initial load
    loadCategories();
</script>

</body>
</html>
