package com.capstone.service;

import java.util.List;

import javax.validation.Valid;

import com.capstone.dto.ProductInsertDTO;
import com.capstone.model.Product;

public interface ProductService {
//	List<Product> getAllProducts();
	void saveProduct(ProductInsertDTO p);
	Product getProduct(long id);
	void deleteProduct(long id);
	void updateProduct(ProductInsertDTO p);
	List<Product> getProductsFromCategory(String category);

//	void saveProduct(@Valid Product product);

	List<Product> getProductsBySellerId(long sellerId);
	List<String> getAllCategories();
	List<Product> searchProducts(String prodName, String category, Double minPrice, Double maxPrice);
	List<Product> getProductsByPage(int page, int size, String categoryId, String sort);
	long getProductCount(String categoryId);
}