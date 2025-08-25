package com.capstone.dto;

public class ProductHistoryDTO {
	private String prodName;
	private String prodDescription;
	private Double price;
	private int stockQuantity;
	private String category;
	private String productHistory;
	private boolean deleted;
	
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public String getProdDescription() {
		return prodDescription;
	}
	public void setProdDescription(String prodDescription) {
		this.prodDescription = prodDescription;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public int getStockQuantity() {
		return stockQuantity;
	}
	public void setStockQuantity(int stockQuantity) {
		this.stockQuantity = stockQuantity;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getProductHistory() {
		return productHistory;
	}
	public void setproductHistory(String productHistory) {
		this.productHistory = productHistory;
	}
	
	
	
}

