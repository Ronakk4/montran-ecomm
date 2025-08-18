//package com.capstone.service.impl;
//
//import java.time.LocalDateTime;
//import java.util.List;
//
//import javax.transaction.Transactional;
//import javax.validation.Valid;
//
//import org.hibernate.SessionFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.capstone.dao.ProductDao;
//import com.capstone.dto.ProductInsertDTO;
//import com.capstone.model.Product;
//import com.capstone.model.Seller;
//import com.capstone.service.ProductService;
//
//@Service
//public class ProductServiceImpl implements ProductService{
//	
//	@Autowired
//	private ProductDao productDao;
//	
//	@Autowired
//	private SessionFactory sessionFactory;
//
//	
//
//	@Override
//	@Transactional
//	public Product getProduct(long id) {
//		
//		// TODO Auto-generated method stub
//		return productDao.getProduct(id);
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
//	@Override
//	public void saveProduct(@Valid Product product) {
//		// TODO Auto-generated method stub
//		
//	}
//
//	@Override
//	public List<Product> getProductsBySellerId(long sellerId) {
//		return productDao.getProductsBySellerId(sellerId);
//		
//	}
//
//
//
//
//}


package com.capstone.service.impl;

import java.time.LocalDateTime;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.capstone.dao.ProductDao;
import com.capstone.dao.UserDao;
import com.capstone.dto.ProductInsertDTO;
import com.capstone.model.Product;
import com.capstone.model.Seller;
import com.capstone.service.ProductService;

@Service
@Transactional
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;
    
    @Autowired
    private UserDao userDao;

    @Override
    public Product getProduct(long id) {
        return productDao.getProduct(id);
    }

    @Override
    public void deleteProduct(long id) {
        productDao.deleteProduct(id);
    }

    @Override
    public List<Product> getProductsFromCategory(String category) {
        return productDao.getProductsFromCategory(category);
    }

    @Override
    public void saveProduct(@Valid Product product) {
        if (product.getId() == 0) {
            // New product
            product.setCreatedAt(LocalDateTime.now());
        }
        product.setUpdatedAt(LocalDateTime.now());
        productDao.saveProduct(product);
    }

    @Override
    public List<Product> getProductsBySellerId(long sellerId) {
        return productDao.getProductsBySellerId(sellerId);
    }

    @Override
    public void saveProduct(ProductInsertDTO productDTO) {
        try {
            // Find the seller
            Seller seller = (Seller) userDao.findUserById(productDTO.getSellerId());
            if (seller == null) {
                throw new RuntimeException("Seller not found with id: " + productDTO.getSellerId());
            }

            // Create new product
            Product product = new Product();
            product.setProdName(productDTO.getProdName());
            product.setProdDescription(productDTO.getProdDescription());
            product.setPrice(productDTO.getPrice());
            product.setStockQuantity(productDTO.getStockQuantity());
            product.setCategory(productDTO.getCategory());
            product.setSeller(seller);
            product.setCreatedAt(LocalDateTime.now());
            product.setUpdatedAt(LocalDateTime.now());

            productDao.saveProduct(product);
            
        } catch (Exception e) {
            throw new RuntimeException("Failed to save product: " + e.getMessage());
        }
    }
}