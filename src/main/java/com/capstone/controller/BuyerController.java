
package com.capstone.controller;

import com.capstone.dto.OrderDTO;
import com.capstone.model.CartItem;
import com.capstone.model.OrderHeader;
import com.capstone.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/buyer")
public class BuyerController {

    @Autowired
    private OrderService orderService;


    @GetMapping("/orders")
    public List<OrderDTO> getAllOrders(@RequestParam("buyerId") long buyerId) {
        return orderService.getAllOrders(buyerId);
    }

    
    @GetMapping("/orders/{id}")
    public OrderHeader getOrder(@PathVariable long id) {
        return orderService.getOrder(id);
    }


    @PostMapping("/orders")
    public String placeOrder(@RequestBody OrderDTO orderHeader) {
        orderService.saveOrder(orderHeader);
        return "Order placed successfully";
    }


    @PutMapping("/orders/{id}")
    public ResponseEntity<String> cancelOrder(@PathVariable long id) {
        boolean cancelled = orderService.cancelOrder(id);

        if (cancelled) {
            return ResponseEntity.ok("Order cancelled successfully");
        } else {
            return ResponseEntity.badRequest().body("Order cannot be cancelled");
        }
    }
    
    @PostMapping("/checkout")
    public ResponseEntity<?> checkout(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            return ResponseEntity.badRequest().body("Cart is empty");
        }
        OrderHeader order = orderService.placeOrder(cart);
        session.removeAttribute("cart");
        return ResponseEntity.ok(order);
    }
}

