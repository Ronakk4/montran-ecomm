package com.capstone.service.impl;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;
import javax.validation.Valid;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.ProductDao;
import com.capstone.dto.ProductInsertDTO;
import com.capstone.exception.DuplicateProductException;
import com.capstone.exception.ProductNotFoundException;
import com.capstone.model.Product;
import com.capstone.model.Seller;
import com.capstone.service.ProductService;

@Service
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	private ProductDao productDao;
	
	@Override
	@Transactional
	public Product getProduct(long id) {
	    Product product = productDao.getProduct(id);
	    if (product == null) {
	        throw new ProductNotFoundException("Product not found with ID: " + id);
	    }
	    return product;
	}

	@Override
	@Transactional
	public void saveProduct(@Valid ProductInsertDTO p) throws DuplicateProductException {
	    // Check if seller already has product with same name
	    if (productDao.existsByProdNameAndSellerId(p.getProdName(), p.getSellerId())) {
	        throw new DuplicateProductException(
	            "Product '" + p.getProdName() + "' already exists for seller ID " + p.getSellerId()
	        );
	    }

	    Product product = new Product();
	    product.setProdId(p.getProdId());
	    product.setProdName(p.getProdName());
	    product.setProdDescription(p.getProdDescription());
	    product.setPrice(p.getPrice());
	    product.setStockQuantity(p.getStockQuantity());
	    product.setCategory(p.getCategory());
	    product.setCreatedAt(p.getCreatedAt() != null ? p.getCreatedAt() : LocalDateTime.now());
	    product.setUpdatedAt(p.getUpdatedAt());

	    // ✅ set images only on create (never update later)
	    if (p.getImages() != null && !p.getImages().isEmpty()) {
	        product.setImages(p.getImages());
	    }

	    Seller seller = productDao.getSellerById(p.getSellerId());
	    if (seller == null) {
	        throw new RuntimeException("Seller not found for ID: " + p.getSellerId());
	    }
	    product.setSeller(seller);

	    productDao.saveProduct(product);
	}



	@Override
	@Transactional
	public void deleteProduct(long id) {
		// TODO Auto-generated method stub
		Product p = productDao.getProduct(id);
		ProductInsertDTO p2 = new ProductInsertDTO(p.getProdName(),p.getProdDescription(),p.getPrice(),p.getStockQuantity()
				,p.getCategory(),p.getCreatedAt(),p.getUpdatedAt(),p.getSeller().getId(),p.getImages());
		productDao.deleteProduct(id);
		
	}
	
	@Override
	public void updateProduct(ProductInsertDTO p) {
	    Product product = new Product();
	    product.setProdId(p.getProdId());
	    product.setProdName(p.getProdName());
	    product.setProdDescription(p.getProdDescription());
	    product.setPrice(p.getPrice());
	    product.setStockQuantity(p.getStockQuantity());
	    product.setCategory(p.getCategory());
	    product.setUpdatedAt(LocalDateTime.now());

	    // ✅ Only set images if provided
	    if (p.getImages() != null && !p.getImages().isEmpty()) {
	        product.setImages(p.getImages());
	    }

	    productDao.updateProduct(product);
	}




	@Override
	public List<Product> getProductsBySellerId(long sellerId) {
		return productDao.getProductsBySellerId(sellerId);
		
	}
	
	@Override
	public List<Product> getProductsFromCategory(String category) {
		
		return productDao.getProductsFromCategory(category);
	}
	
	public List<String> getAllCategories(){
		
		return productDao.getAllCategories();
	}

	 @Override
	    public List<Product> searchProducts(String prodName, String category, Double minPrice, Double maxPrice) {
	        return productDao.searchProducts(prodName, category, minPrice, maxPrice);
	    }


}