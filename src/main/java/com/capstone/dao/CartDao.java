package com.capstone.dao;

import java.util.List;

import com.capstone.model.Cart;

public interface CartDao {
	List<Cart> getCartForBuyer(long buyerId);
	Cart findByBuyerAndProduct(long buyerId, long prodId);
	void saveCart(Cart cart);
	void deleteCart(long buyerId, long prodId);
	void updateCart(Cart existingCart);
	void deleteAllCartItems(long id);
}
