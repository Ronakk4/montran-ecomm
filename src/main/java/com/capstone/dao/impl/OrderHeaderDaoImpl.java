
package com.capstone.dao.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.capstone.dao.OrderHeaderDao;
import com.capstone.model.OrderHeader;
import com.capstone.model.OrderItem;

@Repository
@Transactional
public class OrderHeaderDaoImpl implements OrderHeaderDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<OrderHeader> getAllOrders(long id) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession()
				.createQuery("from OrderHeader oh where oh.buyer.id = :buyerId", OrderHeader.class)
				.setParameter("buyerId", id).list();
	}

	@Override
	public OrderHeader getOrder(long id) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().get(OrderHeader.class, id);

	}

	@Override
	public void deleteOrder(long id) {
		// TODO Auto-generated method stub
		OrderHeader order = sessionFactory.getCurrentSession().get(OrderHeader.class, id);
		if (order != null) {
			sessionFactory.getCurrentSession().delete(order);
		}
	}

	@Override
	public void saveOrder(OrderHeader o) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().save(o);
	}

	@Override
	public List<OrderHeader> searchOrders(long sellerId, String orderStatus, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public Object[] getMonthlySalesAndRevenue(long sellerId) {
		return (Object[]) sessionFactory.getCurrentSession()
				.createNativeQuery("SELECT COUNT(DISTINCT oh.orderid) AS total_sales, " +
		                 "COALESCE(SUM(oi.price * oi.quantity), 0) AS total_revenue " +
		                 "FROM order_header oh " +
		                 "JOIN order_items oi ON oh.orderid = oi.order_id " +
		                 "WHERE DATE_TRUNC('month', oh.order_date) = DATE_TRUNC('month', CURRENT_DATE) " +
		                 "AND oi.seller_id = :sellerId")
				.setParameter("sellerId", sellerId)
				.uniqueResult();
	}
	

}
