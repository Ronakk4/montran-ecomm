<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Manage Products</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="container mt-4">

    <h2>Manage Products</h2>

    <!-- Add Product Form -->
    <form id="addProductForm" class="mb-4">
        <input type="text" name="name" placeholder="Product Name" required class="form-control mb-2" />
        <input type="number" name="price" placeholder="Price" required class="form-control mb-2" />
        <input type="number" name="stock" placeholder="Stock" required class="form-control mb-2" />
        <button class="btn btn-success">Add Product</button>
    </form>

    <!-- Products Table -->
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>ID</th><th>Name</th><th>Price</th><th>Stock</th><th>Actions</th>
            </tr>
        </thead>
        <tbody id="productsTable"></tbody>
    </table>

<script>
// 	const sellerId = "${sessionScope.sellerId}";
	const sellerId = 16;
    const apiBase = "http://localhost:8080/ecomm.capstone/api/seller";

    // Fetch products
    function loadProducts() {
        $.get(`${apiBase}/products?sellerId=${sellerId}`, function(data) {
            let rows = "";
            if (data.length === 0) {
                rows = `<tr><td colspan="5" class="text-center">No products found.</td></tr>`;
            } else {
                data.forEach(p => {
                    rows += `
                        <tr>
                            <td>${p.id}</td>
                            <td>${p.prodName}</td>
                            <td>${p.price}</td>
                            <td>${p.stockQuantity}</td>
                            <td>
                                <button class="btn btn-warning btn-sm" onclick="editProduct(${p.id})">Edit</button>
                                <button class="btn btn-danger btn-sm" onclick="deleteProduct(${p.id})">Delete</button>
                            </td>
                        </tr>`;
                });
            }
            $("#productsTable").html(rows);
        });
    }

    $("#addProductForm").submit(function(e) {
        e.preventDefault();

        const product = {
            prodName: $("input[name='name']").val(),
            price: parseFloat($("input[name='price']").val()),
            stockQuantity: parseInt($("input[name='stock']").val()),
            // seller is set on backend from session
        };

        $.ajax({
            url: `${apiBase}/products`,
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify(product),
            success: function(savedProduct) {
            	console.log(savedProduct)
                alert("Product added!");

            },
            error: function(xhr) {
                alert("Error: " + xhr.responseText);
            }
        });
    });


    // Delete product
    function deleteProduct(id) {
        $.ajax({
            url: `${apiBase}/products/${id}`,
            method: "DELETE",
            success: function() {
                alert("Deleted!");
                loadProducts();
            }
        });
    }

    // TODO: Edit product
    function editProduct(id) {
        alert("Editing product " + id + " (implement modal later)");
    }

    // Initial load
    loadProducts();
</script>
</body>
</html>
