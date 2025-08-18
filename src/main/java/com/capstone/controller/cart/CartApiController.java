package com.capstone.controller.cart;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.capstone.model.CartItem;
import com.capstone.model.Product;
import com.capstone.service.ProductService;

@RestController
@RequestMapping("/cart")
public class CartApiController {

    @Autowired
    private ProductService productService;

    @PostMapping("/add/{productId}")
    public ResponseEntity<?> addToCart(@PathVariable int productId, @RequestParam int qty, HttpSession session) {
        Product p = productService.getProduct(productId);
        if (p == null || qty <= 0 || qty > p.getStockQuantity()) {
            return ResponseEntity.badRequest().body("Invalid product or quantity");
        }
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();
        cart.add(new CartItem(p, qty));
        session.setAttribute("cart", cart);
        return ResponseEntity.ok(buildCartResponse(cart));
    }

    @GetMapping("/data")
    public ResponseEntity<?> viewCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();
        return ResponseEntity.ok(buildCartResponse(cart));
    }

    @PostMapping("/clear")
    public ResponseEntity<?> clearCart(HttpSession session) {
        session.removeAttribute("cart");
        return ResponseEntity.ok(buildCartResponse(new ArrayList<>()));
    }

    @PostMapping("/remove")
    public ResponseEntity<?> removeFromCart(@RequestParam long productId, HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart != null) {
            cart.removeIf(item -> item.getProductId() == productId);
            session.setAttribute("cart", cart);
        }
        return ResponseEntity.ok(buildCartResponse(cart == null ? new ArrayList<>() : cart));
    }

    private Object buildCartResponse(List<CartItem> cart) {
        double grandTotal = cart.stream().mapToDouble(CartItem::getLineTotal).sum();
        return new Object() {
            public List<CartItem> cartItems = cart;
            public double grandTotalAmount = grandTotal;
        };
    }
}
