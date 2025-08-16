
package com.capstone.dao;

import java.util.List;




import com.capstone.model.OrderHeader;
import com.capstone.model.OrderItem;



public interface OrderHeaderDao {

	List<OrderHeader> getAllOrders(long id);
	OrderHeader getOrder(long id);
	void deleteOrder(long id);
	void saveOrder(OrderHeader o);
	List<OrderItem> getAllOrdersForSeller(long id);
}
