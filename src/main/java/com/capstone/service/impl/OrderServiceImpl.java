
package com.capstone.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.OrderHeaderDao;
import com.capstone.dao.ProductDao;
import com.capstone.dao.UserDao;
import com.capstone.dto.OrderDTO;
import com.capstone.dto.OrderItemDTO;
import com.capstone.model.Buyer;
import com.capstone.model.OrderHeader;
import com.capstone.model.OrderItem;
import com.capstone.model.Product;
import com.capstone.model.Seller;
import com.capstone.model.User;
import com.capstone.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderHeaderDao orderDao;  
	
	@Autowired
	private ProductDao productDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private SessionFactory sessionFactory;

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
	public void saveOrder(OrderDTO order) {
	    Buyer buyer = sessionFactory.getCurrentSession().get(Buyer.class, order.getBuyerId());

	    // create OrderHeader
	    OrderHeader oh = new OrderHeader();
	    oh.setBuyer(buyer);
	    oh.setStatus(order.getStatus());
	    oh.setTotalAmount(order.getTotalAmount());

	    List<OrderItem> orderItems = new ArrayList<>();

	    for (OrderItemDTO itemOrder : order.getItems()) {
	        Product product = sessionFactory.getCurrentSession().get(Product.class, itemOrder.getProductId());
	        Seller seller = sessionFactory.getCurrentSession().get(Seller.class, itemOrder.getSellerId());

	        OrderItem orderItem = new OrderItem();
	        orderItem.setOrderHeader(oh); // associate with order
	        orderItem.setProduct(product);
	        orderItem.setSeller(seller);
	        orderItem.setQuantity(itemOrder.getQuantity());
	        orderItem.setPrice(itemOrder.getPrice());

	        orderItems.add(orderItem);
	    }

	    oh.setItems(orderItems);

	    // saving orderHeader will cascade to orderItems if mapped correctly
	    orderDao.saveOrder(oh);
	}






}
