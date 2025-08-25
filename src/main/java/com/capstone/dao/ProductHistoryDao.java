package com.capstone.dao;

import java.util.List;


import com.capstone.model.ProductHistory;

public interface ProductHistoryDao {
	List<ProductHistory> getProductHistory();
	String addProductHistory(ProductHistory p);
}
