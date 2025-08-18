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
    @GetMapping("/register-seller")
    public String registerSellerPage() {
    	return "registerSeller";
    }
    

    @GetMapping("login/products")
    public String productsPage() {
        return "product";
    }
    @GetMapping("/cart")
    public String cart() {
    	return "cart";
    }

    @GetMapping("/orders")
    public String ordersPage() {
        return "orders";
    }
    
    @GetMapping("/seller-login")
    public String sellerLoginPage() {
        return "sellerLogin";
    }
    

    
    @GetMapping("/product-details")
    public String productDetails() {
    	return "product-details";
    }
    
    @GetMapping("/product-list")
    public String productList() {
    	return "productList";
    }
    
    

}