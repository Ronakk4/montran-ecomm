<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Search Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="<c:url value='/resources/js/jquery.min.js'/>"></script>
</head>
<body class="container mt-4">
<h2>Search Results</h2>
<div id="results" class="row"></div>

<script>
    const query = new URLSearchParams(window.location.search).get('q');
    $.get(`/ecomm.capstone/products/search?q=${encodeURIComponent(query)}`, function(products){
        $('#results').empty();
        if(products.length === 0) {
            $('#results').html('<p>No products found.</p>');
        } else {
            products.forEach(p => {
                $('#results').append(`
                    <div class="col-md-4">
                        <div class="card mb-3">
                            <div class="card-body">
                                <h5>${p.prodName}</h5>
                                <p>${p.prodDescription}</p>
                                <p><b>₹${p.price}</b></p>
                                <a href="product.jsp?id=${p.id}" class="btn btn-sm btn-info">View</a>
                            </div>
                        </div>
                    </div>
                `);
            });
        }
    });
</script>
</body>
</html>
