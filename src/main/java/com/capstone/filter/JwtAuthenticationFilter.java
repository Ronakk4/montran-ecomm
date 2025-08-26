package com.capstone.filter;

import com.capstone.util.JwtUtil;
import io.jsonwebtoken.Claims;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.security.web.util.matcher.RequestMatcher;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import java.io.IOException;
import java.util.Collections;

public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private RequestMatcher skipUrls;

    public void setSkipUrls(RequestMatcher skipUrls) {
        this.skipUrls = skipUrls;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest req,
                                    HttpServletResponse res,
                                    FilterChain chain) throws ServletException, IOException {

        String servletPath = req.getServletPath();

        // ✅ Check skipUrls first
        if (skipUrls != null && skipUrls.matches(req)) {
            chain.doFilter(req, res);
            return;
        }

        String token = null;
        boolean isApiRequest = servletPath.startsWith("/api/");

        if (isApiRequest) {
            String authHeader = req.getHeader("Authorization");
            if (authHeader != null && authHeader.startsWith("Bearer ")) {
                token = authHeader.substring(7);
            }
        } else {
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
            // ✅ Let Spring Security handle permitAll instead of forcing 401
            chain.doFilter(req, res);
            return;
        }

        try {
            Claims claims = JwtUtil.validateToken(token).getBody();
            String userType = claims.get("userType", String.class);
            Long userId = claims.get("userId", Long.class);

            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(
                            userId,
                            null,
                            Collections.singleton(() -> userType.toLowerCase())
                    );

            SecurityContextHolder.getContext().setAuthentication(authentication);
            req.setAttribute("userType", userType);
            req.setAttribute("userId", userId);

            chain.doFilter(req, res);
        } catch (Exception ex) {
            res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid or expired token");
        }
    }

}