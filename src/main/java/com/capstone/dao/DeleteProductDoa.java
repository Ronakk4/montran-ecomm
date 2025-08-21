package com.capstone.dao;

import java.util.List;

import com.capstone.model.DeleteProduct;

public interface DeleteProductDoa {
	
	void saveDeleteProduct(DeleteProduct dP);
	List<DeleteProduct> getDeletedProductsbySeller(long sellerId);
	

}
