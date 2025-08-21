package com.capstone.service;

import java.util.List;

import com.capstone.model.DeleteProduct;

public interface DeleteProductService {
	
	List<DeleteProduct> getDeleteProducts(long sellerId);
	void saveDeleteProduct(long id);

}
