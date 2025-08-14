//package com.capstone.dao.impl;
//
//import java.util.List;
//
//import javax.transaction.Transactional;
//
//import org.hibernate.Session;
//import org.hibernate.SessionFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Repository;
//
////import com.capstone.dao.Order;
//import com.capstone.dao.OrderDao;
//import com.capstone.model.Order;
//
//
//@Repository
//@Transactional
//public class OrderDaoImpl implements OrderDao{
//
//	
//	@Autowired
//	private SessionFactory sessionFactory;
//	
//	
//	@Override
//	public List<Order> getAllOrders(long id) {
//		// TODO Auto-generated method stub
//		return sessionFactory.getCurrentSession().createQuery("from Order",Order.class).list();
//	}
//
//	@Override
//	public Order getOrder(long id) {
//		// TODO Auto-generated method stub
//		return sessionFactory.getCurrentSession().get("Order.class", id);
//	}
//
//	@Override
//	public void deleteOrder(long id) {
//		// TODO Auto-generated method stub
//		sessionFactory.getCurrentSession().delete(id);
//	}
//
//	@Override
//	public void saveOrder(Order o) {
//		// TODO Auto-generated method stub
//		sessionFactory.getCurrentSession().save(o);
//	}
//
//	@Override
//	public void saveOrder(com.capstone.dao.Order o) {
//		// TODO Auto-generated method stub
//		
//	}
//
//}
