<%--
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <title>Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="container mt-4">

    <h2>Edit Product</h2>

    <form id="editProductForm" class="mb-4">
        <input type="hidden" id="productId" />

        <div class="mb-3">
            <label class="form-label">Product Name</label>
            <input type="text" id="prodName" required class="form-control" />
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea id="prodDescription" required class="form-control"></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Price</label>
            <input type="number" id="price" step="0.01" required class="form-control" />
        </div>

        <div class="mb-3">
            <label class="form-label">Stock Quantity</label>
            <input type="number" id="stockQuantity" required class="form-control" />
        </div>

        <div class="mb-3">
            <label class="form-label">Category</label>
            <select id="categoryDropdown" class="form-select mb-2"></select>
            <input type="text" id="customCategory" class="form-control" placeholder="Or enter new category" />
        </div>

        <button type="submit" class="btn btn-primary">Save Changes</button>
        <a href="../seller-products.jsp" class="btn btn-secondary">Cancel</a>
    </form>

<script>
    const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";
	const sellerId = <%= sellerId != null ? sellerId : "null" %>;

    // Get productId from query string (?id=123)
    const urlParams = new URLSearchParams(window.location.search);
    const productId = urlParams.get("id");

    // Prefill form with product details
    function loadProduct() {
        $.get(`${apiBase}/products/${productId}`, function(p) {
            $("#productId").val(p.id);
            $("#prodName").val(p.prodName);
            $("#prodDescription").val(p.prodDescription);
            $("#price").val(p.price);
            $("#stockQuantity").val(p.stockQuantity);
            $("#customCategory").val(""); // keep empty, dropdown will set value

            // Load categories and set current one
            loadCategories(p.category);
        });
    }

    // Load categories into dropdown
    function loadCategories(selectedCategory) {
        $.get(`${apiBase}/category`, function(data) {
            let options = data.map(c => `<option value="${c}">${c}</option>`).join("");
            $("#categoryDropdown").html(`<option value="">--Select Category--</option>${options}`);
            if (selectedCategory) {
                $("#categoryDropdown").val(selectedCategory);
            }
        });
    }

    // Submit update
    $("#editProductForm").submit(function(e) {
        e.preventDefault();

        const category = $("#customCategory").val().trim() || $("#categoryDropdown").val();

        const product = {
            id: parseInt($("#productId").val()),
            prodName: $("#prodName").val(),
            prodDescription: $("#prodDescription").val(),
            price: parseFloat($("#price").val()),
            stockQuantity: parseInt($("#stockQuantity").val()),
            category: category,
            sellerId: sellerId // backend also validates from session
        };
        console.log(product);

        $.ajax({
            url: `${apiBase}/products/${productId}`,
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify(product),
            success: function() {
                alert("Product updated successfully!");
                window.location.href = "http://localhost:8080/ecomm.capstone/app/seller/products";
            },
            error: function(xhr) {
                alert("Error: " + xhr.responseText);
            }
        });
    });

    // Initial load
    loadProduct();
</script>
</body>
</html>
--%>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <title>Edit Product</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="container mt-4">

    <h2>Edit Product</h2>

    <form id="editProductForm" class="mb-4" novalidate>
        <input type="hidden" id="productId" />

        <div class="mb-3">
            <label class="form-label">Product Name</label>
            <input type="text" id="prodName" class="form-control" />
            <div class="invalid-feedback"></div>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea id="prodDescription" class="form-control"></textarea>
            <div class="invalid-feedback"></div>
        </div>

        <div class="mb-3">
            <label class="form-label">Price</label>
            <input type="number" id="price" step="0.01" class="form-control" />
            <div class="invalid-feedback"></div>
        </div>


		<div class="mb-3">
			<label class="form-label">Stock Quantity</label> <input type="number"
				id="stockQuantity" class="form-control no-spinner" />
			<div class="invalid-feedback"></div>
		</div>

		<style>
		/* Remove increment/decrement arrows for stock input */
		.no-spinner::-webkit-inner-spin-button, .no-spinner::-webkit-outer-spin-button
			{
			-webkit-appearance: none;
			margin: 0;
		}
		
		.no-spinner {
			-moz-appearance: textfield;
		}
		</style>


		<div class="mb-3">
            <label class="form-label">Category</label>
            <select id="categoryDropdown" class="form-select mb-2"></select>
            <input type="text" id="customCategory" class="form-control mt-2" placeholder="Or enter new category" />
            <div class="invalid-feedback"></div>
        </div>

        <button type="submit" class="btn btn-primary">Save Changes</button>
        <a href="../seller-products.jsp" class="btn btn-secondary">Cancel</a>
    </form>

<script>
    const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";
	const sellerId = <%= sellerId != null ? sellerId : "null" %>;

    // Get productId from query string (?id=123)
    const urlParams = new URLSearchParams(window.location.search);
    const productId = urlParams.get("id");

    // === Validation messages (same as addproduct.jsp) ===
    const messages = {
    prodName: {
        required: "Product name is required",
        length: "Product name must be between 3 and 150 characters"
    },
    prodDescription: {
        length: "Description must not exceed 1000 characters"
    },
    price: {
        positive: "Price must be a positive number"
    },
    stockQuantity: {
        min: "Stock quantity must be at least 1"   // ✅ updated message
    },
    category: {
        required: "Please select or enter a category"
    }
};


    function showError(selector, message) {
        $(selector).addClass("is-invalid");
        $(selector).siblings(".invalid-feedback").text(message);
    }
    function clearError(selector) {
        $(selector).removeClass("is-invalid");
        $(selector).siblings(".invalid-feedback").text("");
    }

    // === Field-specific validation ===
    async function validateField(field) {
        const val = $(field).val().trim();
        switch(field.id) {
            case "prodName":
                if (!val) { showError(field, messages.prodName.required); return false; }
                if (val.length < 3 || val.length > 150) { showError(field, messages.prodName.length); return false; }
                clearError(field); return true;

            case "prodDescription":
                if (val.length > 1000) { showError(field, messages.prodDescription.length); return false; }
                clearError(field); return true;

            case "price":
                const price = parseFloat(val);
                if (isNaN(price) || price <= 0) { showError(field, messages.price.positive); return false; }
                clearError(field); return true;

            case "stockQuantity":
                const stock = parseInt(val);
                if (isNaN(stock) || stock <= 0) { showError(field, messages.stockQuantity.min); return false; }
                clearError(field); return true;

            case "categoryDropdown":
            case "customCategory":
                let category = $("#categoryDropdown").val() || $("#customCategory").val().trim();
                if (!category) { showError("#categoryDropdown", messages.category.required); return false; }
                clearError("#categoryDropdown"); return true;
        }
    }

    // Attach real-time validation
    $("#prodName, #prodDescription, #price, #stockQuantity, #categoryDropdown, #customCategory")
        .on("blur input", function() {
            validateField(this);
        });

    // Prefill form with product details
    function loadProduct() {
        $.get(`${apiBase}/products/${productId}`, function(p) {
            $("#productId").val(p.id);
            $("#prodName").val(p.prodName);
            $("#prodDescription").val(p.prodDescription);
            $("#price").val(p.price);
            $("#stockQuantity").val(p.stockQuantity);
            $("#customCategory").val("");

            loadCategories(p.category);
        });
    }

    // Load categories into dropdown
    function loadCategories(selectedCategory) {
        $.get(`${apiBase}/category`, function(data) {
            let options = data.map(c => `<option value="${c}">${c}</option>`).join("");
            $("#categoryDropdown").html(`<option value="">--Select Category--</option>${options}`);
            if (selectedCategory) {
                $("#categoryDropdown").val(selectedCategory);
            }
        });
    }

    // Submit update
    $("#editProductForm").submit(async function(e) {
        e.preventDefault();

        // validate all fields
        let valid = true;
        for (const f of ["#prodName","#prodDescription","#price","#stockQuantity","#categoryDropdown"]) {
            const ok = await validateField($(f)[0]);
            if (!ok) valid = false;
        }
        if (!valid) return;

        const category = $("#customCategory").val().trim() || $("#categoryDropdown").val();

        const product = {
            id: parseInt($("#productId").val()),
            prodName: $("#prodName").val().trim(),
            prodDescription: $("#prodDescription").val().trim(),
            price: parseFloat($("#price").val()),
            stockQuantity: parseInt($("#stockQuantity").val()),
            category: category,
            sellerId: sellerId
        };

        $.ajax({
            url: `${apiBase}/products/${productId}`,
            method: "PUT",
            contentType: "application/json",
            data: JSON.stringify(product),
            success: function() {
                alert("Product updated successfully!");
                window.location.href = "http://localhost:8080/ecomm.capstone/app/seller/products";
            },
            error: function(xhr) {
                alert("Error: " + xhr.responseText);
            }
        });
    });

    // Initial load
    loadProduct();
</script>
</body>
</html>
