package com.capstone.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.ProductDao;
import com.capstone.model.Product;
import com.capstone.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	private ProductDao productDao;

	@Override
	@Transactional
	public List<Product> getAllProducts() {
		// TODO Auto-generated method stub
		
		return productDao.getAllProducts();
	}

	@Override
	@Transactional
	public Product getProduct(long id) {
		
		// TODO Auto-generated method stub
		return productDao.getProduct(id);
	}

	@Override
	@Transactional
	public void saveProduct(Product p) {
		// TODO Auto-generated method stub
		productDao.saveProduct(p);
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




}
