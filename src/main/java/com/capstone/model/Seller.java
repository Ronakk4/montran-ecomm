package com.capstone.model;

import java.time.LocalDateTime;

import javax.persistence.Entity;

@Entity
public class Seller extends User{
	
	private String shopName;
	private String shopDescription;
	private String gstNumber;
	// products
	
	
	public Seller( String name, String email, String password, String role, LocalDateTime createdAt,
			LocalDateTime updatedAt, String shopName, String shopDescription, String gstNumber) {
		super(name, email, password, role, createdAt, updatedAt);
		this.shopName = shopName;
		this.shopDescription = shopDescription;
		this.gstNumber = gstNumber;
	}
}
