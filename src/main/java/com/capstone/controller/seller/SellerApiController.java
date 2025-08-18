package com.capstone.controller.seller;
 
 
import com.capstone.model.OrderHeader;
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
    @PostMapping("/products")
    public String addProduct(@Valid @RequestBody Product product) {
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
 
    @PutMapping("/products/{id}")
    public String updateProduct(@PathVariable long id, @Valid @RequestBody Product product) {
        product.setId(id);
        productService.saveProduct(product);
        return "Product updated successfully";
    }
 
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
    
    @GetMapping("/searchProducts")
    public List<Product> searchProducts(
        @RequestParam(required = false) String prodName,
        @RequestParam(required = false) String category,
        @RequestParam(required = false) Double minPrice,
        @RequestParam(required = false) Double maxPrice) {
        
        return productService.searchProducts(prodName, category, minPrice, maxPrice);
    }
    
    
 // New endpoint for searching orders
    @GetMapping("/searchOrders")
    public List<OrderHeader> searchOrders(
            @RequestParam("sellerId") long sellerId,
            @RequestParam(value = "orderStatus", required = false) String orderStatus,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate) {
        
        return orderService.searchOrders(sellerId, orderStatus, startDate, endDate);
    }
}
 
 