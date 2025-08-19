package com.capstone.dto;

import com.capstone.model.Product;
import java.util.List;

public class ProductFetchDTO {
    private Long prodId;
    private String prodName;
    private String prodDescription;
    private Double price;
    private Integer stockQuantity;
    private String category;
    private Long sellerId;
    private String sellerName;

    // ✅ new field
    private List<String> images;

    public ProductFetchDTO(Product product) {
        this.prodId = product.getProdId();
        this.prodName = product.getProdName();
        this.prodDescription = product.getProdDescription();
        this.price = product.getPrice();
        this.stockQuantity = product.getStockQuantity();
        this.category = product.getCategory();
        this.sellerId = product.getSeller() != null ? product.getSeller().getId() : null;
        this.images = product.getImages(); // ✅ fetch images
    }

    // getters & setters ...
    public List<String> getImages() { return images; }
    public void setImages(List<String> images) { this.images = images; }
}
