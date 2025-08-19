package com.capstone.dto;

import com.capstone.model.Product;

public class ProductFetchDTO {
    private Long prodId;
    private String prodName;
    private String prodDescription;
    private Double price;
    private Integer stockQuantity;
    private String category;
    private Long sellerId;
    private String sellerName;

    public ProductFetchDTO(Product product) {
        this.prodId = product.getProdId();
        this.prodName = product.getProdName();
        this.prodDescription = product.getProdDescription();
        this.price = product.getPrice();
        this.stockQuantity = product.getStockQuantity();
        this.category = product.getCategory();

        this.sellerId = product.getSeller() != null ? product.getSeller().getId() : null;
    }

	public Long getProdId() {
		return prodId;
	}

	public void setProdId(Long prodId) {
		this.prodId = prodId;
	}

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

	public Integer getStockQuantity() {
		return stockQuantity;
	}

	public void setStockQuantity(Integer stockQuantity) {
		this.stockQuantity = stockQuantity;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Long getSellerId() {
		return sellerId;
	}

	public void setSellerId(Long sellerId) {
		this.sellerId = sellerId;
	}

	public String getSellerName() {
		return sellerName;
	}

	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}
    
    
    

    // Getters & Setters
}
