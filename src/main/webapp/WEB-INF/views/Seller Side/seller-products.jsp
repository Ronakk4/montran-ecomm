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
<title>Manage Products</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    body {
        background: #f8f9fa;
        font-family: 'Segoe UI', sans-serif;
    }
    .sortable { cursor: pointer; }
</style>
</head>
<body class="container mt-4">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="d-flex align-items-center gap-2">
            <a href="dashboard" 
               class="btn btn-outline-secondary btn-sm">
                ← Back to Dashboard
            </a>
            <h2 class="mb-0">Manage Products</h2>
        </div>

        <a href="products/add-product" class="btn btn-success">+ Add New Product</a>
    </div>

    <!-- Category Filter -->
    <div class="mb-3">
        <label for="categoryFilter" class="form-label">Filter by Category:</label>
        <select id="categoryFilter" class="form-select w-auto d-inline">
            <option value="">All</option>
        </select>
    </div>

    <!-- Products Table -->
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th>
                <th class="sortable" onclick="sortTable('name')">Name <span id="sortIcon-name">↕</span></th>
                <th class="sortable" onclick="sortTable('price')">Price <span id="sortIcon-price">↕</span></th>
                <th class="sortable" onclick="sortTable('stock')">Stock <span id="sortIcon-stock">↕</span></th>
                <th>Category</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody id="productsTable"></tbody>
    </table>

<script>
    const sellerId = <%= sellerId != null ? sellerId : "null" %>;
    const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";

    let products = [];
    let currentSort = { key: null, order: 'asc' };

    // Load products
    function loadProducts() {
        $.get(`${apiBase}/products?sellerId=${sellerId}`, function(data) {
            products = data;
            renderProducts(products);
        });
    }

    // Render products
    function renderProducts(list) {
        let rows = "";
        if (list.length === 0) {
            rows = `<tr><td colspan="6" class="text-center">No products found.</td></tr>`;
        } else {
            list.forEach(p => {
                rows += `
                    <tr>
                        <td>${p.prodId}</td>
                        <td>${p.prodName}</td>
                        <td>₹${p.price}</td>
                        <td>${p.stockQuantity}</td>
                        <td>${p.category}</td>
                        <td>
                            <button class="btn btn-warning btn-sm" onclick="editProduct(${p.prodId})">Edit</button>
                            <button class="btn btn-danger btn-sm" onclick="deleteProduct(${p.prodId})">Delete</button>
                        </td>
                    </tr>`;
            });
        }
        $("#productsTable").html(rows);
    }

    // Sorting
    function sortTable(key) {
        let sorted = [...products];
        let order = 'asc';

        if (currentSort.key === key && currentSort.order === 'asc') {
            order = 'desc';
        }

        if (key === 'name') {
            sorted.sort((a, b) => order === 'asc' ? a.prodName.localeCompare(b.prodName) : b.prodName.localeCompare(a.prodName));
        } else if (key === 'price') {
            sorted.sort((a, b) => order === 'asc' ? a.price - b.price : b.price - a.price);
        } else if (key === 'stock') {
            sorted.sort((a, b) => order === 'asc' ? a.stockQuantity - b.stockQuantity : b.stockQuantity - a.stockQuantity);
        }

        currentSort = { key, order };
        resetSortIcons();
        document.getElementById(`sortIcon-${key}`).innerText = (order === 'asc') ? '↑' : '↓';
        renderProducts(applyCategoryFilter(sorted));
    }

    function resetSortIcons() {
        document.getElementById("sortIcon-name").innerText = '↕';
        document.getElementById("sortIcon-price").innerText = '↕';
        document.getElementById("sortIcon-stock").innerText = '↕';
    }

    // Delete product
    function deleteProduct(id) {
        $.ajax({
            url: `${apiBase}/products/${id}`,
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

    // Edit product
    function editProduct(id) {
        window.location.href = `products/edit-product?id=${id}`;
    }

    // Categories
    function loadCategories() {
        $.get(`${apiBase}/category`, function(categories) {
            categories.forEach(c => {
                $("#categoryFilter").append(`<option value="${c}">${c}</option>`);
            });
        });
    }

    $("#categoryFilter").change(function() {
        const filtered = applyCategoryFilter(products);
        renderProducts(filtered);
    });

    function applyCategoryFilter(list) {
        const selected = $("#categoryFilter").val();
        if (!selected) return list;
        return list.filter(p => p.category === selected);
    }

    // Init
    loadCategories();
    loadProducts();
</script>
</body>
</html>
