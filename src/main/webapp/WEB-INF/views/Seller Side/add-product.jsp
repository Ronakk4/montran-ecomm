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

<form id="newProductForm" novalidate>
    <div class="mb-3">
        <label class="form-label">Product Name</label>
        <input type="text" name="prodName" id="prodName" class="form-control" />
        <div class="invalid-feedback"></div>
    </div>

    <div class="mb-3">
        <label class="form-label">Description</label>
        <textarea name="prodDescription" id="prodDescription" class="form-control" rows="3"></textarea>
        <div class="invalid-feedback"></div>
    </div>

    <div class="mb-3">
        <label class="form-label">Price</label>
        <input type="number" step="0.01" name="price" id="price" class="form-control" />
        <div class="invalid-feedback"></div>
    </div>

    <div class="mb-3">
        <label class="form-label">Stock Quantity</label>
        <input type="number" name="stockQuantity" id="stockQuantity" class="form-control" />
        <div class="invalid-feedback"></div>
    </div>

    <div class="mb-3">
        <label class="form-label">Category</label>
        <select id="categoryDropdown" name="category" class="form-select mb-2"></select>
        <input type="text" id="customCategory" placeholder="Or enter a new category" class="form-control mt-2" />
        <div class="invalid-feedback"></div>
    </div>

    <!-- Smart Image Upload -->
    <div class="mb-3">
        <label class="form-label">Product Images (optional, up to 4)</label>
        <div id="imageInputs">
            <input type="url" name="images" class="form-control mb-2" placeholder="Image link 1 (optional)" />
        </div>
        <button type="button" id="addImageBtn" class="btn btn-outline-primary btn-sm">+ Add another image</button>
    </div>

    <button type="submit" class="btn btn-success">Save Product</button>
    <a href="http://localhost:8080/ecomm.capstone/app/seller/dashboard" class="btn btn-secondary">Cancel</a>
</form>

<script>
const sellerId = <%= sellerId != null ? sellerId : "null" %>;
const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";

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

// === Validation messages (copied from Product.java annotations) ===
const messages = {
    prodName: {
        required: "Product name is required",
        length: "Product name must be between 3 and 150 characters",
        unique: "Product name must be unique for this seller"
    },
    prodDescription: {
        length: "Description must not exceed 1000 characters"
    },
    price: {
        positive: "Price must be a positive number"
    },
    stockQuantity: {
        min: "Product not available in stock"
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

// === Unique Product Name check ===
function checkUniqueProductName(prodName) {
    return new Promise((resolve) => {
        $.get(`${apiBase}/products?sellerId=${sellerId}`, function(products) {
            const exists = products.some(p => p.prodName.toLowerCase() === prodName.toLowerCase());
            resolve(exists);
        });
    });
}

// === Field-specific validation ===
async function validateField(field) {
    const val = $(field).val().trim();
    switch(field.id) {
        case "prodName":
            if (!val) { showError(field, messages.prodName.required); return false; }
            if (val.length < 3 || val.length > 150) { showError(field, messages.prodName.length); return false; }
            const exists = await checkUniqueProductName(val);
            if (exists) { showError(field, messages.prodName.unique); return false; }
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

// === Smart Image Input Add ===
let imageCount = 1;
$("#addImageBtn").click(function() {
    if (imageCount < 4) {
        imageCount++;
        $("#imageInputs").append(
            `<input type="url" name="images" class="form-control mb-2" placeholder="Image link ${imageCount} (optional)" />`
        );
    }
    if (imageCount === 4) {
        $(this).prop("disabled", true).text("Maximum 4 images reached");
    }
});

// === Form submit ===
$("#newProductForm").submit(async function(e) {
    e.preventDefault();

    // validate all fields
    let valid = true;
    for (const f of ["#prodName","#prodDescription","#price","#stockQuantity","#categoryDropdown"]) {
        const ok = await validateField($(f)[0]);
        if (!ok) valid = false;
    }
    if (!valid) return;

    let category = $("#categoryDropdown").val() || $("#customCategory").val().trim();

    // collect image links (ignore empty)
    let images = [];
    $("input[name='images']").each(function() {
        let val = $(this).val().trim();
        if (val) images.push(val);
    });

    const product = {
        prodName: $("#prodName").val().trim(),
        prodDescription: $("#prodDescription").val().trim(),
        price: parseFloat($("#price").val()),
        stockQuantity: parseInt($("#stockQuantity").val()),
        category: category,
        sellerId: sellerId,
        images: images // ✅ array of image URLs
    };

    $.ajax({
        url: `${apiBase}/products`,
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify(product),
        success: function() {
            alert("Product added successfully!");
            window.location.href = "http://localhost:8080/ecomm.capstone/app/seller/products";
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
