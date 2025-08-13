//package com.capstone.controller;
//
//import com.capstone.model.Product;
//import com.capstone.model.Order;
//import com.capstone.service.ProductService;
//import com.capstone.service.OrderService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.*;
//import java.util.List;
//
//@RestController
//@RequestMapping("/seller")
//public class SellerController {
//
//    @Autowired
//    private ProductService productService;
//
//    @Autowired
//    private OrderService orderService;
//
//    @PostMapping("/products")
//    public String addProduct(@RequestBody Product product) {
//        productService.saveProduct(product);
//        return "Product added";
//    }
//
//    @PutMapping("/products/{id}")
//    public String updateProduct(@PathVariable Long id, @RequestBody Product product) {
//        product.setId(id);
//        productService.saveProduct(product);
//        return "Product updated";
//    }
//
//    @DeleteMapping("/products/{id}")
//    public String deleteProduct(@PathVariable Long id) {
//        productService.deleteProduct(id);
//        return "Product deleted";
//    }
//
//    @GetMapping("/orders")
//    public List<Order> getSellerOrders() {
//        return orderService.getOrdersForSeller();
//    }
//}
