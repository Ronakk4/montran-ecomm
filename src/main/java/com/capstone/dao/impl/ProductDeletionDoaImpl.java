package com.capstone.dao.impl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.capstone.dao.DeleteProductDoa;
import com.capstone.model.DeleteProduct;

@Repository
public class ProductDeletionDoaImpl implements DeleteProductDoa {

	@Autowired
	SessionFactory sessionFactory;
	@Override
	public void saveDeleteProduct(DeleteProduct dP) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().save(dP);
		
	}

	@Override
	public List<DeleteProduct> getDeletedProductsbySeller(long sellerId) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createQuery("from DeleteProduct where sellerId=:sellerId").setParameter("sellerId",sellerId ).getResultList();
	
	}

}
