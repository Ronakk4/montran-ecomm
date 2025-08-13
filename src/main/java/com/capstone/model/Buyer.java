package com.capstone.model;

import javax.persistence.Entity;

@Entity
public class Buyer extends User{
	private String shippingAddress;
	private String phoneNumber;
	// orders
}
