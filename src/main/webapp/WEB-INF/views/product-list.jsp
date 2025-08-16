<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>All Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-4">
<h2>Product Catalog</h2>
<div class="row" id="products"></div>

<script>
    $.get('/ecomm.capstone/products', function(products) {
        $('#products').empty();
        products.forEach(p => {
            $('#products').append(`
                <div class="col-md-4">
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5>${p.prodName}</h5>
                            <p>${p.prodDescription}</p>
                            <p><b>₹${p.price}</b></p>
                            <a href="product.jsp?id=${p.id}" class="btn btn-info btn-sm">View</a>
                        </div>
                    </div>
                </div>
            `);
        });
    });
</script>
</body>
</html>
