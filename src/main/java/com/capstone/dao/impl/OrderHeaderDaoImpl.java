

package com.capstone.dao.impl;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;


import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.capstone.dao.OrderHeaderDao;
import com.capstone.model.OrderHeader;
import com.capstone.model.OrderItem;


@Repository
@Transactional
public class OrderHeaderDaoImpl implements OrderHeaderDao{

	
	@Autowired
	private SessionFactory sessionFactory;
	
	
	@Override
	public List<OrderHeader> getAllOrders(long id) {
		// TODO Auto-generated method stub
		 return sessionFactory.getCurrentSession()
			        .createQuery("from OrderHeader oh where oh.buyer.id = :buyerId", OrderHeader.class)
			        .setParameter("buyerId", id)
			        .list();
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
        // JPA Criteria API implementation for searching orders with filtering
        CriteriaBuilder cb = sessionFactory.getCurrentSession().getCriteriaBuilder();
        CriteriaQuery<OrderHeader> cq = cb.createQuery(OrderHeader.class);
        Root<OrderHeader> root = cq.from(OrderHeader.class);
        
        // Start building predicates
        Predicate predicate = cb.equal(root.get("seller").get("id"), sellerId);

        if (orderStatus != null && !orderStatus.isEmpty()) {
            predicate = cb.and(predicate, cb.equal(root.get("orderStatus"), orderStatus));
        }

        if (startDate != null && !startDate.isEmpty()) {
            predicate = cb.and(predicate, cb.greaterThanOrEqualTo(root.get("orderDate"), startDate));
        }

        if (endDate != null && !endDate.isEmpty()) {
            predicate = cb.and(predicate, cb.lessThanOrEqualTo(root.get("orderDate"), endDate));
        }

        // Apply the predicates to the CriteriaQuery
        cq.select(root).where(predicate);
        
  
        return sessionFactory.getCurrentSession().createQuery(cq).getResultList();
    }



	

}
