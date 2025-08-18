
package com.capstone.service;

import java.util.List;

import com.capstone.dto.OrderDTO;
import com.capstone.dto.SellerOrderDTO;
import com.capstone.model.OrderHeader;
import com.capstone.model.OrderItem;

public interface OrderService {
	List<OrderHeader> getAllOrders(long id);
	List<SellerOrderDTO> getOrdersForSeller(long sellerId);
	OrderHeader getOrder(long id);
	void deleteOrder(long id);

//	void saveOrder(OrderHeader o);
	// New method to search orders with filters
    List<OrderHeader> searchOrders(long sellerId, String orderStatus, String startDate, String endDate);

	void saveOrder(OrderDTO o);

}