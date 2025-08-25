package com.capstone.service.impl;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.capstone.service.ProductService;

@Service
@Transactional
public class CartServiceImpl implements CartService {

	@Autowired
	private UserDao userDao;

	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private ProductService productService;

	@Autowired
	private CartDao cartDao;

	@Override
	public String addProductToCart(AddToCartDTO cartDto) {
		Buyer buyer = (Buyer) userDao.findUserById(cartDto.getBuyerId());
		Product product = productDao.getProduct(cartDto.getProductId());

		Cart existingCart = cartDao.findByBuyerAndProduct(buyer.getId(), product.getProdId());
		if (existingCart != null) {
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

//	@Override
//	public List<CartResponseDTO> getCartForBuyer(long buyerId) {
//	    List<Cart> carts = cartDao.getCartForBuyer(buyerId);
//
//	    return carts.stream().map(c -> {
//	        CartResponseDTO dto = new CartResponseDTO();
//	        dto.setCartId(c.getCartId());
//	        dto.setProductId(c.getProduct().getProdId());
//	        dto.setProductName(c.getProduct().getProdName());
//	        dto.setProductPrice(c.getProduct().getPrice());
//	        dto.setQuantity(c.getQuantity());
//	        return dto;
//	    }).collect(Collectors.toList()); 
//	    
////	    List<CartResponseDTO> dtoList = new ArrayList<>();
////
////	    for (Cart c : carts) {
////	        CartResponseDTO dto = new CartResponseDTO();
////	        dto.setCartId(c.getCartId());
////	        dto.setProductId(c.getProduct().getProdId());
////	        dto.setProductName(c.getProduct().getProdName());
////	        dto.setProductPrice(c.getProduct().getPrice());
////	        dto.setQuantity(c.getQuantity());
////	        dtoList.add(dto);
////	    }
////
////	    return dtoList;
//
//	}

	@Override
	public List<CartResponseDTO> getCartForBuyer(long buyerId) {
		List<Cart> carts = cartDao.getCartForBuyer(buyerId);

		// 🔹 Map of productId -> stockQuantity
		Map<Long, Integer> stockMap = new HashMap<>();

		// Fetch stockQuantity for each product in cart
		for (Cart c : carts) {
			long productId = c.getProduct().getProdId();
			Product product = productService.getProduct(productId); // reuse your service
			stockMap.put(productId, product.getStockQuantity());
		}

		// Now map to DTOs and also include stockQuantity if you want
		return carts.stream().map(c -> {
			CartResponseDTO dto = new CartResponseDTO();
			dto.setCartId(c.getCartId());
			dto.setProductId(c.getProduct().getProdId());
			dto.setProductName(c.getProduct().getProdName());
			dto.setProductPrice(c.getProduct().getPrice());
			dto.setQuantity(c.getQuantity());

			// ✅ attach stockQuantity from map
			dto.setStockQuantity(stockMap.get(c.getProduct().getProdId()));

			return dto;
		}).collect(Collectors.toList());
	}

	@Override
	public void deleteAllCartItems(long id) {
		// TODO Auto-generated method stub
		cartDao.deleteAllCartItems(id);

	}

}
