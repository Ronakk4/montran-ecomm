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

    @GetMapping("/register")
    public String registerBuyerPage() {
        return "registerBuyer";
    }
    @GetMapping("/registerseller")
    public String registerSellerPage() {
    	return "registerSeller";
    }
    

    @GetMapping("login/products")
    public String productsPage() {
        return "product";
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