package com.capstone.dao;

import java.util.List;

import com.capstone.dto.ProductInsertDTO;
import com.capstone.model.Product;


public interface ProductDao {
	List<Product> getAllProducts();
	Product getProduct(long id);
	void saveProduct(Product p);
	void deleteProduct(long id);
	List<Product> getProductsFromCategory(String category);
}