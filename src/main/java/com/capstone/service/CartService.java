package com.capstone.service;

import java.util.List;

import com.capstone.dto.AddToCartDTO;
import com.capstone.dto.CartResponseDTO;
import com.capstone.model.Cart;

public interface CartService {
	String addProductToCart(AddToCartDTO cartDto);
	void deleteProductFromCart(long buyerId, long prodId);
	List<CartResponseDTO> getCartForBuyer(long buyerId);
	void deleteAllCartItems(long id);
}
