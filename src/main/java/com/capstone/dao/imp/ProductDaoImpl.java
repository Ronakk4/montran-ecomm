package com.capstone.dao.imp;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.capstone.model.Product;
import com.capstone.dao.ProductDao;

@Repository
@Transactional
public class ProductDaoImpl implements ProductDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<Product> getAllProducts() {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createQuery("from Product", Product.class).list();
	}

	@Override
	public Product getProduct(long id) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().get(Product.class, id);
	}

	@Override
	public void saveProduct(Product p) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().save(p);
	}

	@Override
	public void deleteProduct(long id) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().delete(id);
	}

}
