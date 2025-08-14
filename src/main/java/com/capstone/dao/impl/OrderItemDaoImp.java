package com.capstone.dao.impl;

import java.util.List;


import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
//import com.capstone.controller.BuyerController;

import com.capstone.dao.OrderItemDao;
import com.capstone.model.OrderHeader;
import com.capstone.model.OrderItem;


@Repository
@Transactional
public class OrderItemDaoImp implements OrderItemDao {
	@Autowired
	SessionFactory sessionFactory;

	@Override
	public List<OrderItem> getAllItem(int id) {
		// TODO Auto-generated method stub
		
		Query<OrderItem>q=sessionFactory.getCurrentSession().createQuery("from OrderItem where id=:ids");
		q.setParameter("ids",id );
		return q.list();
	}

	@Override
	public void addOrderItem(List<OrderItem> orderItem) {
		// TODO Auto-generated method stub
		for(OrderItem o:orderItem) {
			sessionFactory.getCurrentSession().save(o);
		}
		
	}

	@Override
	public void deleteOrderItem(List<OrderItem> orderItem) {
		// TODO Auto-generated method stub
		for(OrderItem o:orderItem) {
			sessionFactory.getCurrentSession().delete(o);
		}
		
		
	}

	@Override
	public void updateOrderItem(OrderItem orderItem) {
		// TODO Auto-generated method stub
		 sessionFactory.getCurrentSession().saveOrUpdate(orderItem);
		
	}
}

    

   
