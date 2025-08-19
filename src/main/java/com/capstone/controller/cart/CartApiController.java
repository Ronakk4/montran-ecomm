
package com.capstone.controller.cart;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.capstone.dto.AddToCartDTO;
import com.capstone.dto.CartResponseDTO;
import com.capstone.service.CartService;

@RestController
@RequestMapping("/api/cart")
public class CartApiController {
	@Autowired
	private CartService cartService;

	@GetMapping
	public List<CartResponseDTO> getCartForBuyer( HttpServletRequest request) {
		 Long buyerId = (Long) request.getAttribute("userId");
		 System.out.println(buyerId);
		return cartService.getCartForBuyer(buyerId);
	}

//	@PostMapping
//	@PutMapping
//	public String addProductToCart(@RequestBody AddToCartDTO cartItem) {
//		return cartService.addProductToCart(cartItem);
//	}

	@DeleteMapping
	public String deleteProductFromCart(HttpServletRequest request, @RequestParam long prodId) {
		 Long buyerId = (Long) request.getAttribute("userId");
		cartService.deleteProductFromCart(buyerId, prodId);
		return "product deleted successfully";
	}
	
	 @PostMapping
	    public ResponseEntity<String> addProductToCart(@RequestBody AddToCartDTO cartItem,
	                                                   HttpServletRequest request) {
//		 System.out.println("called addcart");
	        Long buyerId = (Long) request.getAttribute("userId");
	        System.out.println(buyerId);
	        if (buyerId == null) {
	            return ResponseEntity.status(401).body("Unauthorized");
	        }
	        cartItem.setBuyerId(buyerId);  // backend decides userId
	        return ResponseEntity.ok(cartService.addProductToCart(cartItem));
	    }
	 
	 @PutMapping
	    public ResponseEntity<String> UpdateProductToCart(@RequestBody AddToCartDTO cartItem,
	                                                   HttpServletRequest request) {
//		 System.out.println("called addcart");
	        Long buyerId = (Long) request.getAttribute("userId");
	        System.out.println(buyerId);
	        if (buyerId == null) {
	            return ResponseEntity.status(401).body("Unauthorized");
	        }
	        cartItem.setBuyerId(buyerId);  // backend decides userId
	        return ResponseEntity.ok(cartService.addProductToCart(cartItem));
	    }

//	 @DeleteMapping("/deleteCart")
//	    public ResponseEntity<String> DeleteAllCartItems(long userId){
////		 System.out.println("called addcart");
//	          
//	       
//	        return ResponseEntity.ok(cartService.deleteAllCartItems(userId));
//	    }

}