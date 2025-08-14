<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Manage Products</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-4">
<h2>My Products</h2>
<a href="add-product.jsp" class="btn btn-primary mb-3">Add Product</a>
<table class="table table-bordered">
    <thead><tr><th>Name</th><th>Price</th><th>Stock</th><th>Actions</th></tr></thead>
    <tbody id="productTable"></tbody>
</table>

<script>
    const token = localStorage.getItem('token');
    $.ajax({
        url: '/ecomm.capstone/seller/products',
        headers: { 'Authorization': 'Bearer ' + token },
        success: function(data) {
            $('#productTable').empty();
            data.forEach(p => {
                $('#productTable').append(`
                    <tr>
                        <td>${p.prodName}</td>
                        <td>₹${p.price}</td>
                        <td>${p.stockQuantity}</td>
                        <td>
                            <a href="edit-product.jsp?id=${p.id}" class="btn btn-sm btn-warning">Edit</a>
                            <button class="btn btn-sm btn-danger" onclick="deleteProduct(${p.id})">Delete</button>
                        </td>
                    </tr>
                `);
            });
        }
    });

    function deleteProduct(id) {
        if(confirm('Delete product?')) {
            $.ajax({
                url: `/ecomm.capstone/seller/products/${id}`,
                method: 'DELETE',
                headers: { 'Authorization': 'Bearer ' + token },
                success: function() { location.reload(); }
            });
        }
    }
</script>
</body>
</html>
