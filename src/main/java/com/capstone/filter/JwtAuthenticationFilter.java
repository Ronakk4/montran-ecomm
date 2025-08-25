package com.capstone.filter;

import com.capstone.util.JwtUtil;
import io.jsonwebtoken.Claims;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import java.io.IOException;
import java.util.Collections;

public class JwtAuthenticationFilter extends OncePerRequestFilter {

    @Override
    protected void doFilterInternal(HttpServletRequest req,
                                    HttpServletResponse res,
                                    FilterChain chain) throws ServletException, IOException {

        String servletPath = req.getServletPath();

        // Skip filter for public endpoints (Spring already allows them)
        if (servletPath.equals("/") || 
                servletPath.startsWith("/users") || 
                servletPath.startsWith("/api/seller/category")) {
                chain.doFilter(req, res);
                return;
            }

        String token = null;
        boolean isApiRequest = servletPath.startsWith("/api/");

        if (isApiRequest) {
            // 🔹 API: Token only from Authorization header
            String authHeader = req.getHeader("Authorization");
            if (authHeader != null && authHeader.startsWith("Bearer ")) {
                token = authHeader.substring(7);
            }
        } else {
            // 🔹 For /app/... pages: from header or cookie
            String authHeader = req.getHeader("Authorization");
            if (authHeader != null && authHeader.startsWith("Bearer ")) {
                token = authHeader.substring(7);
            } else if (req.getCookies() != null) {
                for (Cookie c : req.getCookies()) {
                    if ("jwtToken".equals(c.getName())) {
                        token = c.getValue();
                        break;
                    }
                }
            }
        }

        if (token == null) {
            res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Missing token");
            return;
        }

        try {
            Claims claims = JwtUtil.validateToken(token).getBody();
            String userType = claims.get("userType", String.class);
            Long userId = claims.get("userId", Long.class);

            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(userId, null, 
                            Collections.singleton(() -> userType.toLowerCase()));
            SecurityContextHolder.getContext().setAuthentication(authentication);

            req.setAttribute("userType", userType);
            req.setAttribute("userId", userId);

            chain.doFilter(req, res);
        } catch (Exception ex) {
            res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid or expired token");
        }
    }
}
