<%@ page isELIgnored="false" %>
<%@ page import="com.capstone.util.JwtUtil" %>

<%
    Cookie jwtToken = null;
    if(request.getCookies() != null) {
        for(Cookie c : request.getCookies()) {
            if("jwtToken".equals(c.getName())) {
                jwtToken = c;
                break;
            }
        }
    }
    boolean isLoggedIn = (jwtToken != null);
    Long userId = null;
    if (isLoggedIn) {
        try {
            userId = JwtUtil.getId(jwtToken.getValue());
        } catch (Exception e) {
            // expired or invalid token
            isLoggedIn = false;
        }
    }
    String token = jwtToken != null ? jwtToken.getValue() : "";
%>

<header class="l-header">
    <nav class="nav bd-grid">
        <div class="nav-toggle" id="nav-toggle">
            <i class="bx bxs-grid"></i>
        </div>

        <a href="#" class="nav-logo">Ecommerce</a>

        <div class="nav-menu" id="nav-menu">
            <ul class="nav-list">
                <li class="nav-item"><a href="<%= request.getContextPath() %>" class="nav-link">Home</a></li>
                <li class="nav-item"><a href="#featured" class="nav-link">Featured</a></li>
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link">Categories <i class="bx bx-chevron-down"></i></a>
                    <ul class="dropdown-menu">
                        <!-- categories will be injected here -->
                    </ul>
                </li>
                <li class="nav-item"><a href="#new" class="nav-link">New</a></li>

                <% if(isLoggedIn) { %>
                    <li class="nav-item">
                        <button id="profile-btn">Profile</button>
                        <div id="profile-info"></div>
                    </li>
                    <li class="nav-item"><a href="<%= request.getContextPath() %>/users/logout" class="nav-link">Logout</a></li>
                    <li class="nav-item cart-icon">
                        <a href="<%= request.getContextPath() %>/app/cart" class="nav-link">
                            <i class="bx bx-shopping-bag"></i>Cart
                        </a>
                    </li>
                <% } else { %>
                    <li class="nav-item"><a href="<%= request.getContextPath() %>/app/login" class="nav-link">Login</a></li>
                    <li class="nav-item"><a href="<%= request.getContextPath() %>/app/register" class="nav-link">Sign Up</a></li>
                <% } %>
            </ul>
        </div>
    </nav>
</header>

<script>
$(document).ready(function() {

    // Load categories dynamically
    function loadCategories() {
        $.get("http://localhost:8080/ecomm.capstone/api/seller/category", function(categories) {
            console.log("RAW categories:", categories);
            let items = "";
            categories.forEach(c => {
                items += `
                    <li>
                        <a href="#" class="dropdown-item category-link" data-category="${c}">${c}</a>
                    </li>`;
            });
            $(".dropdown-menu").html(items);
        });
    }
    loadCategories();

    // Category click handler
    $(document).on("click", ".category-link", function(e) {
        e.preventDefault();
        let category = $(this).data("category");
        window.location.href = "<%= request.getContextPath() %>/app/product-list?category=" + category;
    });

    <% if(isLoggedIn) { %>
    // JWT token from JSP
    const jwtToken = "<%= jwtToken.getValue() %>";
    console.log("JWT from JSP:", jwtToken);

    // Profile click handler
    $("#profile-btn").on("click", function() {
        $.ajax({
            url: "<%= request.getContextPath() %>/app/buyer/profile",
            type: "GET",
            headers: { "Authorization": "Bearer " + jwtToken },
            success: function(data) {
                document.open();
                document.write(data);
                document.close();
            },
            error: function(xhr) {
                console.error("Profile load failed:", xhr.status, xhr.responseText);
                alert("Unauthorized! Please log in again.");
            }
        });
    });
    <% } %>

});
</script>
