package com.capstone.dto;

import java.time.LocalDateTime;
import java.util.List;

public class ProductInsertDTO {
    private long prodId;
    private String prodName;
    private String prodDescription;
    private Double price;
    private int stockQuantity;
    private String category;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
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
