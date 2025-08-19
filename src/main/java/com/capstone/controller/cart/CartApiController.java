//package com.capstone.controller.cart;
//
//import com.capstone.dto.AddToCartDTO;
//import com.capstone.dto.CartResponseDTO;
//import com.capstone.model.CartItem;
//import com.capstone.model.Product;
//import com.capstone.service.CartService;
//import com.capstone.service.ProductService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//import java.util.ArrayList;
//import java.util.List;
//
//@RestController
//@RequestMapping("/api/cart")
//public class CartApiController {
//
//	@Autowired
//	private ProductService productService;
//
//	@Autowired
//	private CartService cartService;
//
//	
//	// ---------------- Add to cart ----------------
//	@PostMapping
//	public ResponseEntity<?> addToCart(@RequestBody AddToCartDTO dto,
//	                                   HttpServletRequest request,
//	                                   HttpSession session) {
//
//	    Long buyerId = (Long) request.getAttribute("userId"); // set by JWT filter
//
//	    if (buyerId != null ) {
//	        // ✅ Logged-in user → DB
//	        dto.setBuyerId(buyerId);
//	        return ResponseEntity.ok(cartService.addProductToCart(dto));
//	    } else {
//	        // ✅ Guest user → Session
//	        Product p = productService.getProduct(dto.getProductId());
//	        if (p == null || dto.getQuantity() <= 0 || dto.getQuantity() > p.getStockQuantity()) {
//	            return ResponseEntity.badRequest().body("Invalid product or quantity");
//	        }
//
//	        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
//	        if (cart == null) cart = new ArrayList<>();
//
//	        // 🔑 Check if item already exists → update quantity instead of duplicate
//	        CartItem existing = cart.stream()
//	                .filter(item -> item.getProductId() == dto.getProductId())
//	                .findFirst()
//	                .orElse(null);
//
//	        if (existing != null) {
//	            existing.setQuantity(existing.getQuantity() + dto.getQuantity());
//	        } else {
//	            cart.add(new CartItem(p, dto.getQuantity()));
//	        }
//
//	        session.setAttribute("cart", cart);
//
//	        return ResponseEntity.ok(buildCartResponse(cart));
//	    }
//	}
//
//
//	// ---------------- View cart ----------------
//	@GetMapping
//	public ResponseEntity<?> viewCart(HttpServletRequest request, HttpSession session) {
//		Long buyerId = (Long) request.getAttribute("userId");
//
//		if (buyerId != null) {
//			// Logged-in → fetch from DB
//			List<CartResponseDTO> cart = cartService.getCartForBuyer(buyerId);
//			return ResponseEntity.ok(cart);
//		} else {
//			// Guest → fetch from session
//			List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
//			if (cart == null)
//				cart = new ArrayList<>();
//			return ResponseEntity.ok(buildCartResponse(cart));
//		}
//	}
//
//	// ---------------- Remove item ----------------
//	@DeleteMapping("/remove/{productId}")
//	public ResponseEntity<?> removeFromCart(@PathVariable long productId, HttpServletRequest request,
//			HttpSession session) {
//		Long buyerId = (Long) request.getAttribute("userId");
//
//		if (buyerId != null) {
//			// Logged-in → remove from DB
//			cartService.deleteProductFromCart(buyerId, productId);
//			return ResponseEntity.ok("Product removed from cart");
//		} else {
//			// Guest → remove from session
//			List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
//			if (cart != null) {
//				cart.removeIf(item -> item.getProductId() == productId);
//				session.setAttribute("cart", cart);
//			}
//			return ResponseEntity.ok(buildCartResponse(cart == null ? new ArrayList<>() : cart));
//		}
//	}
//
//	// ---------------- Clear cart ----------------
//	@DeleteMapping("/clear")
//	public ResponseEntity<?> clearCart(HttpServletRequest request, HttpSession session) {
//		Long buyerId = (Long) request.getAttribute("userId");
//
//		if (buyerId != null) {
//			// Logged-in → clear DB cart
//			List<CartResponseDTO> cart = cartService.getCartForBuyer(buyerId);
//			for (CartResponseDTO item : cart) {
//				cartService.deleteProductFromCart(buyerId, item.getProductId());
//			}
//			return ResponseEntity.ok("Cart cleared for buyer: " + buyerId);
//		} else {
//			// Guest → clear session
//			session.removeAttribute("cart");
//			return ResponseEntity.ok(buildCartResponse(new ArrayList<>()));
//		}
//	}
//
//	// ---------------- Helper ----------------
//	private Object buildCartResponse(List<CartItem> cart) {
//		double grandTotal = cart.stream().mapToDouble(CartItem::getLineTotal).sum();
//		return new Object() {
//			public List<CartItem> cartItems = cart;
//			public double grandTotalAmount = grandTotal;
//		};
//	}
//}

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

}