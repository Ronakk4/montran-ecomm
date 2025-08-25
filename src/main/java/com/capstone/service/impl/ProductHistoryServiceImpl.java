package com.capstone.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.ProductHistoryDao;
import com.capstone.dto.ProductInsertDTO;
import com.capstone.model.ProductHistory;
import com.capstone.service.ProductHistoryService;

@Service
public class ProductHistoryServiceImpl implements ProductHistoryService{

	@Autowired
	private ProductHistoryDao productHistoryDao;

	@Override
	public List<ProductHistory> getProductHistory() {
		return productHistoryDao.getProductHistory();
	}

	@Override
	public String addProductHistory(ProductInsertDTO p) {
		ProductHistory productHistory = new ProductHistory(p.getProdName(), p.getProdDescription(), p.getPrice(),
				p.getStockQuantity(), p.getCategory(), p.getCreatedAt(), p.getUpdatedAt());
		
		productHistory.setImages(p.getImages());
		
		return productHistoryDao.addProductHistory(productHistory);
	}

}
