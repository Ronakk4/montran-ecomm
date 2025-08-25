<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

    Long sellerId = jwtToken != null ? JwtUtil.getId(jwtToken.getValue()) : null;
    String token=jwtToken != null ? jwtToken.getValue() : null;
    
%>

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

<!--  <script>-->
<!--  let allProducts = [];-->

<!--  $(document).ready(function() {-->
<!--      // 1. Get category from URL-->
<!--      const urlParams = new URLSearchParams(window.location.search);-->
<!--      let category = urlParams.get('category') || 'all';-->
<!--      category = category.toLowerCase(); // Normalize input-->
<!--      const displayCategory = category.charAt(0).toUpperCase() + category.slice(1);-->

<!--      // 2. Update page title + breadcrumb-->
<!--      const categoryNames = {-->
<!--          'men': "Men's Products",-->
<!--          'women': "Women's Products",-->
<!--          'electronics': "Electronics",-->
<!--          'sneakers': "Sneakers",-->
<!--          'all': "All Products"-->
<!--      };-->
<!--      $("#categoryName").text(categoryNames[category]);-->
<!--      $("#categoryTitle").text(categoryNames[category]);-->
<!--      document.title = categoryNames[category] + " | Ecommerce";-->

<!--      // 3. Call backend REST API to fetch products-->
<!--      $.ajax({-->
<!--          url: '/ecomm.capstone/products/category/' + displayCategory,-->
<!--          method: "GET",-->
<!--          success: function(products) {-->
<!--              allProducts = products; -->
<!--              renderProducts(allProducts); -->
<!--          },-->
<!--          error: function(err) {-->
<!--              console.error("Error loading products:", err);-->
<!--              $("#productGrid").html("<p>Failed to load products.</p>");-->
<!--          }-->
<!--      });-->

<!--      // 4. Function to render products-->
<!--      function renderProducts(products) {-->
<!--          let grid = $("#productGrid");-->
<!--          grid.empty();-->

<!--          if (products.length === 0) {-->
<!--              grid.append("<p>No products found in this category.</p>");-->
<!--              return;-->
<!--          }-->

<!--          products.forEach(product => {-->
<!--              let card = `-->
<!--                  <article class="sneaker">-->
<!--                      <img src="\${product.imageUrl || 'https://i.postimg.cc/3wWGqDYn/women1.png'}" -->
<!--                           alt="${product.prodName}" -->
<!--                           class="sneaker-img">-->
<!--                      <span class="sneaker-name">\${product.prodName}</span>-->
<!--                      <span class="sneaker-price">₹\${product.price}</span>-->
<!--                      <a href="<%= request.getContextPath() %>/app/product-details/${product.prodId}" -->
<!--                         class="button-light">-->
<!--                         View Details <i class="bx bx-right-arrow-alt button-icon"></i>-->
<!--                      </a>-->
<!--                  </article>-->
<!--              `;-->
<!--              grid.append(card);-->
<!--          });-->
<!--      }-->

<!--      // 5. Sort functionality-->
<!--      $("#sortSelect").on("change", function() {-->
<!--          let sortValue = $(this).val();-->
<!--          let sorted = [...allProducts]; // copy-->

<!--          switch(sortValue) {-->
<!--              case "price-low":-->
<!--                  sorted.sort((a, b) => a.price - b.price);-->
<!--                  break;-->
<!--              case "price-high":-->
<!--                  sorted.sort((a, b) => b.price - a.price);-->
<!--                  break;-->
<!--              case "name":-->
<!--                  sorted.sort((a, b) => a.prodName.localeCompare(b.prodName));-->
<!--                  break;-->
<!--              case "newest":-->
<!--                  sorted.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));-->
<!--                  break;-->
<!--              default:-->
<!--                  sorted = allProducts;-->
<!--          }-->

<!--          renderProducts(sorted);-->
<!--      });-->
<!--  });-->

<!--    </script>-->

<script>
let allProducts = [];
let currentPage = 1;
const itemsPerPage = 8; // products per page

const jwtToken = "<%= token != null ? token : "" %>";
$.ajaxSetup({
    beforeSend: function(xhr) {
        if (jwtToken) {
            xhr.setRequestHeader("Authorization", "Bearer " + jwtToken);
        }
    }
});

$(document).ready(function() {
    // 1. Get category from URL
    const urlParams = new URLSearchParams(window.location.search);
    let category = urlParams.get('category') || 'all';
    category = category.toLowerCase(); 
    const displayCategory = category.charAt(0).toUpperCase() + category.slice(1);

    // 2. Update page title + breadcrumb
    const categoryNames = {
        'men': "Men's Products",
        'women': "Women's Products",
        'electronics': "Electronics",
        'sneaker': "Sneakers",
        'furniture': "Furniture",
        'all': "All Products"
    };
    $("#categoryName").text(categoryNames[category]);
    $("#categoryTitle").text(categoryNames[category]);
    document.title = categoryNames[category] + " | Ecommerce";

    // 3. Fetch products
    $.ajax({
        url: '/ecomm.capstone/products/category/' + displayCategory,
        method: "GET",
        success: function(products) {
        	console.log("page", products);
            allProducts = products;
            renderProducts(allProducts, currentPage);
        },
        error: function(err) {
            console.error("Error loading products:", err);
            $("#productGrid").html("<p>Failed to load products.</p>");
        }
    });
});

// 4. Render products (with pagination)
function renderProducts(products, page = 1) {
    let grid = $("#productGrid");
    grid.empty();

    if (products.length === 0) {
        grid.append("<p>No products found in this category.</p>");
        return;
    }

    // calculate slice
    const start = (page - 1) * itemsPerPage;
    const end = start + itemsPerPage;
    const paginated = products.slice(start, end);

    // build cards
    paginated.forEach(product => {
        let card = `
            <article class="sneaker">
        	  <img src="\${(product.images && product.images.length > 0) 
            ? product.images[0] 
            : 'https://i.postimg.cc/3wWGqDYn/women1.png'}" 
   alt="\${product.prodName}" 
   class="sneaker-img">
                <span class="sneaker-name">\${product.prodName}</span>
                <span class="sneaker-price">₹\${product.price}</span>
<!--               <button class=" add-to-cart-btn button-light">-->
               <a href="<%= request.getContextPath() %>/app/product-details/\${product.prodId}" 
                   class="button">
                   View Details <i class="bx bx-right-arrow-alt button-icon"></i>
                </a>
<!--               </button>-->
            </article>
        `;
        grid.append(card);
    });

    renderPagination(products, page);
}

// 5. Render pagination controls
// 5. Render pagination controls (with dots ... style)
function renderPagination(products, page) {
    const totalPages = Math.ceil(products.length / itemsPerPage);
    let pagination = $(".pagination-numbers");
    pagination.empty();

    // Helper: add page button
    function addPageButton(i) {
        let btn = $(`<button class="pagination-number">\${i}</button>`);
        if (i === page) btn.addClass("active");
        btn.on("click", function() {
            currentPage = i;
            renderProducts(products, currentPage);
        });
        pagination.append(btn);
    }

    // Always show first page
    if (totalPages > 0) addPageButton(1);

    // Show dots if needed
    if (page > 3) {
        pagination.append(`<span class="pagination-dots">...</span>`);
    }

    // Show middle pages (around current)
    let start = Math.max(2, page - 1);
    let end = Math.min(totalPages - 1, page + 1);
    for (let i = start; i <= end; i++) {
        addPageButton(i);
    }

    // Show dots before last page if needed
    if (page < totalPages - 2) {
        pagination.append(`<span class="pagination-dots">...</span>`);
    }

    // Always show last page if more than 1
    if (totalPages > 1) addPageButton(totalPages);

    // prev/next buttons
    $(".prev-btn").prop("disabled", page === 1).off("click").on("click", function() {
        if (currentPage > 1) {
            currentPage--;
            renderProducts(products, currentPage);
        }
    });

    $(".next-btn").prop("disabled", page === totalPages).off("click").on("click", function() {
        if (currentPage < totalPages) {
            currentPage++;
            renderProducts(products, currentPage);
        }
    });

    // info text
    let startItem = (page - 1) * itemsPerPage + 1;
    let endItem = Math.min(page * itemsPerPage, products.length);
    $(".pagination-info span").text(`Showing \${startItem}-\${endItem} of \${products.length} products`);
}

// 6. Sorting
$("#sortSelect").on("change", function() {
    let sortValue = $(this).val();
    let sorted = [...allProducts];

    switch(sortValue) {
        case "price-low":
            sorted.sort((a, b) => a.price - b.price);
            break;
        case "price-high":
            sorted.sort((a, b) => b.price - a.price);
            break;
        case "name":
            sorted.sort((a, b) => a.prodName.localeCompare(b.prodName));
            break;
        case "newest":
            sorted.sort((a, b) => {
                // Convert createdAt array to Date object for comparison
                const dateA = new Date(a.createdAt[0], a.createdAt[1] - 1, a.createdAt[2], a.createdAt[3], a.createdAt[4]);
                const dateB = new Date(b.createdAt[0], b.createdAt[1] - 1, b.createdAt[2], b.createdAt[3], b.createdAt[4]);

                return dateB - dateA; // Compare descending order (newest first)
            });
            break;

        default:
            sorted = allProducts;
    }

    currentPage = 1; // reset to page 1
    renderProducts(sorted, currentPage);
});
</script>

</body>
</html>
