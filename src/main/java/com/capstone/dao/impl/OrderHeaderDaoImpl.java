
package com.capstone.dao.impl;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.criteria.Predicate; 


import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Join;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.capstone.dao.OrderHeaderDao;
import com.capstone.dto.OrderDTO;
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
	    CriteriaBuilder cb = sessionFactory.getCurrentSession().getCriteriaBuilder();
	    CriteriaQuery<OrderHeader> cq = cb.createQuery(OrderHeader.class);
	    Root<OrderHeader> root = cq.from(OrderHeader.class);

	    // join with items
	    Join<Object, Object> itemsJoin = root.join("items");  // "items" is the list in OrderHeader
	    Join<Object, Object> productJoin = itemsJoin.join("product"); 
	    Join<Object, Object> sellerJoin = productJoin.join("seller");

	    List<Predicate> predicates = new ArrayList<>();

	    // 1. Seller filter
	    predicates.add(cb.equal(sellerJoin.get("id"), sellerId));

	    // 2. Order Status filter (optional)
	    if (orderStatus != null && !orderStatus.isEmpty()) {
	        predicates.add(cb.equal(root.get("status"), orderStatus));
	    }

	    // 3. Date range filter (optional)
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    if (startDate != null && !startDate.isEmpty()) {
	        LocalDate start = LocalDate.parse(startDate, formatter);
	        LocalDateTime startDateTime = start.atStartOfDay();
	        predicates.add(cb.greaterThanOrEqualTo(root.get("orderDate"), startDateTime));
	    }
	    if (endDate != null && !endDate.isEmpty()) {
	        LocalDate end = LocalDate.parse(endDate, formatter);
	        LocalDateTime endDateTime = end.atTime(23, 59, 59);
	        predicates.add(cb.lessThanOrEqualTo(root.get("orderDate"), endDateTime));
	    }

	    cq.select(root).distinct(true)  // prevent duplicates due to join
	      .where(cb.and(predicates.toArray(new Predicate[0])))
	      .orderBy(cb.desc(root.get("orderDate")));

	    return sessionFactory.getCurrentSession().createQuery(cq).getResultList();
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
