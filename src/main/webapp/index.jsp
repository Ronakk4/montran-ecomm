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
</head>

<body>




	<header>
  <nav>
    <a href="#" class="logo">Ecommerce</a>

    <span class="menu-toggle" onclick="toggleMenu()">☰</span>

    <ul class="nav-list" id="navList">
      <li><a href="#home">Home</a></li>
      <li><a href="#featured">Featured</a></li>
      <li>
        <a href="#">Categories ▼</a>
        <div class="dropdown-content">
          <a href="/category/men">Men</a>
          <a href="/category/women">Women</a>
          <a href="/category/electronics">Electronics</a>
          <a href="/category/sneakers">Sneakers</a>
        </div>
      </li>
      <li><a href="#new">New</a></li>
      <li><a href="${pageContext.request.contextPath}/app/login" class="btn btn-login">Login</a></li>
      <li><a href="${pageContext.request.contextPath}/app/signup" class="btn btn-signup">Sign Up</a></li>
      <li><a href="/cart" class="btn btn-cart">Cart</a></li>
    </ul>
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

<section class="women section" id="women">
    <h2 class="section-title">WOMEN SNEAKERS</h2>
    <div class="product-container bd-grid" id="women-container"></div>
</section>

<section class="men section" id="men">
    <h2 class="section-title">MEN SNEAKERS</h2>
    <div class="product-container bd-grid" id="men-container"></div>
</section>

<section class="electronics section" id="electronics">
    <h2 class="section-title">ELECTRONICS</h2>
    <div class="product-container bd-grid" id="electronics-container"></div>
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
    { name: "Women", containerId: "women-container" },
    { name: "Men", containerId: "men-container" },
    { name: "Electronics", containerId: "electronics-container" }
];

categories.forEach(c => loadProducts(c.name, c.containerId));
	

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

