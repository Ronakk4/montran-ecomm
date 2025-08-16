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
    public String registerPage() {
        return "register";
    }

    @GetMapping("/products")
    public String productsPage() {
        return "products";
    }

    @GetMapping("/orders")
    public String ordersPage() {
        return "orders";
    }

    @GetMapping("/dashboard")
    public String dashboardPage() {
        return "dashboard";
    }
}