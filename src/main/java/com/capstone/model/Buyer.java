package com.capstone.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Buyer extends User{
	private String shippingAddress;
	private String phoneNumber;
	
	@OneToMany(mappedBy = "buyer", cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonIgnore
	private List<OrderHeader> orders = new ArrayList<OrderHeader>();
	
	public Buyer() {}
	
	public Buyer(String name, String email, String password, String role, LocalDateTime createdAt,
			LocalDateTime updatedAt, String shippingAddress, String phoneNumber) {
		super(name, email, password, role, createdAt, updatedAt);
		this.shippingAddress = shippingAddress;
		this.phoneNumber = phoneNumber;
	}

	public String getShippingAddress() {
		return shippingAddress;
	}

	public void setShippingAddress(String shippingAddress) {
		this.shippingAddress = shippingAddress;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public List<OrderHeader> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderHeader> orders) {
		this.orders = orders;
	}
	
	
}
