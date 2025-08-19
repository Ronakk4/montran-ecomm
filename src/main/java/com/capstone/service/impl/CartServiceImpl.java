package com.capstone.service.impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.CartDao;
import com.capstone.dao.ProductDao;
import com.capstone.dao.UserDao;
import com.capstone.dto.AddToCartDTO;
import com.capstone.dto.CartResponseDTO;
import com.capstone.model.Buyer;
import com.capstone.model.Cart;
import com.capstone.model.Product;
import com.capstone.service.CartService;

@Service
@Transactional
public class CartServiceImpl implements CartService{
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private CartDao cartDao;

	@Override
	public String addProductToCart(AddToCartDTO cartDto) {
		Buyer buyer = (Buyer) userDao.findUserById(cartDto.getBuyerId());
		Product product = productDao.getProduct(cartDto.getProductId());
		
		Cart existingCart = cartDao.findByBuyerAndProduct(buyer.getId(), product.getProdId());
		if(existingCart != null) {
			existingCart.setQuantity(cartDto.getQuantity());
			cartDao.updateCart(existingCart);
			return "Product updated";
		}

		Cart cartItem = new Cart();
		cartItem.setBuyer(buyer);
		cartItem.setProduct(product);
		cartItem.setQuantity(cartDto.getQuantity());
		cartItem.setAddedAt(LocalDateTime.now());
		
		cartDao.saveCart(cartItem);
		return "product added";
	}

	@Override
	public void deleteProductFromCart(long buyerId, long prodId) {
		cartDao.deleteCart(buyerId, prodId);
	}
	
	@Override
	public List<CartResponseDTO> getCartForBuyer(long buyerId) {
	    List<Cart> carts = cartDao.getCartForBuyer(buyerId);

	    return carts.stream().map(c -> {
	        CartResponseDTO dto = new CartResponseDTO();
	        dto.setCartId(c.getCartId());
	        dto.setProductId(c.getProduct().getProdId());
	        dto.setProductName(c.getProduct().getProdName());
	        dto.setProductPrice(c.getProduct().getPrice());
	        dto.setQuantity(c.getQuantity());
	        return dto;
	    }).collect(Collectors.toList()); // ✅ requires import
	}


}
