package com.capstone.service;

import java.util.List;

public interface ProductService {
	List<Product> getAllProducts();
	Product getProduct(long id);
	Product saveProduct(Product p);
	void deleteProduct(long id);
}