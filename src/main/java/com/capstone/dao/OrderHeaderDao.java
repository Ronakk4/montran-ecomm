package com.capstone.dao;

import java.util.List;
import com.capstone.model.OrderHeader;
import com.capstone.model.OrderItem;


public interface OrderHeaderDao {

	List<OrderHeader> getAllOrders(long id);
	OrderHeader getOrder(long id);
	void deleteOrder(long id);
	void saveOrder(OrderHeader o);
	
	// New method for searching orders
    List<OrderHeader> searchOrders(long sellerId, String orderStatus, String startDate, String endDate);
	List<OrderItem> getAllOrdersForSeller(long id);

}
