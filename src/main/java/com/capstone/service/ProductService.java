

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
	List<Product> getProductsBySellerId(long sellerId);
	List<String> getAllCategories();
}




