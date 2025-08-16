


package com.capstone.controller;

import com.capstone.dto.ProductInsertDTO;
import com.capstone.model.OrderHeader;
import com.capstone.model.Product;
import com.capstone.service.OrderService;
//import com.capstone.model.Order;
import com.capstone.service.ProductService;
//import com.capstone.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import javax.validation.Valid;

@RestController
@RequestMapping("/seller")
public class SellerController {

    @Autowired
    private ProductService productService;

    @Autowired
    private OrderService orderService;


    @GetMapping("/products")
    public List<Product> getAllProducts() {
        return productService.getAllProducts();
    }


    @GetMapping("/products/{id}")
    public Product getProduct(@PathVariable long id) {
        return productService.getProduct(id);
    }

    @PostMapping("/products")
    public String addProduct(@Valid @RequestBody Product product) {
        productService.saveProduct(product);
        return "Product added successfully";
    }



    @PutMapping("/products/{id}")
    public String updateProduct(@PathVariable long id,@Valid @RequestBody Product product) {
        product.setId(id);
        productService.saveProduct(product);
        return "Product updated successfully";
    }

//    @PutMapping("/products/{id}")
//    public String updateProduct(@PathVariable long id, @RequestBody Product product) {
//        product.setId(id);
//        productService.saveProduct(product);
//        return "Product updated successfully";
//    }



    @DeleteMapping("/products/{id}")
    public String deleteProduct(@PathVariable long id) {
        productService.deleteProduct(id);
        return "Product deleted successfully";
    }


    @GetMapping("/orders")
    public List<OrderHeader> getAllOrders(@RequestParam("sellerId") long sellerId) {
        return orderService.getAllOrders(sellerId);
    }
}

