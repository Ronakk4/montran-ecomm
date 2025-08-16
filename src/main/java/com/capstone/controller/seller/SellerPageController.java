package com.capstone.controller.seller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("app/seller")
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

    @GetMapping("/orders")
    public String ordersPage() {
        return "Seller Side/seller-orders"; // /WEB-INF/views/Seller Side/orders.jsp
    }
}
