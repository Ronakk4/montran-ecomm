package com.capstone.controller.seller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("app/seller")
public class SellerPageController {
	
    @GetMapping("/dashboard")
    public String dashboardPage(HttpServletResponse response) {
    	// Prevent caching
    	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    	response.setDateHeader("Expires", 0); // Proxies
        return "Seller Side/seller-dashboard";
    }
    
    @GetMapping("/profile")
    public String profile(HttpServletResponse response) {
    	// Prevent caching
    	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    	response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    	response.setDateHeader("Expires", 0); // Proxies
    	return "Seller Side/seller-profile";
    }
    
    @GetMapping("/products")
    public String productsPage() {
        return "Seller Side/seller-products"; // /WEB-INF/views/Seller Side/products.jsp
    }
    
    
    @GetMapping("/products/add-product")
    public String addProductPage() {
    	return "Seller Side/add-product"; // /WEB-INF/views/Seller Side/products.jsp
    }
    
    @GetMapping("/products/edit-product")
    public String editProductPage(@RequestParam long id,  Model model) {
    	model.addAttribute("productId", id);
    	return "Seller Side/edit-product"; // /WEB-INF/views/Seller Side/products.jsp
    }
    
    

    @GetMapping("/orders")
    public String ordersPage() {
        return "Seller Side/seller-orders"; // /WEB-INF/views/Seller Side/orders.jsp
    }
}
