//package com.capstone.model;
//
//import java.time.LocalDateTime;
//import javax.validation.constraints.*;
//
//import javax.persistence.Column;
//import javax.persistence.Entity;
//import javax.persistence.FetchType;
//import javax.persistence.GeneratedValue;
//import javax.persistence.GenerationType;
//import javax.persistence.Id;
//import javax.persistence.JoinColumn;
//import javax.persistence.ManyToOne;
//import javax.persistence.Table;
//
//import com.fasterxml.jackson.annotation.JsonBackReference;
//
//@Entity
//@Table(name="products")
//public class Product {
//	@Id
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	@Column(name = "prod_id")
//	private long prodId;
//	
//	@Column(name = "name")
//	@NotBlank(message = "Product name is required")
//	@Size(min=3,max=150,message= "Product name must be between 3 and 150 characters")
//	private String prodName;
//	
//	@Column(name = "description")
//	@Size(max=1000,message="Description must not exceed 1000 characters")
//	private String prodDescription;
//	
//	@Column
//	@Positive(message="Price must be a positive number")
//	private Double price;
//	
//	@Column(name="stock_quantity")
//	@Min(value=0,message="Product not available in stock")
//	private int stockQuantity;
//	
//	@Column
//	private String category;
//	
//	@Column(name = "created_at")
//	private LocalDateTime createdAt = LocalDateTime.now();
//	
//	@Column(name = "updated_at")
//	private LocalDateTime updatedAt;
//
//	
//	@ManyToOne(fetch = FetchType.LAZY)
//	@JoinColumn(name = "seller_id")
//	@JsonBackReference
//	private Seller seller;
//	
//	public Product(){
//		
//	}
//	
//	public Product(String prodName, String prodDescription, Double price, int stockQuantity,
//			String category, LocalDateTime createdAt, LocalDateTime updatedAt) {
//		super();
//		this.prodName = prodName;
//		this.prodDescription = prodDescription;
//		this.price = price;
//		this.stockQuantity = stockQuantity;
//		this.category = category;
//		this.createdAt = createdAt;
//		this.updatedAt = updatedAt;
//		
//	}
//
//
//
//	public long getId() {
//		return prodId;
//	}
//
//	public void setId(long id) {
//		this.prodId = id;
//	}
//	
//	public String getProdName() {
//		return prodName;
//	}
//	
//	public void setProdName(String prodName) {
//		this.prodName = prodName;
//	}
//	
//	public String getProdDescription() {
//		return prodDescription;
//	}
//	
//	public void setProdDescription(String prodDescription) {
//		this.prodDescription = prodDescription;
//	}
//	
//	public Double getPrice() {
//		return price;
//	}
//	
//	public void setPrice(Double price) {
//		this.price = price;
//	}
//	
//	public int getStockQuantity() {
//		return stockQuantity;
//	}
//	
//	public void setStockQuantity(int stockQuantity) {
//		this.stockQuantity = stockQuantity;
//	}
//	
//	public String getCategory() {
//		return category;
//	}
//	
//	public void setCategory(String category) {
//		this.category = category;
//	}
//	
//	public LocalDateTime getCreatedAt() {
//		return createdAt;
//	}
//	
//	public void setCreatedAt(LocalDateTime createdAt) {
//		this.createdAt = createdAt;
//	}
//	
//	public LocalDateTime getUpdatedAt() {
//		return updatedAt;
//	}
//	
//	public void setUpdatedAt(LocalDateTime updatedAt) {
//		this.updatedAt = updatedAt;
//	}
//	
//	public Seller getSeller() {
//		return seller;
//	}
//
//	public void setSeller(Seller seller) {
//		this.seller = seller;
//	}
//
//	@Override
//	public String toString() {
//		return "Product [id=" + prodId + ", prodName=" + prodName + ", prodDescription=" + prodDescription + ", price="
//				+ price + ", stockQuantity=" + stockQuantity + ", category=" + category + ", createdAt=" + createdAt
//				+ ", updatedAt=" + updatedAt + ", seller=" + seller + "]";
//	}
//	
//	
//}


package com.capstone.model;

import javax.persistence.*;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonBackReference;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "product")
public class Product {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long prodId;

    @NotBlank(message = "Product name is required")
    @Size(max = 100, message = "Product name must be at most 100 characters")
    @Column(name = "prod_name", nullable = false, length = 100)
    private String prodName;

    @Size(max = 500, message = "Description must be at most 500 characters")
    @Column(name = "description", length = 500)
    private String description;

    @NotNull(message = "Price is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Price must be greater than 0")
    @Column(name = "price", nullable = false, precision = 10, scale = 2)
    private BigDecimal price;

    @NotNull(message = "Stock quantity is required")
    @Column(name = "stock_qty", nullable = false)
    private Integer stockQty;

    @Size(max = 50, message = "Category must be at most 50 characters")
    @Column(name = "category", length = 50)
    private String category;

    @Size(max = 255, message = "Image URL must be at most 255 characters")
    @Column(name = "image_url", length = 255)
    private String imageUrl;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "seller_id", nullable = false)
    @JsonBackReference
    private Seller seller;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @PrePersist
    public void onCreate() {
        LocalDateTime now = LocalDateTime.now();
        this.createdAt = (this.createdAt == null) ? now : this.createdAt;
        this.updatedAt = (this.updatedAt == null) ? now : this.updatedAt;
    }

    @PreUpdate
    public void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    // Constructors
    public Product() {}

    public Product(String prodName, String description, BigDecimal price, Integer stockQty, 
                   String category, String imageUrl, Seller seller) {
        this.prodName = prodName;
        this.description = description;
        this.price = price;
        this.stockQty = stockQty;
        this.category = category;
        this.imageUrl = imageUrl;
        this.seller = seller;
    }

    // Getters and Setters
    public Long getProdId() { return prodId; }
    public void setProdId(Long prodId) { this.prodId = prodId; }

    public String getProdName() { return prodName; }
    public void setProdName(String prodName) { this.prodName = prodName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    public Integer getStockQty() { return stockQty; }
    public void setStockQty(Integer stockQty) { this.stockQty = stockQty; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public Seller getSeller() { return seller; }
    public void setSeller(Seller seller) { this.seller = seller; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}