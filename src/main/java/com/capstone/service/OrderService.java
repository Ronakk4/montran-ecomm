
package com.capstone.service;

import java.util.List;

import com.capstone.dto.OrderDTO;
import com.capstone.model.OrderHeader;

public interface OrderService {
	List<OrderHeader> getAllOrders(long id);
	OrderHeader getOrder(long id);
	void deleteOrder(long id);
	void saveOrder(OrderDTO o);
}

