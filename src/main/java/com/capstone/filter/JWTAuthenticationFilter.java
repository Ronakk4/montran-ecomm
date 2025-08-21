package com.capstone.filter;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import com.capstone.util.JwtUtil;
import io.jsonwebtoken.Claims;

public class JWTAuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Optional: init logic
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String servletPath = req.getServletPath();

        // Allow login and register endpoints without token
        if ("/login".equals(servletPath) || "/register".equals(servletPath)) {
            chain.doFilter(request, response);
            return;
        }

        String token = null;

        // 1️⃣ Check Authorization header
        String authHeader = req.getHeader("Authorization");
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            token = authHeader.substring(7);
            System.out.println("[JWT Filter] Token extracted from Authorization header");
        }

        if (token == null || token.isEmpty()) {
            res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Missing token");
            return;
        }

        try {
            Claims claims = JwtUtil.validateToken(token).getBody();

            String userType = claims.get("userType", String.class);

            // ✅ Fix: extract numeric claim safely
            Number userIdNumber = claims.get("userId", Number.class);
            Long userId = userIdNumber != null ? userIdNumber.longValue() : null;

            req.setAttribute("userId", userId);
            req.setAttribute("userType", userType);

            // Optional: role-based access
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

            // Token valid
            chain.doFilter(request, response);

        } catch (Exception ex) {
            res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid or expired token");
        }
    }

    @Override
    public void destroy() {
        // Optional cleanup
    }
}
