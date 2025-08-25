<%@ page language="java" contentType="text/html; charset=UTF-8" isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body>
hi
 <div id="cartTable"></div>
  <div class="mt-3">
  
  </div>
</div>
<script>


$(document).ready(function() {
    loadCart();
});
function loadCart() {
	  $.get("${pageContext.request.contextPath}/api/seller/getDeletedProducts", function(data) {
	    renderCart(data);
	    console.log(data);
	  });
	}

	function renderCart(data) {
	  if (!data || data.length === 0) {
	    $("#cartTable").html("<div class='alert alert-warning'>No product is deleted.</div>");
	    return;
	  }

	  var html = "<table class='table table-bordered table-striped shadow cart-table'>" +
	               "<thead class='table-dark'>" +
	                 "<tr>" +
	                   "<th>Product</th>" +
	                   "<th>Product Id</th>" +
	                   "<th>Product Category</th>" +
	                   "<th>Price</th>" +
	                   "<th>Qty</th>" +
	                   "<th>Description</th>" +

      
	                 "</tr>" +
	               "</thead><tbody>";

	  $.each(data, function(i, item) { 

	    html += "<tr>"
	          + "<td>" + item.prodName + "</td>"
	          + "<td>" + item.prodId + "</td>"
	          + "<td>" + item.category + "</td>"
	          + "<td>" + item.price + "</td>"
	          + "<td>" + item.stockQuantity + "</td>"
	          + "<td>" + item.prodDescription + "</td>"

	<!--          + "<td> ₹" + item.productPrice + priceError + "</td>"-->
	<!--          + "<td class='text-center'>"-->
	<!--              + "<button class='btn btn-sm btn-success decBtn " + disableClass + "' "-->

<!--	          + "<td>" + item.productPrice + "</td>"-->
	         
	  });

	  html += "</tbody></table>";
	  $("#cartTable").html(html);
	}
	


</script>
</body>
</html>