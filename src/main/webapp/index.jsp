<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>

<!-- Header -->



<!--<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm">-->
<!--    <div class="container">-->
<!--        <a class="navbar-brand fw-bold" >MyShop</a>-->
<!--        <div class="ms-auto">-->
<!--            <a href="${pageContext.request.contextPath}/app/login" class="btn btn-outline-primary me-2">Login</a>-->
<!--            <a href="signup.jsp" class="btn btn-primary me-2">Sign Up</a>-->
<!--            <a href="cart.jsp" class="btn btn-outline-success">Cart</a>-->
<!--        </div>-->
<!--    </div>-->
<!--</nav>-->


 
<!-- Search + Filter -->
<!--<div class="container mt-4">-->
<!--    <div class="row g-2">-->
<!--        <div class="col-md-8">-->
<!--            <input type="text" id="searchBox" class="form-control" placeholder="Search products...">-->
<!--        </div>-->
<!--        <div class="col-md-2">-->
<!--            <button class="btn btn-secondary w-100" id="filterBtn">Filter</button>-->
<!--        </div>-->
<!--        <div class="col-md-2">-->
<!--            <button class="btn btn-primary w-100" id="searchBtn">Search</button>-->
<!--        </div>-->
<!--    </div>-->
<!--</div>-->
 



 
 
 <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Roby | Ecommerce Landing Page</title>

    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/css/index.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
</head>

<body>


<%@ include file="/WEB-INF/views/header.jsp" %>


<!--	 <header class="l-header">-->
<!--        <nav class="nav bd-grid">-->
<!--            <div class="nav-toggle" id="nav-toggle">-->
<!--                <i class="bx bxs-grid"></i>-->
<!--            </div>-->

<!--            <a href="#" class="nav-logo">Ecommerce</a>-->

<!--            <div class="nav-menu" id="nav-menu">-->
<!--                <ul class="nav-list">-->
<!--                    <li class="nav-item"><a href="<%= request.getContextPath() %>"  class="nav-link">Home</a></li>-->
<!--                    <li class="nav-item"><a href="#featured" class="nav-link">Featured</a></li>-->
<!--                   <li class="nav-item dropdown">-->
<!--    <a href="#" class="nav-link">Categories <i class="bx bx-chevron-down"></i></a>-->
<!--    <ul class="dropdown-menu">-->
<!--         categories will be injected here -->
<!--    </ul>-->
<!--</li>-->

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



    <main class="l-main">
        <section class="home" id="home">
            <div class="home-container bd-grid">
                <div class="home-sneaker">
                    <div class="home-shape"></div>
                    <img src="https://i.postimg.cc/N0kPY9TT/imghome.png" alt="" class="home-img">
                </div>

                <div class="home-data">
                    <span class="home-new">New in</span>
                    <h1 class="home-title">YEEZY BOOST <br> SPLY - 350</h1>
                    <p class="home-description">Explore the new collections of sneakers</p>
                    <button class="button" onclick="redirectToSneakers()" >Explore Now</button>
                </div>
            </div>
        </section>

        <section class="featured" id="featured">
            <h2 class="section-title">FEATURED</h2>

           <div class="featured-container bd-grid">
    <article class="sneaker">
        <div class="sneaker-sale">Sale</div>
        <a href="http://localhost:8080/ecomm.capstone/app/product-details/32">
            <img src="https://rukminim1.flixcart.com/image/612/612/k4d27ww0/shirt/q/w/t/l-el024-el-senor-original-imafnadnjp5pq6tg.jpeg?q=70" alt="Nike Free RN" class="sneaker-img">
            <span class="sneaker-name style="display:flex; justify-content:center">Men Shirt</span>
            <span class="sneaker-price style="display:flex; justify-content:center">₹1899.99</span>
        </a>
        <a href="http://localhost:8080/ecomm.capstone/app/product-details/32" class="button">
            View Product <i class="bx bx-right-arrow-alt button-icon"></i>
        </a>
    </article>

    <article class="sneaker">
        <div class="sneaker-sale">Sale</div>
        <a href="http://localhost:8080/ecomm.capstone/app/product-details/31">
            <img src="https://rukminim1.flixcart.com/image/612/612/l5h2xe80/kurta/x/6/n/xl-kast-tile-green-majestic-man-original-imagg4z33hu4kzpv.jpeg?q=70" alt="Nike Free RN" class="sneaker-img">
            <span class="sneaker-name" style="display:flex; justify-content:center">Men Kurta</span>
            <span class="sneaker-price style="display:flex; justify-content:center">₹1899.99</span>
        </a>
        <a href="http://localhost:8080/ecomm.capstone/app/product-details/31" class="button">
            View Product <i class="bx bx-right-arrow-alt button-icon"></i>
        </a>
    </article>
</div>

        </section>

<!--        <section class="collection section">-->
<!--            <div class="collection-container bd-grid">-->
<!--                <div class="collection-card">-->
<!--                    <div class="collection-data">-->
<!--                        <h3 class="collection-name">Adidas</h3>-->
<!--                        <p class="collection-description">New Collection 2025</p>-->
<!--                        <a  class="button-light">Buy Now <i class="bx bx-right-arrow-alt button-icon"></i></a>-->
<!--                    </div>-->

<!--                    <img src="https://i.postimg.cc/dVLgt4BF/collection2.png" alt="" class="collection-img">-->
<!--                </div>-->
<!--            </div>-->
<!--        </section>-->

       <%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!--<section class="women section" id="women">-->
<!--    <h2 class="section-title">WOMEN SNEAKERS</h2>-->
<!--    <div class="product-container bd-grid" id="women-container"></div>-->
<!--</section>-->

        
        
<!--<section class="men section" id="men">-->
<!--    <h2 class="section-title">MEN SNEAKERS</h2>-->
<!--    <div class="product-container bd-grid" id="men-container"></div>-->
<!--</section>-->

<!--<section class="electronics section" id="electronics">-->
<!--    <h2 class="section-title">ELECTRONICS</h2>-->
<!--    <div class="product-container bd-grid" id="electronics-container"></div>-->
<!--</section>-->

 <section class="women section" id="women">
            <h2 class="section-title">WOMEN</h2>
            <div class="slider-container">
<!--                <button class="slider-btn prev-btn" onclick="slideProducts('women', -1)">-->
<!--                    <i class="bx bx-chevron-left"></i>-->
<!--                </button>-->
                <div class="slider-wrapper">
                    <div class="product-slider" id="women-slider">
                    </div>
                </div>
<!--                <button class="slider-btn next-btn" onclick="slideProducts('women', 1)">-->
<!--                    <i class="bx bx-chevron-right"></i>-->
<!--                </button>-->
        <a  class="shop-more" href="http://localhost:8080/ecomm.capstone/app/product-list?category=Women"  style="display: flex; align-items: center; justify-content: center; margin-top: 20px;" > <button style="background-color: white; color: black; border: 1px solid black;" class="button "  >Explore Women Section</button></a>
            </div>
        </section>
        
        

 <section class="men section" id="men">
            <h2 class="section-title">MEN </h2>
            <div class="slider-container">
<!--                <button class="slider-btn prev-btn" onclick="slideProducts('men', -1)">-->
<!--                    <i class="bx bx-chevron-left"></i>-->
<!--                </button>-->
                <div class="slider-wrapper">
                    <div class="product-slider" id="men-slider">
                       
                    </div>
                </div>
<!--                <button class="slider-btn next-btn" onclick="slideProducts('men', 1)">-->
<!--                    <i class="bx bx-chevron-right"></i>-->
<!--                </button>-->
 <a  class="shop-more" href="http://localhost:8080/ecomm.capstone/app/product-list?category=Men"  style="display: flex; align-items: center; justify-content: center; margin-top: 20px;" > <button style="background-color: white; color: black; border: 1px solid black;" class="button "  >Explore Men Section</button></a>
            </div>
        </section>

  <section class="electronics section" id="electronics">
            <h2 class="section-title">ELECTRONICS</h2>
            <div class="slider-container">
<!--                <button class="slider-btn prev-btn" onclick="slideProducts('electronics', -1)">-->
<!--                    <i class="bx bx-chevron-left"></i>-->
<!--                </button>-->
                <div class="slider-wrapper">
                    <div class="product-slider" id="electronics-slider">
                    </div>
                </div>
<!--                <button class="slider-btn next-btn" onclick="slideProducts('electronics', 1)">-->
<!--                    <i class="bx bx-chevron-right"></i>-->
<!--                </button>-->
 <a  class="shop-more" href="http://localhost:8080/ecomm.capstone/app/product-list?category=Electronics"  style="display: flex; align-items: center; justify-content: center; margin-top: 20px;" > <button style="background-color: white; color: black; border: 1px solid black;" class="button "  >Explore Electronics Section</button></a>
            </div>
        </section>


<!--        <section class="offer section">-->
<!--            <div class="offer-container bd-grid">-->
<!--                <div class="offer-data">-->
<!--                    <h3 class="offer-title">50% OFF</h3>-->
<!--                    <p class="offer-description">In Adidas Sneakers</p>-->
<!--                    <a  class="button">Shop Now</a>-->
<!--                </div>-->

<!--                <img src="https://i.postimg.cc/63MpxMcZ/offert.png" alt="" class="offer-img">-->
<!--            </div>-->
<!--        </section>-->

        <section class="new section" id="new">
            <h2 class="section-title">NEW COLLECTION</h2>

            <div class="new-container bd-grid">
                <div class="new-mens">
                    <img src="https://i.postimg.cc/8CqqJMCY/new1.png" alt="" class="new-mens-img">
                    <h3 class="new-title">Mens Shoes</h3>
                    <span class="new-price">From ₹799.99</span>
                    <a class=" button"  onclick="redirectToSneakers()" >View Collection <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </div>

                <div class="new-sneaker">
                    <div class="new-sneaker-card">
                        <img src="data:image/webp;base64,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" alt="" class="new-sneaker-img">
                        <div class="new-sneaker-overlay">
                            <a  href="http://localhost:8080/ecomm.capstone/app/product-details/34" class="button">View Product</a>
                        </div>
                    </div>

                    <div class="new-sneaker-card">
                        <img src="data:image/webp;base64,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" alt="" class="new-sneaker-img">
                        <div class="new-sneaker-overlay">
                            <a href="http://localhost:8080/ecomm.capstone/app/product-details/35" class="button">View Product</a>
                        </div>
                    </div>

                    <div class="new-sneaker-card">
                        <img src="https://rukminim1.flixcart.com/image/612/612/l08gsy80/shoe/n/a/n/9-assg1015-9-abros-l-grey-maroon-original-imagc2m9zbzmtybx.jpeg?q=70" alt="" class="new-sneaker-img">
                        <div class="new-sneaker-overlay">
                            <a href="http://localhost:8080/ecomm.capstone/app/product-details/37" class="button">View Product</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

<!--        <section class="newsletter section">-->
<!--            <div class="newsletter-container bd-grid">-->
<!--                <div>-->
<!--                    <h3 class="newsletter-title">Subscribe and get <br>10% OFF</h3>-->
<!--                    <p class="newsletter-description">Get 10% discount for all products</p>-->
<!--                </div>-->

<!--                <form action="" class="newsletter-subscribe">-->
<!--                    <input type="text" class="newsletter-input" placeholder="@email.com">-->
<!--                    <a  class="button">Subscribe</a>-->
<!--                </form>-->
<!--            </div>-->
<!--        </section>-->

        <footer class="footer section">
            <div class="footer-container bd-grid">
                <div class="footer-box">
                    <h3 class="footer-title">Roby</h3>
                    <p class="footer-description">New Collection of shoes 2025</p>
                </div>

                <div class="footer-box">
                    <h3 class="footer-title">EXPLORE</h3>
                    <ul>
                        <li><a href="#home" class="footer-link">Home</a></li>
                        <li><a href="#featured" class="footer-link">Featured</a></li>
                        <li><a href="#women" class="footer-link">Women</a></li>
                        <li><a href="#new" class="footer-link">New</a></li>
                    </ul>
                </div>

                <div class="footer-box">
                    <h3 class="footer-title">SUPPORT</h3>
                    <ul>
                        <li><a href="#home" class="footer-link">Product Help</a></li>
                        <li><a href="#featured" class="footer-link">Customer Care</a></li>
                        <li><a href="#women" class="footer-link">Authorized Service</a></li>
                    </ul>
                </div>

                <div class="footer-box">
                    <a  class="footer-social"><i class="bx bxl-facebook"></i></a>
                    <a  class="footer-social"><i class="bx bxl-instagram"></i></a>
                    <a  class="footer-social"><i class="bx bxl-whatsapp"></i></a>
                    <a  class="footer-social"><i class="bx bxl-google"></i></a>
                </div>
            </div>

            <p class="footer-copy">&#169; 2025 <a href="https://codepen.io/leonam-silva-de-souza" target="_blank">ULTRA CODE</a>. All rights reserved</p>
        </footer>
    </main>

<script>


async function loadProducts(category, containerId) {
    try {
        console.log("Fetching category raw:", JSON.stringify(category));

        const url = `/ecomm.capstone/products/category/\${category}`;
        console.log("Final URL:", url);

        const response = await fetch(url);
        console.log("Response status:", response.status);

        const products = await response.json();
        products.forEach(p => {
            console.log("Rendering product:", p.prodId, "Price:", p.price);
        });

        const container = document.getElementById(containerId);
        container.innerHTML = products.map(p => {
            // Check stock availability and conditionally render the button
            let buttonHtml = "";
            if (p.stockQuantity > 0) {
                buttonHtml = `
                    <button class="button-light add-to-cart-btn" data-product-id="\${p.prodId}">
                        Add to Cart <i class="bx bx-right-arrow-alt button-icon"></i>
                    </button>
                `;
            } else {
                buttonHtml = `
                    <button class="button-light add-to-cart-btn" disabled style="cursor: not-allowed; opacity: 0.6;">
                        Out of Stock
                    </button>
                `;
            }

            return `
                <article class="sneaker">
                    <a href="/ecomm.capstone/app/product-details/\${p.prodId}">
                        <img src="\${(p.images && p.images.length > 0) ? p.images[0] : 'https://i.postimg.cc/3wWGqDYn/women1.png'}" 
                            alt="${p.prodName}" class="sneaker-img">
                        <span class="sneaker-name" style="display:flex; justify-content:center">\${p.prodName}</span>
                        <span class="sneaker-price" style="display:flex; justify-content:center">₹\${p.price}</span>
                    </a>
                    \${buttonHtml}
                </article>
            `;
        }).join('');

    } catch (err) {
        console.error("Please login first: ", err);
    }
}


const categories = [
    { name: "Women", containerId: "women-slider" },
    { name: "Men", containerId: "men-slider" },
    { name: "Electronics", containerId: "electronics-slider" }
];

categories.forEach(c => loadProducts(c.name, c.containerId));
	
function redirectToSneakers() {
            window.location.href = "http://localhost:8080/ecomm.capstone/app/product-list?category=Sneaker";
}


$(document).on("click", ".add-to-cart-btn", function() {
    const productId = $(this).data("product-id"); // get productId from button
    addToCart(productId, 1); // default quantity = 1
});

function addToCart(productId, quantity) {
    $.ajax({
        url: "http://localhost:8080/ecomm.capstone/api/cart",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            productId: productId,
            quantity: quantity
        }),
        success: function(response) {
            console.log("Cart updated:", response);
            alert("Product added to cart");
        },
        error: function(xhr) {
            console.error("Error:", xhr.responseText);
            alert("Please Login First");
        }
    });
}




<!--//store slider positions for each category-->
<!--const sliderPositions = {};-->

<!--function initializeSlider(category) {-->
<!--    sliderPositions[category] = 0;-->
<!--    updateSliderPosition(category);-->
<!--}-->

<!--function slideProducts(category, direction) {-->
<!--    const slider = document.getElementById(`${category}-slider`);-->
<!--    if (!slider || slider.children.length === 0) return;-->

<!--    const totalSlides = slider.children.length;-->
<!--    const slidesToShow = window.innerWidth > 768 ? 3 : 1;-->
<!--    const maxPosition = Math.max(0, totalSlides - slidesToShow);-->

<!--    // Initialize position if not exists-->
<!--    if (!(category in sliderPositions)) {-->
<!--        sliderPositions[category] = 0;-->
<!--    }-->

<!--    // Update position-->
<!--    sliderPositions[category] += direction;-->

<!--    // Boundary checks-->
<!--    if (sliderPositions[category] < 0) {-->
<!--        sliderPositions[category] = 0;-->
<!--    }-->
<!--    if (sliderPositions[category] > maxPosition) {-->
<!--        sliderPositions[category] = maxPosition;-->
<!--    }-->

<!--    updateSliderPosition(category);-->
<!--}-->

<!--function updateSliderPosition(category) {-->
<!--    const slider = document.getElementById(`${category}-slider`);-->
<!--    if (!slider) return;-->

<!--    const slidesToShow = window.innerWidth > 768 ? 3 : 1;-->
<!--    const slideWidth = 100 / slidesToShow;-->
<!--    const translateX = -(sliderPositions[category] * slideWidth);-->
    
<!--    slider.style.transform = `translateX(${translateX}%)`;-->
<!--}-->

<!--window.addEventListener('resize', function() {-->
<!--    Object.keys(sliderPositions).forEach(category => {-->
<!--        updateSliderPosition(category);-->
<!--    });-->
<!--});-->





    // AJAX Search
    /*
    document.getElementById("searchBtn").addEventListener("click", function() {
        let query = document.getElementById("searchBox").value;
        fetch("searchProducts.jsp?query=" + encodeURIComponent(query))
            .then(res => res.text())
            .then(data => {
                document.getElementById("productContainer").innerHTML = data;
            });
    });

    // AJAX Filter
    document.getElementById("filterBtn").addEventListener("click", function() {
        fetch("filterProducts.jsp")
            .then(res => res.text())
            .then(data => {
                document.getElementById("productContainer").innerHTML = data;
            });
    });
    */

   
</script>

    
</body>