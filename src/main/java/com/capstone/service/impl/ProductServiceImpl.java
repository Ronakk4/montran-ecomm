package com.capstone.service.impl;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.ProductDao;
import com.capstone.dto.ProductInsertDTO;
import com.capstone.model.Product;
import com.capstone.model.Seller;
import com.capstone.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private SessionFactory sessionFactory;

	

	@Override
	@Transactional
	public Product getProduct(long id) {
		
		// TODO Auto-generated method stub
		return productDao.getProduct(id);
	}

	@Override
	@Transactional
	public void saveProduct(ProductInsertDTO p) {
		// TODO Auto-generated method stub
		 Product product = new Product();
		    product.setProdName(p.getProdName());
		    product.setProdDescription(p.getProdDescription());
		    product.setPrice(p.getPrice());
		    product.setStockQuantity(p.getStockQuantity());
		    product.setCategory(p.getCategory());
		    product.setCreatedAt(p.getCreatedAt() != null ? p.getCreatedAt() : LocalDateTime.now());
		    product.setUpdatedAt(p.getUpdatedAt());

		    // Fetch seller using DAO or session in same transaction
		    Seller seller = productDao.getSellerById(p.getSellerId());
		    if (seller == null) {
		    	System.out.println("seller not found");
		        throw new RuntimeException("Seller not found for ID: " + p.getSellerId());
		    }
		    product.setSeller(seller);

		    productDao.saveProduct(product);
	}

	@Override
	@Transactional
	public void deleteProduct(long id) {
		// TODO Auto-generated method stub
		productDao.deleteProduct(id);
		
	}

	@Override
	public List<Product> getProductsFromCategory(String category) {
		
		return productDao.getProductsFromCategory(category);
	}

//	@Override
//	public void saveProduct(@Valid Product product) {
//		// TODO Auto-generated method stub
//		
//	}

	@Override
	public List<Product> getProductsBySellerId(long sellerId) {
		return productDao.getProductsBySellerId(sellerId);
		
	}




}
