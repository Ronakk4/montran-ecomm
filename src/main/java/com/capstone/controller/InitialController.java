package com.capstone.controller;



import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/app")
public class InitialController {

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }
    
    
    @GetMapping("/home")
    public String homePage() {
    	return "home";
    }
    
    @GetMapping("/register")
    public String registerBuyerPage() {
        return "registerBuyer";
    }
    
    @GetMapping("/registerseller")
    public String registerSellerPage() {
    	return "registerSeller";
    }
    
    @GetMapping("/seller-login")
    public String sellerLoginPage() {
        return "sellerLogin";
    }

    @GetMapping("login/products")
    public String productsPage() {
        return "product";
    }
    
//    @GetMapping("/cart")
//    public String cart() {
//    	return "cart";
//    }

    @GetMapping("/orders")
    public String ordersPage() {
        return "orders";
    }

//    @GetMapping("/dashboard")
//    public String dashboardPage() {
//        return "dashboard";
//    }
    
    
    @GetMapping("/product-details")
    public String productDetails() {
    	return "product-details";
    }
    
    @GetMapping("/product-list")
    public String productList() {
    	return "productList";
    }
    
    
}