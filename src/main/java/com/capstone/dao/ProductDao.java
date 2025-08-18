package com.capstone.dao;

import java.util.List;

import com.capstone.dto.ProductDTO;
import com.capstone.dto.ProductInsertDTO;
import com.capstone.model.Product;


public interface ProductDao {
//	List<Product> getAllProducts();
	Product getProduct(long id);
	void saveProduct(Product p);
	void deleteProduct(long id);
	void updateProduct(ProductInsertDTO p);
	List<Product> getProductsFromCategory(String category);
	List<Product> getProductsBySellerId(long sellerId);
	List<String> getAllCategories();
	
	
}

