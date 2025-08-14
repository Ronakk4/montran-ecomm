package com.capstone.model;

import java.time.LocalDateTime;
import javax.validation.constraints.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@Table(name="products")
public class Product {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "prod_id")
	private long prodId;
	
	@Column(name = "name")
	@NotBlank(message = "Product name is required")
	@Size(min=3,max=150,message= "Product name must be between 3 and 150 characters")
	private String prodName;
	
	@Column(name = "description")
	@Size(max=1000,message="Description must not exceed 1000 characters")
	private String prodDescription;
	
	@Column
	@Positive(message="Price must be a positive number")
	private Double price;
	
	@Column(name="stock_quantity")
	private int stockQuantity;
	
	@Column
	private String category;
	
	@Column(name = "created_at")
	private LocalDateTime createdAt = LocalDateTime.now();
	
	@Column(name = "updated_at")
	private LocalDateTime updatedAt;

	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "seller_id")
	@JsonBackReference
	private Seller seller;
	
	public Product(){
		
	}
	
	public Product(String prodName, String prodDescription, Double price, int stockQuantity,
			String category, LocalDateTime createdAt, LocalDateTime updatedAt) {
		super();
		this.prodName = prodName;
		this.prodDescription = prodDescription;
		this.price = price;
		this.stockQuantity = stockQuantity;
		this.category = category;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
		
	}



	public long getId() {
		return prodId;
	}

	public void setId(long id) {
		this.prodId = id;
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
	
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	
	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}
	
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	public Seller getSeller() {
		return seller;
	}

	public void setSeller(Seller seller) {
		this.seller = seller;
	}

	@Override
	public String toString() {
		return "Product [id=" + prodId + ", prodName=" + prodName + ", prodDescription=" + prodDescription + ", price="
				+ price + ", stockQuantity=" + stockQuantity + ", category=" + category + ", createdAt=" + createdAt
				+ ", updatedAt=" + updatedAt + ", seller=" + seller + "]";
	}
	
	
}
