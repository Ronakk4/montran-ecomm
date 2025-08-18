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

      // These endpoints are not mapped to this filter anyway, but harmless to allow:
      String servletPath = req.getServletPath(); // NO context path here

      if ("/login".equals(servletPath) || "/register".equals(servletPath) || servletPath.startsWith("/public")) {
        chain.doFilter(request, response);
        return;
      }

      // Since this filter is mapped ONLY to /app/buyer/* and /app/seller/*,
      // we can just validate the token and check role
      String token = null;
      Cookie[] cookies = req.getCookies();
      if (cookies != null) {
        for (Cookie c : cookies) {
          if ("jwtToken".equals(c.getName())) {
            token = c.getValue();
            break;
          }
        }
      }

      if (token == null || token.isEmpty()) {
        res.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Missing token");
        return;
      }

      try {
        Claims claims = JwtUtil.validateToken(token).getBody();
        String userType = claims.get("userType", String.class); // exact key

        boolean buyerArea  = servletPath.startsWith("/app/buyer");
        boolean sellerArea = servletPath.startsWith("/app/seller");

        if (buyerArea  && !"buyer".equalsIgnoreCase(userType)) {
          res.sendError(HttpServletResponse.SC_FORBIDDEN, "Only buyers can access this resource");
          return;
        }
        if (sellerArea && !"seller".equalsIgnoreCase(userType)) {
          res.sendError(HttpServletResponse.SC_FORBIDDEN, "Only sellers can access this resource");
          return;
        }

        // OK
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

