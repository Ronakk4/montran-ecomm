package com.capstone.model;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "order_header")
public class OrderHeader {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orderId;

//    private LocalDateTime orderDate;
    private String status;
    private double totalAmount;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "buyer_id")
    private Buyer buyer;

    @OneToMany(mappedBy = "orderHeader", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderItem> items;
    
    @Column(name = "order_date")
    private LocalDateTime orderDate;

	public OrderHeader(String status, double totalAmount, Buyer buyer, List<OrderItem> items) {
		super();
		this.status = status;
		this.totalAmount = totalAmount;
		this.buyer = buyer;
		this.items = items;
	}
	public OrderHeader(){
		
	}
	public Long getOrderId() {
		return orderId;
	}
	public void setOrderId(Long orderId) {
		this.orderId = orderId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	public Buyer getBuyer() {
		return buyer;
	}
	public void setBuyer(Buyer buyer) {
		this.buyer = buyer;
	}
	public List<OrderItem> getItems() {
		return items;
	}
	public void setItems(List<OrderItem> items) {
		this.items = items;
	}
	public LocalDateTime getOrderDate() {
		return orderDate;
	}
	public void setOrderDate(LocalDateTime orderDate) {
		this.orderDate = orderDate;
	}
    
    
}

