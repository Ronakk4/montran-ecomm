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
                    <li class="nav-item"><a href="<%= request.getContextPath() %>/app/buyer/profile" class="nav-link">Profile</a></li>
                    <li class="nav-item"><a href="<%= request.getContextPath() %>/users/logout" class="nav-link">Logout</a></li>
                <% } else { %>
                    <li class="nav-item"><a href="<%= request.getContextPath() %>/app/login" class="nav-link">Login</a></li>
                    <li class="nav-item"><a href="<%= request.getContextPath() %>/app/register" class="nav-link">Sign Up</a></li>
                <% } %>

            </ul>
        </div>

        <div class="nav-shop">
            <a href="${pageContext.request.contextPath}/app/cart">
                <i class="bx bx-shopping-bag"></i>
            </a>
        </div>
    </nav>
</header>

<script>
$(document).ready(function() {
    loadCategories();
    $(document).on("click", ".category-link", function(e) {
        e.preventDefault();
        let category = $(this).data("category");
        window.location.href = "<%= request.getContextPath() %>/app/product-list?category=" + category;
    });
});

function loadCategories() {
    $.get("http://localhost:8080/ecomm.capstone/api/seller/category", function(categories) {
        console.log("RAW categories:", categories);

        let items = "";
        categories.forEach(c => {
<!--            console.log("Category:", c);-->
            console.log(`Category ${c}:`, c, typeof c);

            items += `
                <li>
                    <a href="#" 
                       class="dropdown-item category-link" 
                       data-category="\${c}">\${c}
                    </a>
                </li>`;
        });

        $(".dropdown-menu").html(items);
    });
}
</script>
