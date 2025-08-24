package com.capstone.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import com.capstone.util.JwtUtil;
import io.jsonwebtoken.Claims;

public class JWTAuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // optional: init config
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String servletPath = req.getServletPath();


if ("/api/seller/category".equals(servletPath) ||
    servletPath.startsWith("/api/seller/category/")) {
    chain.doFilter(request, response);
    return;
}

        String token = null;
        boolean isApiRequest = servletPath.startsWith("/api/");

        // 🔹 If API request → must use Authorization header only
        if (isApiRequest) {
            String authHeader = req.getHeader("Authorization");
            if (authHeader != null && authHeader.startsWith("Bearer ")) {
                token = authHeader.substring(7); // strip "Bearer "
            }
        } else {
            // 🔹 For page navigation (/app/...) → header OR cookie
            String authHeader = req.getHeader("Authorization");
            if (authHeader != null && authHeader.startsWith("Bearer ")) {
                token = authHeader.substring(7);
            }

            if (token == null || token.isEmpty()) {
                Cookie[] cookies = req.getCookies();
                if (cookies != null) {
                    for (Cookie c : cookies) {
                        if ("jwtToken".equals(c.getName())) {
                            token = c.getValue();
                            break;
                        }
                    }
                }
            }
        }

        // 🔹 Reject if no token
        if (token == null || token.isEmpty()) {
            res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Missing token");
            return;
        }

        try {
            Claims claims = JwtUtil.validateToken(token).getBody();
            String userType = claims.get("userType", String.class);
            Long userId = claims.get("userId", Long.class);

            // Set attributes for downstream usage
            req.setAttribute("userId", userId);
            req.setAttribute("userType", userType);

            // ✅ Restrict access based on role
            boolean buyerArea = servletPath.startsWith("/app/buyer");
            boolean sellerArea = servletPath.startsWith("/app/seller");

            if (buyerArea && !"buyer".equalsIgnoreCase(userType)) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Only buyers can access this resource");
                return;
            }
            if (sellerArea && !"seller".equalsIgnoreCase(userType)) {
                res.sendError(HttpServletResponse.SC_FORBIDDEN, "Only sellers can access this resource");
                return;
            }

            chain.doFilter(request, response);

        } catch (Exception ex) {
            res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid or expired token");
        }
    }

    @Override
    public void destroy() {
        // cleanup
    }
}
