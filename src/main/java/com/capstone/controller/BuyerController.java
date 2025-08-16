
package com.capstone.controller;

import com.capstone.dto.OrderDTO;
import com.capstone.model.OrderHeader;
import com.capstone.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/buyer")
public class BuyerController {

    @Autowired
    private OrderService orderService;


    @GetMapping("/orders")
    public List<OrderHeader> getAllOrders(@RequestParam("buyerId") long buyerId) {
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


    @DeleteMapping("/orders/{id}")
    public String cancelOrder(@PathVariable long id) {
        orderService.deleteOrder(id);
        return "Order cancelled successfully";
    }
}