package com.capstone.controller.seller;

import com.capstone.dto.ProductFetchDTO;
import com.capstone.dto.ProductInsertDTO;
import com.capstone.dto.SellerOrderDTO;
import com.capstone.dto.SellerOrderDTO;
import com.capstone.model.Product;
// import com.capstone.model.ProductHistory;
import com.capstone.service.OrderService;
import com.capstone.service.ProductService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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
    	
    	
        
        productService.saveProduct(product);
        return "Product added successfully";
    }


   @GetMapping("/products")
   public List<Product> getProductsForSeller(@RequestParam("sellerId") long sellerId) {
       return productService.getProductsBySellerId(sellerId);
   }


   @GetMapping("/products/{id}")
   public ProductFetchDTO getProduct(@PathVariable long id) {
       Product product = productService.getProduct(id);
       return new ProductFetchDTO(product);
   }


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
    
    @PutMapping("/order-status")
    public String updateOrderStatus(@RequestParam long orderId, @RequestParam String status) {
    	orderService.updateStatus(orderId, status);
    	return "order updated";
    }
    
    @GetMapping("/category")
    public List<String> getAllCategories(){
    	return productService.getAllCategories();
    	
    }
    
    @GetMapping("/searchProducts")
	public List<Product> searchProducts(@RequestParam(required = false) String prodName,
			@RequestParam(required = false) String category, @RequestParam(required = false) Double minPrice,
			@RequestParam(required = false) Double maxPrice) {

		return productService.searchProducts(prodName, category, minPrice, maxPrice);
	}

	// New endpoint for searching orders
	@GetMapping("/searchOrders")
	public List<SellerOrderDTO> searchOrders(@RequestParam("sellerId") long sellerId,
			@RequestParam(value = "orderStatus", required = false) String orderStatus,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate) {

		return orderService.searchOrders(sellerId, orderStatus, startDate, endDate);
	}
	
	@GetMapping("/analytics")
    public Map<String, Object> getMonthlySalesAndRevenue(@RequestParam long sellerId) {
        return orderService.getMonthlySalesAndRevenue(sellerId);
    }
	
	@GetMapping("/getDeletedProducts")
	public List<ProductHistory> getDeletedProducts(){
		return productService.getDeletedProducts();
	}

}