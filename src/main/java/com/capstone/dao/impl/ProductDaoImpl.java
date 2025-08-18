package com.capstone.dao.impl;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.capstone.model.Product;
import com.capstone.model.Seller;
import com.capstone.dao.ProductDao;
import com.capstone.dto.ProductInsertDTO;


@Repository
@Transactional
public class ProductDaoImpl implements ProductDao {

	@Autowired
	private SessionFactory sessionFactory;

//	@Override
//	public List<Product> getAllProducts() {
//		// TODO Auto-generated method stub
//		return sessionFactory.getCurrentSession().createQuery("from Product", Product.class).list();
//	}

	@Override
	public Product getProduct(long id) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().get(Product.class, id);
	}

	@Override
	public void saveProduct(Product product) {
//		product.setCreatedAt(LocalDateTime.now());
//	    product.setUpdatedAt(LocalDateTime.now());

	    sessionFactory.getCurrentSession().save(product);
	}


	@Override
	public void deleteProduct(long id) {
	    sessionFactory.getCurrentSession()
	        .createQuery("DELETE FROM Product p WHERE p.id = :id")
	        .setParameter("id", id)
	        .executeUpdate();
	}

	@Override
	public void updateProduct(ProductInsertDTO p) {
		Product existingProduct = sessionFactory.getCurrentSession().get(Product.class, p.getProdId());
		if(existingProduct != null) {
			existingProduct.setProdName(p.getProdName());
			existingProduct.setProdDescription(p.getProdDescription());
			existingProduct.setPrice(p.getPrice());
			existingProduct.setStockQuantity(p.getStockQuantity());
			existingProduct.setCategory(p.getCategory());
			existingProduct.setUpdatedAt(LocalDateTime.now());
			
			sessionFactory.getCurrentSession().update(existingProduct);
		} else {
			throw new RuntimeException("Product with ID " + p.getProdId() + " not found");
		}
		
	}	

	@Override
	public List<Product> getProductsBySellerId(long sellerId) {
		return sessionFactory.getCurrentSession().createQuery("from Product p where p.seller.id = :sellerId", Product.class)
				.setParameter("sellerId", sellerId)
				.list();
		
	}
	
	public Seller getSellerById(Long id) {
	    return sessionFactory.getCurrentSession().get(Seller.class, id);
	}


	@Override
	public List<String> getAllCategories() {
		return sessionFactory.getCurrentSession().createQuery("select distinct p.category from Product p", String.class)
				.list();
		
	}

	@Override
	public List<Product> getProductsFromCategory(String category) {
		return sessionFactory.getCurrentSession().createQuery("from Product where category = :category", Product.class)
		.setParameter("category", category)
		.list();
		
	}
	

}
