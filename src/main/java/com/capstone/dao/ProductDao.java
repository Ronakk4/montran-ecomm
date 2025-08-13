package com.capstone.dao;

import java.util.List;

import com.capstone.model.Product;


public interface ProductDao {
	List<Product> getAllProducts();
	Product getProduct(long id);
	void saveProduct(Product p);
	void deleteProduct(long id);
}