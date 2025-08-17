//package com.capstone.filter;
//
//import java.io.IOException;
//import javax.servlet.Filter;
//import javax.servlet.FilterChain;
//import javax.servlet.FilterConfig;
//import javax.servlet.ServletException;
//import javax.servlet.ServletRequest;
//import javax.servlet.ServletResponse;
//import javax.servlet.annotation.WebFilter;
//import javax.servlet.http.HttpFilter;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//
//import com.capstone.util.JwtUtil;
//
//import io.jsonwebtoken.Claims;
//
///**
// * Servlet Filter implementation class JWTAuthenticationFilter
// */
//@WebFilter("/JWTAuthenticationFilter")
//public class JWTAuthenticationFilter extends HttpFilter implements Filter {
//       
//    /**
//     * @see HttpFilter#HttpFilter()
//     */
//    public JWTAuthenticationFilter() {
//        super();
//        // TODO Auto-generated constructor stub
//    }
//
//	/**
//	 * @see Filter#destroy()
//	 */
//	public void destroy() {
//		// TODO Auto-generated method stub
//	}
//
//	/**
//	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
//	 */
//	public void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
//		String authHeader = request.getHeader("Authorization");
//		String path = request.getRequestURI();
//		
//		System.out.println("called");
//		
//		if(path.contains("/app/login") || path.startsWith("/public")) {
//			chain.doFilter(request, response);
//			return;
//		}
//		
//		if(authHeader == null || !authHeader.startsWith("Bearer ")) {
//			response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Missing or invalid authorization header");
//			return;
//		}
//		
//		String token = authHeader.substring(7);
//		
//		try {
//			Claims claims = JwtUtil.validateToken(token).getBody();
//			request.setAttribute("claims", claims);
//			chain.doFilter(request, response);
//		}
//		catch (Exception e) {
//			response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "invalid or expired token");
//		}
//		// pass the request along the filter chain
//	}
//
//	/**
//	 * @see Filter#init(FilterConfig)
//	 */
//	public void init(FilterConfig fConfig) throws ServletException {
//		// TODO Auto-generated method stub
//	}
//
//}
