package com.capstone.controller.cart;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/cart")
public class CartPageController {

    @GetMapping
    public String showCart() {
        return "CartViews/cart";
    }

    @GetMapping("/checkout")
    public String showCheckoutPage() {
        return "CartViews/checkout";
    }

    @GetMapping("/order-success")
    public String showSuccessPage() {
        return "CartViews/order-success";
    }
}
