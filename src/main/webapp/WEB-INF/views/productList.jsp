<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products | Ecommerce</title>
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
                        <a href="#" class="nav-link active">Categories</a>
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
                <article class="sneaker">
                    <div class="sneaker-sale">Sale</div>
                    <img src="https://i.postimg.cc/BbYwJ393/featured2.png" alt="Nike Free RN" class="sneaker-img">
                    <span class="sneaker-name">Nike Free RN</span>
                    <span class="sneaker-price">$149.99</span>
                    <a href="product-details.html" class="button-light">View Details <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>

                <article class="sneaker">
                    <img src="https://i.postimg.cc/k4Zj2mXv/featured3.png" alt="Nike Air Max" class="sneaker-img">
                    <span class="sneaker-name">Nike Air Max</span>
                    <span class="sneaker-price">$129.99</span>
                    <a href="product-details.html" class="button-light">View Details <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>

                <article class="sneaker">
                    <img src="https://i.postimg.cc/3wWGqDYn/women1.png" alt="Adidas Ultraboost" class="sneaker-img">
                    <span class="sneaker-name">Adidas Ultraboost</span>
                    <span class="sneaker-price">$179.99</span>
                    <a href="product-details.html" class="button-light">View Details <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>

                <article class="sneaker">
                    <div class="sneaker-sale">New</div>
                    <img src="https://i.postimg.cc/8CqqJMCY/new1.png" alt="Puma RS-X" class="sneaker-img">
                    <span class="sneaker-name">Puma RS-X</span>
                    <span class="sneaker-price">$99.99</span>
                    <a href="product-details.html" class="button-light">View Details <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>

                <article class="sneaker">
                    <img src="https://i.postimg.cc/gJWgbDjG/new2.png" alt="Converse Chuck Taylor" class="sneaker-img">
                    <span class="sneaker-name">Converse Chuck Taylor</span>
                    <span class="sneaker-price">$79.99</span>
                    <a href="product-details.html" class="button-light">View Details <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>

                <article class="sneaker">
                    <div class="sneaker-sale">Sale</div>
                    <img src="https://i.postimg.cc/mDgF9z6Q/new4.png" alt="Vans Old Skool" class="sneaker-img">
                    <span class="sneaker-name">Vans Old Skool</span>
                    <span class="sneaker-price">$89.99</span>
                    <a href="product-details.html" class="button-light">View Details <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>

                <article class="sneaker">
                    <img src="https://i.postimg.cc/5yFy5w5F/new5-1.png" alt="Reebok Classic" class="sneaker-img">
                    <span class="sneaker-name">Reebok Classic</span>
                    <span class="sneaker-price">$69.99</span>
                    <a href="product-details.html" class="button-light">View Details <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>

                <article class="sneaker">
                    <img src="https://i.postimg.cc/BbYwJ393/featured2.png" alt="New Balance 990" class="sneaker-img">
                    <span class="sneaker-name">New Balance 990</span>
                    <span class="sneaker-price">$199.99</span>
                    <a href="product-details.html" class="button-light">View Details <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>
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
        // Get category from URL parameters
        const urlParams = new URLSearchParams(window.location.search);
        const category = urlParams.get('category') || 'all';
        
        // Update page title and breadcrumb based on category
        const categoryNames = {
            'men': 'Men\'s Products',
            'women': 'Women\'s Products',
            'electronics': 'Electronics',
            'sneakers': 'Sneakers',
            'all': 'All Products'
        };
        
        document.getElementById('categoryName').textContent = categoryNames[category];
        document.getElementById('categoryTitle').textContent = categoryNames[category];
        document.title = `${categoryNames[category]} | Ecommerce`;

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
