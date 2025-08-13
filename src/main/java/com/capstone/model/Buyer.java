package com.capstone.model;

import java.time.LocalDateTime;

import javax.persistence.Entity;

@Entity
public class Buyer extends User{
	private String shippingAddress;
	private String phoneNumber;
	// orders
	public Buyer(String name, String email, String password, String role, LocalDateTime createdAt,
			LocalDateTime updatedAt, String shippingAddress, String phoneNumber) {
		super(name, email, password, role, createdAt, updatedAt);
		this.shippingAddress = shippingAddress;
		this.phoneNumber = phoneNumber;
	}
	
	
}
