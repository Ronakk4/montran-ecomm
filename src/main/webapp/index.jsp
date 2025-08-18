<%-->
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
 


<style>

</style>
 
 
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




	 <header class="l-header">
        <nav class="nav bd-grid">
            <div class="nav-toggle" id="nav-toggle">
                <i class="bx bxs-grid"></i>
            </div>

            <a href="#" class="nav-logo">Ecommerce</a>

            <div class="nav-menu" id="nav-menu">
                <ul class="nav-list">
                    <li class="nav-item"><a href="<%= request.getContextPath() %>"  class="nav-link">Home</a></li>
                    <li class="nav-item"><a href="#featured" class="nav-link">Featured</a></li>
                    <li class="nav-item dropdown">
                        <a href="#" class="nav-link">Categories <i class="bx bx-chevron-down"></i></a>
                        <ul class="dropdown-menu">
                            <li><a href="#" class="dropdown-item category-link" data-category="men">Men</a></li>
        <li><a href="#" class="dropdown-item category-link" data-category="women">Women</a></li>
        <li><a href="#" class="dropdown-item category-link" data-category="electronics">Electronics</a></li>
        <li><a href="#" class="dropdown-item category-link" data-category="sneakers">Sneakers</a></li>
                        </ul>
                    </li>
                    <li class="nav-item"><a href="#new" class="nav-link">New</a></li>
                    <li class="nav-item"><a href="${pageContext.request.contextPath}/app/login" class="nav-link">Login</a></li>
                    <li class="nav-item"><a href="${pageContext.request.contextPath}/app/login" class="nav-link">Sign Up</a></li>
                </ul>
            </div>

            <div class="nav-shop">
                <i class="bx bx-shopping-bag"></i>
            </div>
        </nav>
    </header>



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
                    <a class="button">Explore Now</a>
                </div>
            </div>
        </section>

        <section class="featured" id="featured">
            <h2 class="section-title">FEATURED</h2>

            <div class="featured-container bd-grid">
                <article class="sneaker">
                    <div class="sneaker-sale">Sale</div>
                    <img src="https://i.postimg.cc/BbYwJ393/featured2.png" alt="" class="sneaker-img">
                    <span class="sneaker-name">Nike Free RN</span>
                    <span class="sneaker-price">$149.99</span>
                    <a class="button-light">Add to Cart <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>

                <article class="sneaker">
                    <div class="sneaker-sale">Sale</div>
                    <img src="https://i.postimg.cc/k4Zj2mXv/featured3.png" alt="" class="sneaker-img">
                    <span class="sneaker-name">Nike Free RN</span>
                    <span class="sneaker-price">$149.99</span>
                    <a class="button-light">Add to Cart <i class="bx bx-right-arrow-alt button-icon"></i></a>
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

 <section class="women section" id="women">
            <h2 class="section-title">WOMEN SNEAKERS</h2>
            <div class="slider-container">
                <button class="slider-btn prev-btn" onclick="slideProducts('women', -1)">
                    <i class="bx bx-chevron-left"></i>
                </button>
                <div class="slider-wrapper">
                    <div class="product-slider" id="women-slider">
                    </div>
                </div>
                <button class="slider-btn next-btn" onclick="slideProducts('women', 1)">
                    <i class="bx bx-chevron-right"></i>
                </button>
            </div>
        </section>
        
        
<!--<section class="men section" id="men">-->
<!--    <h2 class="section-title">MEN SNEAKERS</h2>-->
<!--    <div class="product-container bd-grid" id="men-container"></div>-->
<!--</section>-->

<!--<section class="electronics section" id="electronics">-->
<!--    <h2 class="section-title">ELECTRONICS</h2>-->
<!--    <div class="product-container bd-grid" id="electronics-container"></div>-->
<!--</section>-->

 <section class="men section" id="men">
            <h2 class="section-title">MEN SNEAKERS</h2>
            <div class="slider-container">
                <button class="slider-btn prev-btn" onclick="slideProducts('men', -1)">
                    <i class="bx bx-chevron-left"></i>
                </button>
                <div class="slider-wrapper">
                    <div class="product-slider" id="men-slider">
                       
                    </div>
                </div>
                <button class="slider-btn next-btn" onclick="slideProducts('men', 1)">
                    <i class="bx bx-chevron-right"></i>
                </button>
            </div>
        </section>

  <section class="electronics section" id="electronics">
            <h2 class="section-title">ELECTRONICS</h2>
            <div class="slider-container">
                <button class="slider-btn prev-btn" onclick="slideProducts('electronics', -1)">
                    <i class="bx bx-chevron-left"></i>
                </button>
                <div class="slider-wrapper">
                    <div class="product-slider" id="electronics-slider">
                    </div>
                </div>
                <button class="slider-btn next-btn" onclick="slideProducts('electronics', 1)">
                    <i class="bx bx-chevron-right"></i>
                </button>
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
                    <span class="new-price">From $79.99</span>
                    <a class="button-light">View Collection <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </div>

                <div class="new-sneaker">
                    <div class="new-sneaker-card">
                        <img src="https://i.postimg.cc/gJWgbDjG/new2.png" alt="" class="new-sneaker-img">
                        <div class="new-sneaker-overlay">
                            <a  class="button">Add to Cart</a>
                        </div>
                    </div>

                    <div class="new-sneaker-card">
                        <img src="https://i.postimg.cc/mDgF9z6Q/new4.png" alt="" class="new-sneaker-img">
                        <div class="new-sneaker-overlay">
                            <a  class="button">Add to Cart</a>
                        </div>
                    </div>

                    <div class="new-sneaker-card">
                        <img src="https://i.postimg.cc/5yFy5w5F/new5-1.png" alt="" class="new-sneaker-img">
                        <div class="new-sneaker-overlay">
                            <a  class="button">Add to Cart</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="newsletter section">
            <div class="newsletter-container bd-grid">
                <div>
                    <h3 class="newsletter-title">Subscribe and get <br>10% OFF</h3>
                    <p class="newsletter-description">Get 10% discount for all products</p>
                </div>

                <form action="" class="newsletter-subscribe">
                    <input type="text" class="newsletter-input" placeholder="@email.com">
                    <a  class="button">Subscribe</a>
                </form>
            </div>
        </section>

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
        	  console.log("Rendering product:", p.id, "Price:", p.price);
        	});



        const container = document.getElementById(containerId);
        container.innerHTML = products.map(p => `
        <article class="sneaker">
        <a href="/ecomm.capstone/app/product-details/\${p.id}">
        <img src="https://i.postimg.cc/3wWGqDYn/women1.png" alt="${p.name}" class="sneaker-img">
            <span class="sneaker-name">` + p.prodName + `</span>
            <span class="sneaker-price">$` + p.price + `</span>
            <a href="cart?add=` + p.prodId + `" class="button-light">
                Add to Cart <i class="bx bx-right-arrow-alt button-icon"></i>
            </a>
            </a>
        </article>
    `).join('');

<!--        console.log("Final HTML injected:", container.innerHTML);-->

    } catch (err) {
        console.error("Failed to load products:", err);
    }
}

const categories = [
    { name: "Women", containerId: "women-slider" },
    { name: "Men", containerId: "men-slider" },
    { name: "Electronics", containerId: "electronics-slider" }
];

categories.forEach(c => loadProducts(c.name, c.containerId));
	
	

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


//store slider positions for each category
const sliderPositions = {};

function initializeSlider(category) {
    sliderPositions[category] = 0;
    updateSliderPosition(category);
}

function slideProducts(category, direction) {
    const slider = document.getElementById(`${category}-slider`);
    if (!slider || slider.children.length === 0) return;

    const totalSlides = slider.children.length;
    const slidesToShow = window.innerWidth > 768 ? 3 : 1;
    const maxPosition = Math.max(0, totalSlides - slidesToShow);

    // Initialize position if not exists
    if (!(category in sliderPositions)) {
        sliderPositions[category] = 0;
    }

    // Update position
    sliderPositions[category] += direction;

    // Boundary checks
    if (sliderPositions[category] < 0) {
        sliderPositions[category] = 0;
    }
    if (sliderPositions[category] > maxPosition) {
        sliderPositions[category] = maxPosition;
    }

    updateSliderPosition(category);
}

function updateSliderPosition(category) {
    const slider = document.getElementById(`${category}-slider`);
    if (!slider) return;

    const slidesToShow = window.innerWidth > 768 ? 3 : 1;
    const slideWidth = 100 / slidesToShow;
    const translateX = -(sliderPositions[category] * slideWidth);
    
    slider.style.transform = `translateX(${translateX}%)`;
}

window.addEventListener('resize', function() {
    Object.keys(sliderPositions).forEach(category => {
        updateSliderPosition(category);
    });
});





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

    
<<<<<<< HEAD
</body>

--%>




<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Roby | Ecommerce Landing Page</title>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Turret+Road:wght@200;300;400;500;700;800&display=swap');

        :root {
            --header-height: 3rem;
            --font-medium: 500;
            --font-semi-bold: 600;
            --font-bold: 700;
            --dark-color: #141414;
            --dark-color-light: #8A8A8A;
            --dark-color-lighten: #F2F2F2;
            --white-color: #FFFFFF;
            --body-font: 'Poppins', sans-serif;
            --signature-font: 'Turret Road', sans-serif;
            --big-font-size: 1.25rem;
            --bigger-font-size: 1.5rem;
            --biggest-font-size: 2rem;
            --h2-font-size: 1.25rem;
            --normal-font-size: .938rem;
            --smaller-font-size: .813rem;
            --m1: .5rem;
            --m2: 1rem;
            --m3: 1.5rem;
            --m4: 2rem;
            --m5: 2.5rem;
            --m6: 3rem;
            --z-fixed: 100;
            --rotate-img: rotate(-30deg);
        }

        @media screen and (min-width: 768px){
            :root {
                --big-font-size: 1.5rem;
                --bigger-font-size: 2rem;
                --biggest-font-size: 3rem;
                --normal-font-size: 1rem;
                --smaller-font-size: .875rem;
            }
        }

        *, ::before, ::after { box-sizing: border-box; }
        html { scroll-behavior: smooth; }
        body { margin: var(--header-height) 0 0 0; font-family: var(--body-font); font-size: var(--normal-font-size); font-weight: var(--font-medium); color: var(--dark-color); line-height: 1.6; }
        h1, h2, h3, p, ul { margin: 0; }
        ul { padding: 0; list-style: none; }
        a { text-decoration: none; color: var(--dark-color); }
        img { max-width: 100%; height: auto; display: block; }
        section { padding: 5rem 0 2rem; }
        .section-title { position: relative; font-size: var(--big-font-size); margin-bottom: var(--m4); text-align: center; letter-spacing: 0.1rem; }
        .section-title::after { content: ''; position: absolute; width: 56px; height: 0.18rem; top: -1rem; left: 0; right: 0; margin: auto; background-color: var(--dark-color); }
        .bd-grid { max-width: 1024px; display: grid; grid-template-columns: 100%; column-gap: 2rem; width: calc(100% - 2rem); margin-left: var(--m2); margin-right: var(--m2); }
        .button { display: inline-block; background-color: var(--dark-color); color: var(--white-color); padding: 1.125rem 2rem; font-weight: var(--font-medium); border-radius: .5rem; transition: .4s; }
        .button:hover { transform: translateY(-.25rem); }
        .button-light { display: inline-flex; color: var(--dark-color); font-weight: var(--font-bold); align-items: center; transition: .4s; }
        .button-icon { font-size: 1.25rem; margin-left: var(--m1); transition: .4s; }
        .button-light:hover, .button-icon:hover { transform: translateX(.25rem); }

        /* Header */
        .l-header { width: 100%; position: fixed; top: 0; left: 0; z-index: var(--z-fixed); background-color: var(--dark-color-lighten); }
        .nav { height: var(--header-height); display: flex; justify-content: space-between; align-items: center; }

        /* Auth Buttons */
        .auth-buttons { display: flex; align-items: center; gap: 1rem; }
        .auth-btn { padding: 0.5rem 1.5rem; border-radius: 25px; font-weight: var(--font-medium); transition: all 0.3s ease; text-decoration: none; }
        .btn-login { background: transparent; color: var(--dark-color); border: 2px solid var(--dark-color); }
        .btn-login:hover { background: var(--dark-color); color: var(--white-color); }
        .btn-register { background: var(--dark-color); color: var(--white-color); border: 2px solid var(--dark-color); }
        .btn-register:hover { background: transparent; color: var(--dark-color); }

        /* Seller Section */
        .seller-section { background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); padding: 1rem 0; text-align: center; }
        .seller-text { color: white; font-weight: var(--font-medium); margin-bottom: 1rem; }
        .seller-btn { background: white; color: #f5576c; padding: 0.7rem 2rem; border-radius: 25px; font-weight: var(--font-bold); transition: all 0.3s ease; }
        .seller-btn:hover { background: rgba(255,255,255,0.9); transform: translateY(-2px); }

        @media screen and (max-width: 768px) {
            .nav-menu { position: fixed; top: var(--header-height); left: -100%; width: 70%; height: 100vh; padding: 2rem; background-color: var(--white-color); transition: .5s; }
            .show { left: 0; }
            .auth-buttons { flex-direction: column; gap: 0.5rem; }
        }

        .nav-item { margin-bottom: var(--m4); }
        .nav-logo { font-weight: var(--font-semi-bold); }
        .nav-toggle, .nav-shop { font-size: 1.3rem; cursor: pointer; }
        .active { position: relative; }
        .active::before { content: ''; position: absolute; bottom: -0.5rem; left: 45%; width: 4px; height: 4px; background-color: var(--dark-color); border-radius: 50%; }
        .scroll-header { background-color: var(--white-color); box-shadow: 0 2px 4px rgba(0, 0, 0, .1); }

        /* Home */
        .home { background-color: var(--dark-color-lighten); overflow: hidden; }
        .home-container { height: calc(100vh - var(--header-height)); }
        .home-sneaker { position: relative; display: flex; justify-content: center; align-self: center; }
        .home-shape { width: 220px; height: 220px; background-color: var(--dark-color); border-radius: 50%; }
        .home-img { position: absolute; top: 1.5rem; max-width: initial; width: 275px; transform: var(--rotate-img); }
        .home-new { display: block; font-size: var(--smaller-font-size); font-weight: var(--font-semi-bold); margin-bottom: var(--m2); }
        .home-title { font-size: var(--bigger-font-size); margin-bottom: var(--m1); }
        .home-description { margin-bottom: var(--m6); }

        /* Featured */
        .featured-container { row-gap: 2rem; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); }
        .sneaker { position: relative; display: flex; flex-direction: column; align-items: center; padding: 2rem; background-color: var(--dark-color-lighten); border-radius: .5rem; transition: .4s; }
        .sneaker:hover { transform: translateY(-.5rem); }
        .sneaker-sale { position: absolute; left: 0.5rem; background-color: var(--dark-color); color: var(--white-color); padding: 0.25rem .5rem; border-radius: .25rem; font-size: var(--h2-font-size); transform: rotate(-90deg); letter-spacing: 0.1rem; }
        .sneaker-img { width: 220px; margin-top: var(--m3); margin-bottom: var(--m6); transform: var(--rotate-img); filter: drop-shadow(0 12px 8px rgba(0, 0, 0, .2)); }
        .sneaker-name, .sneaker-price { font-size: var(--h2-font-size); letter-spacing: 0.1rem; font-weight: var(--font-bold); }
        .sneaker-name { margin-bottom: var(--m1); }
        .sneaker-price { margin-bottom: var(--m4); }

        /* Collection */
        .collection-container { row-gap: 2rem; justify-content: center; }
        .collection-card { position: relative; display: flex; height: 328px; background-color: var(--dark-color-lighten); padding: 2rem; border-radius: .5rem; transition: .4s; }
        .collection-card:hover { transform: translateY(-.5rem); }
        .collection-data { align-self: flex-end; }
        .collection-img { position: absolute; top: 0; right: 0; width: 230px; }
        .collection-name { font-size: var(--bigger-font-size); margin-bottom: .25rem; }
        .collection-description { margin-bottom: var(--m2); }

        /* New */
        .new-container { row-gap: 2rem; }
        .new-mens { display: flex; flex-direction: column; justify-content: center; background-color: var(--dark-color-lighten); border-radius: .5rem; padding: 2rem; }
        .new-mens-img { width: 276px; margin-bottom: var(--m3); }
        .new-title { font-size: var(--bigger-font-size); margin-bottom: .25rem; }
        .new-price { display: block; margin-bottom: var(--m3); }
        .new-sneaker { display: grid; gap: 1.5rem; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); }
        .new-sneaker-card { position: relative; padding: 3.5rem 1.5rem; background-color: var(--dark-color-lighten); border-radius: .5rem; overflow: hidden; display: flex; justify-content: center; }
        .new-sneaker-img { width: 220px; }
        .new-sneaker-overlay { position: absolute; left: 0; bottom: -100%; width: 100%; height: 100%; display: flex; justify-content: center; align-items: center; background-color: rgba(138, 138, 138, .3); transition: .4s; }
        .new-sneaker-card:hover .new-sneaker-overlay { bottom: 0 !important; }

        /* Newsletter */
        .newsletter-container { background-color: var(--dark-color); color: var(--white-color); padding: 2rem .5rem; border-radius: .5rem; text-align: center; }
        .newsletter-title { font-size: var(--bigger-font-size); margin-bottom: var(--m2); }
        .newsletter-description { margin-bottom: var(--m5); }
        .newsletter-subscribe { display: flex; column-gap: .5rem; background-color: var(--white-color); padding: 0.5rem; border-radius: .5rem; }
        .newsletter-input { outline: none; border: none; width: 90%; font-size: var(--normal-font-size); }
        .newsletter-input::placeholder { color: var(--dark-color); font-family: var(--body-font); font-size: var(--normal-font-size); font-weight: var(--font-semi-bold); }

        /* Footer */
        .footer-container { grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); }
        .footer-box { margin-bottom: var(--m4); }
        .footer-title { font-size: var(--big-font-size); }
        .footer-link { display: block; width: max-content; margin-bottom: var(--m1); }
        .footer-social { font-size: 1.5rem; margin-right: 1.25rem; }
        .footer-copy { padding-top: 3rem; font-size: var(--smaller-font-size); color: var(--dark-color-light); text-align: center; }
        .footer-copy a { font-size: var(--smaller-font-size); color: var(--dark-color-light); transition: .4s; font-family: var(--signature-font); }
        .footer-copy a:hover { color: var(--dark-color); }

        /* Media Queries */
        @media screen and (min-width: 398px) {
            .new-mens { align-items: center; }
        }

        @media screen and (min-width: 576px) {
            .collection-container { grid-template-columns: 415px; }
            .collection-img { width: 260px; }
        }

        @media screen and (min-width: 768px) {
            body { margin: 0; }
            .section { padding: 7rem 0; }
            .section-title::after { width: 76px; }
            .nav { height: calc(var(--header-height) + 1.5rem); }
            .nav-menu { margin-left: auto; }
            .nav-list { display: flex; }
            .nav-item { margin-left: var(--m6); margin-bottom: 0; }
            .nav-toggle { display: none; }

            .home-container { height: 100vh; grid-template-columns: max-content max-content; justify-content: center; align-items: center; }
            .home-sneaker { order: 1; }
            .home-shape { width: 376px; height: 376px; }
            .home-img { width: 470px; top: 3.5rem; right: 0; left: -3rem; }

            .newsletter-container { grid-template-columns: max-content max-content; justify-content: center; align-items: center; padding: 4.5rem 2rem; column-gap: 3rem; }
            .newsletter-description { margin-bottom: 0; }
            .newsletter-subscribe { width: 360px; height: max-content; }
        }

        @media screen and (min-width: 1024px) {
            .bd-grid { margin-left: auto; margin-right: auto; }
            .home-container { column-gap: 8rem; }
            .collection-container { grid-template-columns: 720px; }
            .new-container { grid-template-columns: max-content 1fr; }
            .new-mens { align-items: initial; justify-content: flex-end; padding: 4rem 2rem; }
            .new-mens-img { margin-bottom: var(--m6); }
        }
    </style>
</head>

<body>
    <header class="l-header" id="header">
        <nav class="nav bd-grid">
            <div class="nav-toggle" id="nav-toggle">
                <i class="bx bxs-grid"></i>
            </div>

            <a href="#" class="nav-logo">Ecommerce</a>

            <div class="nav-menu" id="nav-menu">
                <ul class="nav-list">
                    <li class="nav-item"><a href="#home" class="nav-link active">Home</a></li>
                    <li class="nav-item"><a href="#featured" class="nav-link">Featured</a></li>
                    <li class="nav-item"><a href="#electronics" class="nav-link">Electronics</a></li>
                    <li class="nav-item"><a href="#new" class="nav-link">New</a></li>
                </ul>
            </div>

            <div class="auth-buttons">
                <a href="${pageContext.request.contextPath}/app/login" class="auth-btn btn-login">Login</a>
                <a href="${pageContext.request.contextPath}/app/register" class="auth-btn btn-register">Sign Up</a>
            </div>
        </nav>
    </header>

    <!-- Seller Section -->
    <section class="seller-section">
        <div class="bd-grid">
            <p class="seller-text">Are you a seller? Join our platform and grow your business!</p>
            <a href="${pageContext.request.contextPath}/app/seller-login" class="seller-btn">Seller Login</a>
        </div>
    </section>

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
                    <a href="#featured" class="button">Explore Now</a>
                </div>
            </div>
        </section>

        <section class="featured" id="featured">
            <h2 class="section-title">FEATURED</h2>

            <div class="featured-container bd-grid">
                <article class="sneaker">
                    <div class="sneaker-sale">Sale</div>
                    <img src="https://i.postimg.cc/BbYwJ393/featured2.png" alt="" class="sneaker-img">
                    <span class="sneaker-name">Nike Free RN</span>
                    <span class="sneaker-price">$149.99</span>
                    <a href="#" class="button-light">Add to Cart <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>

                <article class="sneaker">
                    <div class="sneaker-sale">Sale</div>
                    <img src="https://i.postimg.cc/k4Zj2mXv/featured3.png" alt="" class="sneaker-img">
                    <span class="sneaker-name">Nike Free RN</span>
                    <span class="sneaker-price">$149.99</span>
                    <a href="#" class="button-light">Add to Cart <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </article>
            </div>
        </section>

        <section class="collection section">
            <div class="collection-container bd-grid">
                <div class="collection-card">
                    <div class="collection-data">
                        <h3 class="collection-name">Adidas</h3>
                        <p class="collection-description">New Collection 2025</p>
                        <a href="#" class="button-light">Buy Now <i class="bx bx-right-arrow-alt button-icon"></i></a>
                    </div>

                    <img src="https://i.postimg.cc/dVLgt4BF/collection2.png" alt="" class="collection-img">
                </div>
            </div>
        </section>

        <section class="electronics section" id="electronics">
            <h2 class="section-title">ELECTRONICS</h2>
            <div class="electronics-container bd-grid" id="electronics-container">
                <!-- Electronics products will be loaded here -->
            </div>
        </section>

        <section class="new section" id="new">
            <h2 class="section-title">NEW COLLECTION</h2>

            <div class="new-container bd-grid">
                <div class="new-mens">
                    <img src="https://i.postimg.cc/8CqqJMCY/new1.png" alt="" class="new-mens-img">
                    <h3 class="new-title">Mens Shoes</h3>
                    <span class="new-price">From $79.99</span>
                    <a href="#" class="button-light">View Collection <i class="bx bx-right-arrow-alt button-icon"></i></a>
                </div>

                <div class="new-sneaker">
                    <div class="new-sneaker-card">
                        <img src="https://i.postimg.cc/gJWgbDjG/new2.png" alt="" class="new-sneaker-img">
                        <div class="new-sneaker-overlay">
                            <a href="#" class="button">Add to Cart</a>
                        </div>
                    </div>

                    <div class="new-sneaker-card">
                        <img src="https://i.postimg.cc/mDgF9z6Q/new4.png" alt="" class="new-sneaker-img">
                        <div class="new-sneaker-overlay">
                            <a href="#" class="button">Add to Cart</a>
                        </div>
                    </div>

                    <div class="new-sneaker-card">
                        <img src="https://i.postimg.cc/5yFy5w5F/new5-1.png" alt="" class="new-sneaker-img">
                        <div class="new-sneaker-overlay">
                            <a href="#" class="button">Add to Cart</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="newsletter section">
            <div class="newsletter-container bd-grid">
                <div>
                    <h3 class="newsletter-title">Subscribe and get <br>10% OFF</h3>
                    <p class="newsletter-description">Get 10% discount for all products</p>
                </div>

                <form action="" class="newsletter-subscribe">
                    <input type="text" class="newsletter-input" placeholder="@email.com">
                    <a href="#" class="button">Subscribe</a>
                </form>
            </div>
        </section>

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
                        <li><a href="#electronics" class="footer-link">Electronics</a></li>
                        <li><a href="#new" class="footer-link">New</a></li>
                    </ul>
                </div>

                <div class="footer-box">
                    <h3 class="footer-title">SUPPORT</h3>
                    <ul>
                        <li><a href="#" class="footer-link">Product Help</a></li>
                        <li><a href="#" class="footer-link">Customer Care</a></li>
                        <li><a href="#" class="footer-link">Authorized Service</a></li>
                    </ul>
                </div>

                <div class="footer-box">
                    <a href="#" class="footer-social"><i class="bx bxl-facebook"></i></a>
                    <a href="#" class="footer-social"><i class="bx bxl-instagram"></i></a>
                    <a href="#" class="footer-social"><i class="bx bxl-whatsapp"></i></a>
                    <a href="#" class="footer-social"><i class="bx bxl-google"></i></a>
                </div>
            </div>

            <p class="footer-copy">&#169; 2025 <a href="https://codepen.io/leonam-silva-de-souza" target="_blank">ULTRA CODE</a>. All rights reserved</p>
        </footer>
    </main>

<script>
// Navigation toggle
const navToggle = document.getElementById('nav-toggle');
const navMenu = document.getElementById('nav-menu');

if (navToggle) {
    navToggle.addEventListener('click', () => {
        navMenu.classList.toggle('show');
    });
}

// Close mobile menu when clicking on nav links
const navLinks = document.querySelectorAll('.nav-link');
navLinks.forEach(link => {
    link.addEventListener('click', () => {
        navMenu.classList.remove('show');
    });
});

// Load products function
async function loadProducts(category, containerId) {
    try {
        console.log("Fetching category:", category);

        const url = `${window.location.origin}/ecomm.capstone/products/category/${category}`;
        console.log("Final URL:", url);

        const response = await fetch(url);
        console.log("Response status:", response.status);

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const products = await response.json();
        console.log("Products received:", products);

        const container = document.getElementById(containerId);
        if (!container) {
            console.error("Container not found:", containerId);
            return;
        }

        if (products.length === 0) {
            container.innerHTML = '<p class="text-center">No products available in this category.</p>';
            return;
        }

        container.innerHTML = products.map(p => `
            <article class="sneaker">
                <img src="${p.imageUrl || 'https://via.placeholder.com/220x200'}" alt="${p.prodName}" class="sneaker-img">
                <span class="sneaker-name">${p.prodName}</span>
                <span class="sneaker-price">${p.price}</span>
                <a href="#" class="button-light" onclick="addToCart(${p.prodId})">
                    Add to Cart <i class="bx bx-right-arrow-alt button-icon"></i>
                </a>
            </article>
        `).join('');
    } catch (err) {
        console.error("Failed to load products:", err);
        const container = document.getElementById(containerId);
        if (container) {
            container.innerHTML = '<p class="text-center text-danger">Failed to load products. Please try again later.</p>';
        }
    }
}

// Add to cart function (placeholder)
function addToCart(productId) {
    // Check if user is logged in
    fetch('${pageContext.request.contextPath}/app/login')
        .then(response => {
            if (response.redirected) {
                window.location.href = '${pageContext.request.contextPath}/app/login';
            } else {
                console.log('Adding product to cart:', productId);
                // Implement cart functionality here
                alert('Product added to cart! (Feature coming soon)');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            window.location.href = '${pageContext.request.contextPath}/app/login';
        });
}

// Load electronics products when page loads
document.addEventListener('DOMContentLoaded', function() {
    loadProducts("Electronics", "electronics-container");
});

// Scroll header effect
window.addEventListener('scroll', () => {
    const header = document.getElementById('header');
    if (window.scrollY >= 80) {
        header.classList.add('scroll-header');
    } else {
        header.classList.remove('scroll-header');
    }
});
</script>

</body>
</html>            

