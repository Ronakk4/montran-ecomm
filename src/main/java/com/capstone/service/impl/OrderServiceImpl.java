//package com.capstone.service.impl;
//
//import java.util.List;
//
//import javax.transaction.Transactional;
//
//import org.springframework.stereotype.Service;
//
//import com.capstone.service.Order;
//import com.capstone.service.OrderService;
//
//@Service
//public class OrderServiceImpl implements OrderService{
//	
//	@AutoWired
//	private OrderDao orderDao;
//
//	@Override
//	@Transactional
//	public List<Order> getAllOrders(long id) {
//		// TODO Auto-generated method stub
//		return orderdao.findAll(id);
//	}
//
//	@Override
//	@Transactional
//	public Order getOrder(long id) {
//		// TODO Auto-generated method stub
//		return orderDao.find(id);
//	}
//
//	@Override
//	@Transactional
//	public void deleteOrder(long id) {
//		// TODO Auto-generated method stub
//		orderDao.delete(id);
//		
//	}
//
//	@Override
//	@Transactional
//	public void saveOrder(Order o) {
//		// TODO Auto-generated method stub
//		orderDao.save(o);
//		
//	}
//
//}
