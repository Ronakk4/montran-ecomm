package com.capstone.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
	public List<CartResponseDTO> getCartForBuyer(@RequestParam long buyerId){
		return cartService.getCartForBuyer(buyerId);
	}
	
	@PostMapping
	@PutMapping
	public String addProductToCart(@RequestBody AddToCartDTO cartItem) {
		return cartService.addProductToCart(cartItem);
	}
	
	@DeleteMapping
	public String deleteProductFromCart(@RequestParam long buyerId, @RequestParam long prodId) {
		cartService.deleteProductFromCart(buyerId, prodId);
		return "product deleted successfully";
	}
	
	
}
