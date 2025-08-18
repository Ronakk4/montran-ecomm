package com.capstone.controller.seller;


import com.capstone.dto.ProductInsertDTO;
import com.capstone.model.OrderItem;
import com.capstone.model.Product;
import com.capstone.service.OrderService;
import com.capstone.service.ProductService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

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

   @GetMapping("/products")
   public List<Product> getProductsForSeller(@RequestParam("sellerId") long sellerId) {
       return productService.getProductsBySellerId(sellerId);
   }


   @GetMapping("/products/{id}")
   public Product getProduct(@PathVariable long id) {
       return productService.getProduct(id);
   }


   @PostMapping("/products")
   public String addProduct(@Valid @RequestBody ProductInsertDTO product) {
       productService.saveProduct(product);
       return "Product added successfully";
   }



//    @PutMapping("/products/{id}")
//    public String updateProduct(@PathVariable long id,@Valid @RequestBody ProductInsertDTO product) {
//        product.setId(id);
//        productService.saveProduct(product);
//        return "Product updated successfully";
//    }

//   @PutMapping("/products/{id}")
//   public String updateProduct(@PathVariable long id, @Valid @RequestBody Product product) {
//       product.setId(id);
//       productService.saveProduct(product);
//       return "Product updated successfully";
//   }

   @DeleteMapping("/products/{id}")
   public String deleteProduct(@PathVariable long id) {
       productService.deleteProduct(id);
       return "Product deleted successfully";
   }
   
   // ========== ORDER APIs ==========
   @GetMapping("/orders")
   public List<OrderItem> getAllOrderForSeller(@RequestParam("sellerId") long sellerId) {
       return orderService.getAllOrdersForSeller(sellerId);
   }
}
