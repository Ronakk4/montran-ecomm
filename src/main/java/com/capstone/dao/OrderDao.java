package com.capstone.dao;

import java.util.List;

public interface OrderDao {
	List<Order> getAllOrders(long id);
	Order getOrder(long id);
	void deleteOrder(long id);
	void saveOrder(Order o);
}
