package com.capstone.dao;

import java.util.List;

import com.capstone.model.OrderHeader;

public interface OrderDao {
	List<OrderHeader> getAllOrders(long id);
	OrderHeader getOrder(long id);
	void deleteOrder(long id);
	void saveOrder(OrderHeader o);
}
