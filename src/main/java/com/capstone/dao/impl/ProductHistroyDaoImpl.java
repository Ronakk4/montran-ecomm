package com.capstone.dao.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.capstone.dao.ProductHistoryDao;
import com.capstone.model.ProductHistory;

@Repository
@Transactional
public class ProductHistroyDaoImpl implements ProductHistoryDao {
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public String addProductHistory(ProductHistory productHistory) {	
		sessionFactory.getCurrentSession().save(productHistory);
		return "successfull";
	}

	@Override
	public List<ProductHistory> getProductHistory() {
		return sessionFactory.getCurrentSession().createQuery("from ProductHistory", ProductHistory.class)
				.list();
	}

//	@Override
//	public ProductHistory getSingleProductHistory(long prodId) {
//		return sessionFactory.getCurrentSession().get(ProductHistory.class, prodId);
//	}

}
