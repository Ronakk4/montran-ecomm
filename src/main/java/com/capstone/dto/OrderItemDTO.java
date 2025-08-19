package com.capstone.dto;

import java.time.LocalDateTime;

public class OrderItemDTO {
    private Long productId;
    private Long sellerId;
    private int quantity;
    private double price;
    private LocalDateTime orderDate;
    
    	
	public Long getProductId() {
		return productId;
	}
	public void setProductId(Long productId) {
		this.productId = productId;
	}
	public Long getSellerId() {
		return sellerId;
	}
	public void setSellerId(Long sellerId) {
		this.sellerId = sellerId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public LocalDateTime getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(LocalDateTime orderDate) {
		this.orderDate = orderDate;
	}

    // getters and setters
    
    
}

