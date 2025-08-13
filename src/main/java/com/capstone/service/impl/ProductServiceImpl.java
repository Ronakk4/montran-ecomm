//package com.capstone.service.impl;
//
//import java.util.List;
//
//import javax.transaction.Transactional;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.capstone.service.Product;
//import com.capstone.service.ProductService;
//
//@Service
//public class ProductServiceImpl implements ProductService{
//	
//	@Autowired
//	private ProductDao productDao;
//
//	@Override
//	@Transactional
//	public List<Product> getAllProducts() {
//		// TODO Auto-generated method stub
//		
//		return productDao.findAll();
//	}
//
//	@Override
//	@Transactional
//	public Product getProduct(long id) {
//		// TODO Auto-generated method stub
//		return productDao.findById(id);
//	}
//
//	@Override
//	@Transactional
//	public Product saveProduct(Product p) {
//		// TODO Auto-generated method stub
//		return productDao.save(p);
//	}
//
//	@Override
//	@Transactional
//	public void deleteProduct(long id) {
//		// TODO Auto-generated method stub
//		productDao.delete(id);
//		
//	}
//
//}
