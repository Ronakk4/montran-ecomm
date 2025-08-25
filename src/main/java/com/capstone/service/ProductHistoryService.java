package com.capstone.service;

import java.util.List;

import com.capstone.dto.ProductInsertDTO;
import com.capstone.model.ProductHistory;

public interface ProductHistoryService {
	String addProductHistory(ProductInsertDTO p);
	List<ProductHistory> getProductHistory();
}
