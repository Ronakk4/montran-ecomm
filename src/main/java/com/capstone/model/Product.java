package com.capstone.model;

import java.time.LocalDateTime;

public class Product {
	private String prodId;
	private String prodName;
	private String prodDescription;
	private Double price;
	private int stockQuantity;
	private String Category;
	private LocalDateTime createdAt = LocalDateTime.now();
	private LocalDateTime updatedAt;
	
	
	
}
