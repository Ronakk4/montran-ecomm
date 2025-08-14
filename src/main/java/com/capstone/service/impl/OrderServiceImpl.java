
package com.capstone.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.OrderHeaderDao;
import com.capstone.model.OrderHeader;
import com.capstone.model.OrderItem;
import com.capstone.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
<<<<<<< HEAD
	private OrderHeaderDao orderDao;  // choose camel case 'orderDao'
=======
	private OrderDao orderDao;// choose camel case 'orderDao'
>>>>>>> fc6b824bf006299b4830481f591be2afc7d72c06

	@Override
	@Transactional
	public List<OrderHeader> getAllOrders(long id) {
	    return orderDao.getAllOrders(id);
	}

	@Override
	@Transactional
	public OrderHeader getOrder(long id) {
	    return orderDao.getOrder(id);
	}

	@Override
	@Transactional
	public void deleteOrder(long id) {
	    orderDao.deleteOrder(id);
	}

	@Override
	@Transactional
	public void saveOrder(OrderHeader orderHeader) {
	    // Set the back-reference for all items
	    if (orderHeader.getItems() != null) {
	        for (OrderItem item : orderHeader.getItems()) {
	            item.setOrderHeader(orderHeader);
	        }
	    }
	    orderDao.saveOrder(orderHeader);
	}


}
