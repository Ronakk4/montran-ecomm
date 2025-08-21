package com.capstone.service.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.DeleteProductDoa;

import com.capstone.dao.ProductDao;
import com.capstone.model.DeleteProduct;
import com.capstone.model.Product;
import com.capstone.service.DeleteProductService;

@Service
public class DeleteProductServiceImp  implements DeleteProductService{
	
	@Autowired
	ProductDao productDao;
	
	@Autowired
	DeleteProductDoa deleteProductDoa;
	

	@Override
	@Transactional
	public List<DeleteProduct> getDeleteProducts(long sellerId) {
		// TODO Auto-generated method stub
		
		return deleteProductDoa.getDeletedProductsbySeller(sellerId);
	}

	@Override
	@Transactional
	public void saveDeleteProduct(long id) {
		// TODO Auto-generated method stub
		Product p=productDao.getProduct(id);
		DeleteProduct dp=new DeleteProduct(p.getProdId(), p.getProdName(), p.getProdDescription(), p.getSeller().getId());
		deleteProductDoa.saveDeleteProduct(dp);
		
		
	}

	

}
