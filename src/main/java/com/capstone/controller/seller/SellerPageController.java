package com.capstone.controller.seller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/seller")
public class SellerPageController {

    @GetMapping("/dashboard")
    public String dashboardPage() {
        // Will resolve to /WEB-INF/views/Seller Side/seller-dashboard.jsp
        return "Seller Side/seller-dashboard";
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
