	
	
	package com.capstone.service;
	
	import java.util.List;
	
	import javax.validation.Valid;
	
	import com.capstone.dto.ProductInsertDTO;
	import com.capstone.model.Product;
	
	public interface ProductService {
		List<Product> getAllProducts();
		Product getProduct(long id);
		 void saveProduct(ProductInsertDTO product);
		void deleteProduct(long id);
		List<Product> getProductsFromCategory(String category);
	}
	
	
	
	
