

package com.capstone.service;

import java.util.List;

import com.capstone.model.Product;

public interface ProductService {
	List<Product> getAllProducts();
	Product getProduct(long id);
	void saveProduct(Product p);
	void deleteProduct(long id);
	List<Product> getProductsFromCategory(String category);
}




