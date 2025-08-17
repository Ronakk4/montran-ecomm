<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   <%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details | Ecommerce</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/style.css">


</head>


<body>
    <header class="l-header" id="header">
        <nav class="nav bd-grid">
            <div class="nav-toggle" id="nav-toggle">
                <i class="bx bxs-grid"></i>
            </div>

            <a href="index.html" class="nav-logo">Ecommerce</a>

            <div class="nav-menu" id="nav-menu">
                <ul class="nav-list">
                    <li class="nav-item"><a href="<%= request.getContextPath() %>" class="nav-link">Home</a></li>
                    <li class="nav-item"><a href="#featured" class="nav-link">Featured</a></li>
                    <li class="nav-item">
                        <a href="#" class="nav-link">Categories</a>
                        <ul class="dropdown-menu">
                            <li><a href="product-list.html?category=men" class="dropdown-item">Men</a></li>
                            <li><a href="product-list.html?category=women" class="dropdown-item">Women</a></li>
                            <li><a href="product-list.html?category=electronics" class="dropdown-item">Electronics</a></li>
                            <li><a href="product-list.html?category=sneakers" class="dropdown-item">Sneakers</a></li>
                        </ul>
                    </li>
                    <li class="nav-item"><a href="#new" class="nav-link">New</a></li>
                    <li class="nav-item"><a href="login.html" class="nav-link">Login</a></li>
                    <li class="nav-item"><a href="signup.html" class="nav-link">Sign Up</a></li>
                </ul>
            </div>

            <div class="nav-shop">
                <i class="bx bx-shopping-bag"></i>
            </div>
        </nav>
    </header>

    <main class="l-main">
        <section class="product-detail section">
            <div class="product-detail-container bd-grid">
                <div class="product-images">
                    <div class="main-image">
                        <img src="https://i.postimg.cc/BbYwJ393/featured2.png" alt="Nike Free RN" class="product-main-img" id="mainImage">
                    </div>
                    <div class="thumbnail-images">
                        <img src="https://i.postimg.cc/BbYwJ393/featured2.png" alt="Nike Free RN" class="thumbnail active" onclick="changeImage(this.src)">
                        <img src="https://i.postimg.cc/k4Zj2mXv/featured3.png" alt="Nike Free RN" class="thumbnail" onclick="changeImage(this.src)">
                        <img src="https://i.postimg.cc/3wWGqDYn/women1.png" alt="Nike Free RN" class="thumbnail" onclick="changeImage(this.src)">
                        <img src="https://i.postimg.cc/8CqqJMCY/new1.png" alt="Nike Free RN" class="thumbnail" onclick="changeImage(this.src)">
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
                        <button class="button add-to-cart">Add to Cart</button>
                        <button class="button-light wishlist-btn">
                            <i class="bx bx-heart"></i> Add to Wishlist
                        </button>
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
                <article class="sneaker">
                    <div class="sneaker-sale">Sale</div>
                    <img src="https://i.postimg.cc/k4Zj2mXv/featured3.png" alt="" class="sneaker-img">
                    <span class="sneaker-name">Nike Air Max</span>
                    <span class="sneaker-price">$129.99</span>
                    <a href="product-details.html" class="button-light">View Details <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>

                <article class="sneaker">
                    <img src="https://i.postimg.cc/3wWGqDYn/women1.png" alt="" class="sneaker-img">
                    <span class="sneaker-name">Adidas Ultraboost</span>
                    <span class="sneaker-price">$179.99</span>
                    <a href="product-details.html" class="button-light">View Details <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>

                <article class="sneaker">
                    <img src="https://i.postimg.cc/8CqqJMCY/new1.png" alt="" class="sneaker-img">
                    <span class="sneaker-name">Puma RS-X</span>
                    <span class="sneaker-price">$99.99</span>
                    <a href="product-details.html" class="button-light">View Details <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>
            </div>
        </section>
    </main>

    <script>
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
            qtyDisplay.textContent = currentQty + 1;
        }

        function decreaseQty() {
            const qtyDisplay = document.getElementById('quantity');
            let currentQty = parseInt(qtyDisplay.textContent);
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
