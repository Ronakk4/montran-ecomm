package com.capstone.model;

public class CartItem {
    private long productId;
    private String productName;
    private double price;
    private int quantity;
    private long sellerId;

    // Proper constructor to map Product → CartItem
    public CartItem(Product p, int qty) {
        this.productId = p.getProdId();
        this.productName = p.getProdName();
        this.price = p.getPrice();
        this.quantity = qty;
        this.sellerId = p.getSeller().getId();
    }

    public CartItem(long productId, String productName, double price, int quantity, long sellerId) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
        this.sellerId = sellerId;
    }

    public long getProductId() { return productId; }
    public void setProductId(long productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public long getSellerId() { return sellerId; }
    public void setSellerId(long sellerId) { this.sellerId = sellerId; }

    public double getLineTotal() { return price * quantity; }
}
