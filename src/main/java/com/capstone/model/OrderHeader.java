package com.capstone.model;

import java.util.List;

import javax.persistence.CascadeType;
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

    @OneToMany(mappedBy = "orderHeader", cascade = CascadeType.ALL)
    private List<OrderItem> items;

	public OrderHeader(String status, double totalAmount, Buyer buyer, List<OrderItem> items) {
		super();
		this.status = status;
		this.totalAmount = totalAmount;
		this.buyer = buyer;
		this.items = items;
	}
    
    
}

