package com.capstone.dto;

import java.time.LocalDateTime;
import java.util.List;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Positive;
import javax.validation.constraints.Size;

import com.capstone.validation.CreateGroup;
import com.capstone.validation.UpdateGroup;

public class ProductInsertDTO {
	
private long prodId;
	
	@NotBlank(message = "Product name is required", groups = {CreateGroup.class, UpdateGroup.class})
    @Size(min = 3, max = 150, message = "Product name must be between 3 and 150 characters", groups = {CreateGroup.class, UpdateGroup.class})
    private String prodName;

    @Size(max = 1000, message = "Description must not exceed 1000 characters", groups = {CreateGroup.class, UpdateGroup.class})
    private String prodDescription;

    @Positive(message = "Price must be a positive number", groups = {CreateGroup.class, UpdateGroup.class})
    private Double price;

    @Min(value = 1, message = "Stock quantity must be at least 1", groups = {CreateGroup.class, UpdateGroup.class})
    private int stockQuantity;

    @NotBlank(message = "Category is required", groups = {CreateGroup.class, UpdateGroup.class})
    private String category;

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @Positive(message = "Seller ID must be valid", groups = {CreateGroup.class, UpdateGroup.class})
    private long sellerId;
    

    // ✅ new field
    private List<String> images;

    public ProductInsertDTO() {}

    public ProductInsertDTO(String prodName, String prodDescription, Double price, int stockQuantity,
                            String category, LocalDateTime createdAt, LocalDateTime updatedAt,
                            Long sellerId, List<String> images) {
        this.prodName = prodName;
        this.prodDescription = prodDescription;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.category = category;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.sellerId = sellerId;
        this.images = images;
    }

    // getters & setters
    public long getProdId() { return prodId; }
    public void setProdId(long prodId) { this.prodId = prodId; }

    public String getProdName() { return prodName; }
    public void setProdName(String prodName) { this.prodName = prodName; }

    public String getProdDescription() { return prodDescription; }
    public void setProdDescription(String prodDescription) { this.prodDescription = prodDescription; }

    public Double getPrice() { return price; }
    public void setPrice(Double price) { this.price = price; }

    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public long getSellerId() { return sellerId; }
    public void setSellerId(long sellerId) { this.sellerId = sellerId; }

    public List<String> getImages() { return images; }
    public void setImages(List<String> images) { this.images = images; }
}
