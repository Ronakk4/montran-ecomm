package com.capstone.dao;

import java.util.List;

import com.capstone.dto.SellerOrderDTO;
import com.capstone.model.OrderItem;

public interface OrderItemDao {
	List<OrderItem> getAllItem(int id);
	void addOrderItem(List<OrderItem> orderItem);
	void deleteOrderItem(List<OrderItem> orderItem);
	
	void updateOrderItem(OrderItem orderItem);
	List<OrderItem> getAllOrdersForSeller(long sellerId);
	
	
	

}
