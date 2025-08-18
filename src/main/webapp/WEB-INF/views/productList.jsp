<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products | Ecommerce</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>


<body>
<!--    <header class="l-header" id="header">-->
<!--        <nav class="nav bd-grid">-->
<!--            <div class="nav-toggle" id="nav-toggle">-->
<!--                <i class="bx bxs-grid"></i>-->
<!--            </div>-->

<!--            <a href="index.html" class="nav-logo">Ecommerce</a>-->

<!--            <div class="nav-menu" id="nav-menu">-->
<!--                <ul class="nav-list">-->
<!--                    <li class="nav-item"><a href="<%= request.getContextPath() %>" class="nav-link">Home</a></li>-->
<!--                    <li class="nav-item"><a href="#featured" class="nav-link">Featured</a></li>-->
<!--                    <li class="nav-item">-->
<!--                        <a href="#" class="nav-link active">Categories</a>-->
<!--                        <ul class="dropdown-menu">-->
<!--                            <li><a href="product-list?category=men" class="dropdown-item">Men</a></li>-->
<!--                            <li><a href="product-list?category=women" class="dropdown-item">Women</a></li>-->
<!--                            <li><a href="product-list?category=electronics" class="dropdown-item">Electronics</a></li>-->
<!--                            <li><a href="product-list?category=sneakers" class="dropdown-item">Sneakers</a></li>-->
<!--                        </ul>-->
<!--                    </li>-->
<!--                    <li class="nav-item"><a href="#new" class="nav-link">New</a></li>-->
<!--                    <li class="nav-item"><a href="${pageContext.request.contextPath}/app/login" class="nav-link">Login</a></li>-->
<!--                    <li class="nav-item"><a href="${pageContext.request.contextPath}/app/login" class="nav-link">Sign Up</a></li>-->
                    
<!--                </ul>-->
<!--            </div>-->

<!--            <div class="nav-shop">-->
<!--                <i class="bx bx-shopping-bag"></i>-->
<!--            </div>-->
<!--        </nav>-->
<!--    </header>-->

<%@ include file="/WEB-INF/views/header.jsp" %>

    <main class="l-main">
        <section class="breadcrumb section">
            <div class="breadcrumb-container bd-grid">
                <nav class="breadcrumb-nav">
                    <a href="index.html" class="breadcrumb-link">Home</a>
                    <span class="breadcrumb-separator">/</span>
                    <span class="breadcrumb-current" id="categoryName">Products</span>
                </nav>
            </div>
        </section>

        <section class="product-list section">
            <div class="product-list-header bd-grid">
                <div class="category-info">
                    <h1 class="category-title" id="categoryTitle">All Products</h1>
                    <p class="category-description">Discover our amazing collection of high-quality products</p>
                </div>

                <div class="filter-sort-controls">
                    <div class="sort-dropdown">
                        <select id="sortSelect" class="sort-select">
                            <option value="default">Sort by: Default</option>
                            <option value="price-low">Price: Low to High</option>
                            <option value="price-high">Price: High to Low</option>
                            <option value="name">Name: A to Z</option>
                            <option value="newest">Newest First</option>
                        </select>
                    </div>

<!--                    <div class="view-toggle">-->
<!--                        <button class="view-btn active" data-view="grid">-->
<!--                            <i class="bx bx-grid-alt"></i>-->
<!--                        </button>-->
<!--                        <button class="view-btn" data-view="list">-->
<!--                            <i class="bx bx-list-ul"></i>-->
<!--                        </button>-->
<!--                    </div>-->
                </div>
            </div>

            <div class="product-grid bd-grid" id="productGrid">
                <!-- Products will be loaded here -->
              

            </div>

            <div class="pagination-container bd-grid">
                <nav class="pagination">
                    <button class="pagination-btn prev-btn" disabled>
                        <i class="bx bx-chevron-left"></i>
                        Previous
                    </button>
                    
                    <div class="pagination-numbers">
                        <button class="pagination-number active">1</button>
                        <button class="pagination-number">2</button>
                        <button class="pagination-number">3</button>
                        <span class="pagination-dots">...</span>
                        <button class="pagination-number">8</button>
                    </div>
                    
                    <button class="pagination-btn next-btn">
                        Next
                        <i class="bx bx-chevron-right"></i>
                    </button>
                </nav>
                
                <div class="pagination-info">
                    <span>Showing 1-8 of 64 products</span>
                </div>
            </div>
        </section>
    </main>

  <script>
$(document).ready(function() {
    // 1. Get category from URL
    const urlParams = new URLSearchParams(window.location.search);
    let category = urlParams.get('category') || 'all';
    category = category.toLowerCase(); // Normalize input
    const displayCategory = category.charAt(0).toUpperCase() + category.slice(1);
    // 2. Update page title + breadcrumb
    const categoryNames = {
        'men': "Men's Products",
        'women': "Women's Products",
        'electronics': "Electronics",
        'sneakers': "Sneakers",
        'all': "All Products"
    };
    $("#categoryName").text(categoryNames[category]);
    $("#categoryTitle").text(categoryNames[category]);
    document.title = categoryNames[category] + " | Ecommerce";

    // 3. Call backend REST API to fetch products
    $.ajax({
    	  url: '/ecomm.capstone/products/category/' + displayCategory,
        method: "GET",
        success: function(products) {
            let grid = $("#productGrid");
<!--            console.log(url);-->
            grid.empty(); // clear old cards

            if (products.length === 0) {
                grid.append("<p>No products found in this category.</p>");
                return;
            }
            
            console.log("calling");

            // 4. Loop through products and build cards
            products.forEach(product => {
                let card = `
                    <article class="sneaker">

                        <img src="\${product.imageUrl || '\https://i.postimg.cc/3wWGqDYn/women1.png'}" 
                             alt="${product.prodName}" 
                             class="sneaker-img">
                        <span class="sneaker-name">\${product.prodName}</span>
                        <span class="sneaker-price">₹\${product.price}</span>
                        <a href="<%= request.getContextPath() %>/app/product-details/${product.id}" 
                           class="button-light">
                           View Details <i class="bx bx-right-arrow-alt button-icon"></i>
                        </a>
                    </article>
                `;
                grid.append(card);
            });
        },
        error: function(err) {
            console.error("Error loading products:", err);
            $("#productGrid").html("<p>Failed to load products.</p>");
        }
    });
});

        // View toggle functionality
        document.querySelectorAll('.view-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.view-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                
                const view = this.dataset.view;
                const productGrid = document.getElementById('productGrid');
                
                if (view === 'list') {
                    productGrid.classList.add('list-view');
                } else {
                    productGrid.classList.remove('list-view');
                }
            });
        });

        // Sort functionality
        document.getElementById('sortSelect').addEventListener('change', function() {
            const sortValue = this.value;
            // Here you would implement sorting logic
            console.log('Sorting by:', sortValue);
        });

        // Pagination functionality
        document.querySelectorAll('.pagination-number').forEach(btn => {
            btn.addEventListener('click', function() {
                document.querySelectorAll('.pagination-number').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                
                // Here you would load the corresponding page
                console.log('Loading page:', this.textContent);
            });
        });

        // Mobile menu toggle
        document.getElementById('nav-toggle').addEventListener('click', function() {
            document.getElementById('nav-menu').classList.toggle('show');
        });
    </script>
</body>
</html>
