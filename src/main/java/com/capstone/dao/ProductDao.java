package com.capstone.dao;

import java.util.List;

import com.capstone.dto.ProductDTO;
import com.capstone.dto.ProductInsertDTO;

import com.capstone.model.Product;
import com.capstone.model.ProductHistory;
import com.capstone.model.Seller;

public interface ProductDao {

//	List<Product> getAllProducts();
	Product getProduct(long id);
	void saveProduct(Product p);
	void deleteProduct(long id);
	List<Product> getProductsFromCategory(String category);
	List<Product> getProductsBySellerId(long sellerId);

	public Seller getSellerById(Long id);

	List<String> getAllCategories();
	List<Product> searchProducts(String prodName, String category, Double minPrice, Double maxPrice);
	boolean existsByProdNameAndSellerId(String prodName, long sellerId);
	void updateProduct(Product product);
	List<Product> getProductsByPage(int page, int size, String categoryId, String sort);
	long getProductCount(String categoryId);
	
	void saveProductToHistory(ProductHistory ph);
	List<ProductHistory> getDeletedProducts();
}
