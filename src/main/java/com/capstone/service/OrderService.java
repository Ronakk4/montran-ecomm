
package com.capstone.service;

import java.util.List;

import com.capstone.dto.OrderDTO;
import com.capstone.model.OrderHeader;

public interface OrderService {
	List<OrderHeader> getAllOrders(long id);
	OrderHeader getOrder(long id);
	void deleteOrder(long id);
<<<<<<< HEAD
	void saveOrder(OrderHeader o);
	// New method to search orders with filters
    List<OrderHeader> searchOrders(long sellerId, String orderStatus, String startDate, String endDate);
=======
	void saveOrder(OrderDTO o);
>>>>>>> 5631ad52eb4eff248ae2343ad35c8e766c425dab
}

