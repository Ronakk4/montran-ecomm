<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   <%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details | Ecommerce</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>


<body>
   <%@ include file="/WEB-INF/views/header.jsp" %>

    <main class="l-main">
        <section class="product-detail section">
            <div class="product-detail-container bd-grid">
              <div class="product-images">
    <div class="main-image">
        <img src="${empty product.images[0] 
                     ? 'https://i.postimg.cc/BbYwJ393/featured2.png' 
                     : product.images[0]}" 
             alt="${product.prodName}" 
             class="product-main-img" id="mainImage">
    </div>

    <div class="thumbnail-images">
        <img src="${empty product.images[0] 
                     ? 'https://i.postimg.cc/BbYwJ393/featured2.png' 
                     : product.images[0]}" 
             alt="${product.prodName}" 
             class="thumbnail active" onclick="changeImage(this.src)">

        <img src="${empty product.images[1] 
                     ? 'https://i.postimg.cc/k4Zj2mXv/featured3.png' 
                     : product.images[1]}" 
             alt="${product.prodName}" 
             class="thumbnail" onclick="changeImage(this.src)">

        <img src="${empty product.images[2] 
                     ? 'https://i.postimg.cc/3wWGqDYn/women1.png' 
                     : product.images[2]}" 
             alt="${product.prodName}" 
             class="thumbnail" onclick="changeImage(this.src)">

        <img src="${empty product.images[3] 
                     ? 'https://i.postimg.cc/8CqqJMCY/new1.png' 
                     : product.images[3]}" 
             alt="${product.prodName}" 
             class="thumbnail" onclick="changeImage(this.src)">
    </div>
</div>

                <div class="product-info">
                    <div class="product-badge">Sale</div>
                    <h1 class="product-title">${product.prodName}</h1>
                    <div class="product-rating">
                        <div class="stars">
                            <i class="bx bxs-star"></i>
                            <i class="bx bxs-star"></i>
                            <i class="bx bxs-star"></i>
                            <i class="bx bxs-star"></i>
                            <i class="bx bx-star"></i>
                        </div>
                        <span class="rating-text">(4.2) 156 Reviews</span>
                    </div>
                    
                    <div class="product-price">
                        <span class="current-price">$${product.price}</span>
                        <span class="original-price">$1999.99</span>
                        <span class="discount">25% OFF</span>
                    </div>

                    <div class="product-description">
                        <h3>Description</h3>
                        <p>${product.prodDescription}</p>
                        <ul class="product-features">
                            <li>Lightweight and breathable mesh upper</li>
                            <li>Flexible sole for natural foot movement</li>
                            <li>Cushioned midsole for comfort</li>
                            <li>Durable rubber outsole</li>
                        </ul>
                    </div>

                    <div class="product-options">
                        <div class="size-selector">
                            <h4>Size</h4>
                            <div class="size-options">
                                <button class="size-btn">7</button>
                                <button class="size-btn">8</button>
                                <button class="size-btn active">9</button>
                                <button class="size-btn">10</button>
                                <button class="size-btn">11</button>
                            </div>
                        </div>

                        <div class="color-selector">
                            <h4>Color</h4>
                            <div class="color-options">
                                <button class="color-btn active" style="background-color: #000;"></button>
                                <button class="color-btn" style="background-color: #fff; border: 1px solid #ddd;"></button>
                                <button class="color-btn" style="background-color: #ff6b6b;"></button>
                                <button class="color-btn" style="background-color: #4ecdc4;"></button>
                            </div>
                        </div>

                        <div class="quantity-selector">
                            <h4>Quantity</h4>
                            <div class="quantity-controls">
                                <button class="qty-btn" onclick="decreaseQty()">-</button>
                                <span class="qty-display" id="quantity">1</span>
                                <button class="qty-btn" onclick="increaseQty()">+</button>
                            </div>
                        </div>
                    </div>

                    <div class="product-actions">
                        <button class="button add-to-cart" style="background-color:black; color:white">Add to Cart</button>
<!--                        <button class="button-light wishlist-btn">-->
<!--                            <i class="bx bx-heart"></i> Add to Wishlist-->
<!--                        </button>-->
                    </div>

                    <div class="product-meta">
                        <div class="meta-item">
                            <span class="meta-label">SKU:</span>
                            <span class="meta-value">NK-FR-2025-001</span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-label">Category:</span>
                            <span class="meta-value">Sneakers, Running Shoes</span>
                        </div>
                        <div class="meta-item">
                            <span class="meta-label">Tags:</span>
                            <span class="meta-value">Nike, Running, Comfort, Sport</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="related-products section">
            <h2 class="section-title">RELATED PRODUCTS</h2>
            <div class="featured-container bd-grid">
               
            </div>
        </section>
    </main>

    <script>
    let prodId=0;
    let qty=0;
    
    function getRelatedProducts(category) {
    	console.log("related category",category);
        $.ajax({
            url: '/ecomm.capstone/products/category/' + category,
            method: 'GET',
            success: function(products) {
                let container = $(".featured-container");
                container.empty(); // clear existing hardcoded items
				console.log("calling");
                products.forEach(p => {
                	console.log(p);
                    let productHtml = `
                        <article class="sneaker">
                            ${p.onSale ? '<div class="sneaker-sale">Sale</div>' : ''}
                    	  <a href="/ecomm.capstone/app/product-details/\${p.prodId}">
                    	 <img src="\${(p.images && p.images.length > 0) 
                        ? p.images[0] 
                        : 'https://i.postimg.cc/3wWGqDYn/women1.png'}" 
               alt="\${p.prodName}" 
               class="sneaker-img">
                            <span class="sneaker-name"  style="display:flex; justify-content:center">` + p.prodName + `</span>
                            <span class="sneaker-price"  style="display:flex; justify-content:center">$` + p.price + `</span>
                            <a href="<%= request.getContextPath() %>/app/product-details/\${p.prodId}" 
                                class="button">
                                View Details <i class="bx bx-right-arrow-alt button-icon"></i>
                             </a>
                            </a>
                        </article>
                        
                           
                          
                    `;
                    container.append(productHtml);
                });
            },
            error: function(err) {
                console.error("Error fetching related products", err);
            }
        });
    }

    // Call function on page load
    $(document).ready(function() {
        let category = "${product.category}";  // category from JSP model
        prodId = "${product.prodId}";
        getRelatedProducts(category);
    });
    
    $(document).on("click", ".add-to-cart", function() {
        const productId = $(this).data("product-id"); // get productId from button
        addToCart(productId, 1); // default quantity = 1
    });

    function addToCart() {
        $.ajax({
            url: "http://localhost:8080/ecomm.capstone/api/cart",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                productId: prodId,
                quantity: qty+1
            }),
            success: function(response) {
                console.log("Cart updated:", response);
                alert("Product added to cart");
            },
            error: function(xhr) {
                console.error("Error:", xhr.responseText);
                alert("Failed to add product to cart");
            }
        });
    }
    
    
    $(document).ready(function() {
        $(".category-link").on("click", function(e) {
            e.preventDefault();
            let category = $(this).data("category");

            $.ajax({
                url: "<%= request.getContextPath() %>/app/product-list",
                type: "GET",
                data: { category: category },
                success: function(response) {
                    // Case 1: If your product-list.jsp is a full page, then just redirect:
                    window.location.href = "<%= request.getContextPath() %>/app/product-list?category=" + category;

                    // Case 2 (Optional): If you want to inject results into current page:
                    // $("#content").html(response);   // assumes you have <div id="content"></div>
                },
                error: function(xhr) {
                    console.error("Error loading category:", xhr);
                }
            });
        });
    });
    



        function changeImage(src) {
            document.getElementById('mainImage').src = src;
            
            // Update active thumbnail
            document.querySelectorAll('.thumbnail').forEach(thumb => {
                thumb.classList.remove('active');
            });
            event.target.classList.add('active');
        }

        function increaseQty() {
            const qtyDisplay = document.getElementById('quantity');
            let currentQty = parseInt(qtyDisplay.textContent);
            qty=currentQty;
            qtyDisplay.textContent = currentQty + 1;
        }

        function decreaseQty() {
            const qtyDisplay = document.getElementById('quantity');
            let currentQty = parseInt(qtyDisplay.textContent);
            qty=currentQty;
            if (currentQty > 1) {
                qtyDisplay.textContent = currentQty - 1;
            }
        }

        // Size selection
        document.querySelectorAll('.size-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.size-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Color selection
        document.querySelectorAll('.color-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.color-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
            });
        });

        // Mobile menu toggle
        document.getElementById('nav-toggle').addEventListener('click', function() {
            document.getElementById('nav-menu').classList.toggle('show');
        });
    </script>
</body>
</html>
