package com.capstone.controller.seller;

import com.capstone.dto.ProductInsertDTO;
import com.capstone.model.OrderItem;


import com.capstone.dto.ProductInsertDTO;
import com.capstone.dto.SellerOrderDTO;

import com.capstone.model.Product;
import com.capstone.service.OrderService;
import com.capstone.service.ProductService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@RestController
@RequestMapping("/api/seller")
public class SellerApiController {

   @Autowired
   private ProductService productService;

   @Autowired
   private OrderService orderService;

   // ========== PRODUCT APIs ==========
//   @PostMapping("/products")
//   public String addProduct(@Valid @RequestBody Product product) {
//       productService.saveProduct(product);
//       return "Product added successfully";
//   }

    // ========== PRODUCT APIs ==========
    @PostMapping("/products")
    public String addProduct(@Valid @RequestBody ProductInsertDTO product, HttpSession session) {
    	
    	// Set seller from session
    	long sellerId = 16;
//    	seller.setId((long) session.getAttribute("sellerId"));
        product.setSellerId(sellerId);
        
        productService.saveProduct(product);
        return "Product added successfully";
    }


   @GetMapping("/products")
   public List<Product> getProductsForSeller(@RequestParam("sellerId") long sellerId) {
       return productService.getProductsBySellerId(sellerId);
   }


   @GetMapping("/products/{id}")
   public Product getProduct(@PathVariable long id) {
       return productService.getProduct(id);
   }

   
   // ========== ORDER APIs ==========

    @PutMapping("/products/{id}")
    public String updateProduct(@PathVariable long id, @Valid @RequestBody ProductInsertDTO product) {
    	product.setProdId(id);
        productService.updateProduct(product);
        System.out.println(product);
        return "Product updated successfully";
    }

    @DeleteMapping("/products/{id}")
    public String deleteProduct(@PathVariable long id) {
        productService.deleteProduct(id);
        return "Product deleted successfully";
    }
    
    // ========== ORDER APIs ==========
    @GetMapping("/orders")
    public List<SellerOrderDTO> getSellerOrders(@RequestParam long sellerId) {
        return orderService.getOrdersForSeller(sellerId);
    }
    
    @GetMapping("/category")
    public List<String> getAllCategories(){
    	return productService.getAllCategories();
    	
    }

}
