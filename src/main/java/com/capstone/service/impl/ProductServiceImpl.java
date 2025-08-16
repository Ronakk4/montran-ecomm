package com.capstone.service.impl;

import java.time.LocalDateTime;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.ProductDao;
import com.capstone.dto.ProductInsertDTO;
import com.capstone.exception.ProductNotFoundException;
import com.capstone.model.Product;
import com.capstone.model.Seller;
import com.capstone.service.ProductService;

//@Service
//public class ProductServiceImpl implements ProductService{
//	
//	@Autowired
//	private ProductDao productDao;
//	
//	@Autowired
//	private SessionFactory sessionFactory;
//
//	@Override
//	@Transactional
//	public List<Product> getAllProducts() {
//		// TODO Auto-generated method stub
//		
//		return productDao.getAllProducts();
//	}
//
//	@Override
//	@Transactional
//	public Product getProduct(long id) throws ProductNotFoundException{
//		
//		Product product = productDao.getProduct(id);
//        if (product == null) {
//            throw new ProductNotFoundException("Product with ID " + id + " not found.");
//        }
//        return product;
//	}
//
//	@Override
//	@Transactional
//	public void saveProduct(ProductInsertDTO p) {
//		// TODO Auto-generated method stub
//		 Product product = new Product();
//		    product.setProdName(p.getProdName());
//		    product.setProdDescription(p.getProdDescription());
//		    product.setPrice(p.getPrice());
//		    product.setStockQuantity(p.getStockQuantity());
//		    product.setCategory(p.getCategory());
//		    product.setCreatedAt(p.getCreatedAt() != null ? p.getCreatedAt() : LocalDateTime.now());
//		    product.setUpdatedAt(p.getUpdatedAt());
//
//		    // Fetch Seller entity and set
//		    Seller seller = sessionFactory.getCurrentSession().get(Seller.class, p.getSellerId());
//		    product.setSeller(seller);
//
//		    productDao.saveProduct(product);
//	}
//
//	@Override
//	@Transactional
//	public void deleteProduct(long id) {
//		// TODO Auto-generated method stub
//		productDao.deleteProduct(id);
//		
//	}
//
//	@Override
//	public List<Product> getProductsFromCategory(String category) {
//		
//		return productDao.getProductsFromCategory(category);
//	}
//
//
//
//
//}

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public List<Product> getAllProducts() {
        return productDao.getAllProducts();
    }

    @Override
    @Transactional
    public Product getProduct(long id) throws ProductNotFoundException {
        Product product = productDao.getProduct(id);
        if (product == null) {
            throw new ProductNotFoundException("Product with ID " + id + " not found.");
        }
        return product;
    }

    @Override
    @Transactional
    public void saveProduct(ProductInsertDTO p) {
        Product product = new Product();
        product.setProdName(p.getProdName());
        product.setProdDescription(p.getProdDescription());
        product.setPrice(p.getPrice());
        product.setStockQuantity(p.getStockQuantity());
        product.setCategory(p.getCategory());
        product.setCreatedAt(p.getCreatedAt() != null ? p.getCreatedAt() : LocalDateTime.now());
        product.setUpdatedAt(p.getUpdatedAt());

        // Fetch Seller entity and set
        Seller seller = sessionFactory.getCurrentSession().get(Seller.class, p.getSellerId());
        product.setSeller(seller);

        productDao.saveProduct(product);
    }

    @Override
    @Transactional
    public void deleteProduct(long id) {
        productDao.deleteProduct(id);
    }

    @Override
    public List<Product> getProductsFromCategory(String category) {
        return productDao.getProductsFromCategory(category);
    }
    
    
    @Override
    public List<Product> searchProducts(String prodName, String category, Double minPrice, Double maxPrice) {
        return productDao.searchProducts(prodName, category, minPrice, maxPrice);
    }
}
