package com.capstone.dao.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//import com.capstone.dao.Order;
import com.capstone.dao.OrderDao;
import com.capstone.model.OrderHeader;


@Repository
@Transactional
public class OrderDaoImpl implements OrderDao{

	
	@Autowired
	private SessionFactory sessionFactory;
	
	
	@Override
	public List<OrderHeader> getAllOrders(long id) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createQuery("from OrderHeader	",OrderHeader.class).list();
	}

	@Override
	public OrderHeader getOrder(long id) {
		// TODO Auto-generated method stub
		return (OrderHeader) sessionFactory.getCurrentSession().get("OrderHeader.class", id);
	}

	@Override
	public void deleteOrder(long id) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().delete(id);
	}
	


	@Override
	public void saveOrder(OrderHeader o) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().save(o);
	}

}
