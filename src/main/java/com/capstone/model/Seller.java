package com.capstone.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonManagedReference;


@Entity
public class Seller extends User{
	
	private String shopName;
	private String shopDescription;
	private String gstNumber;
	
	@OneToMany(mappedBy = "seller", cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonManagedReference
	private List<Product> products = new ArrayList<Product>();
	
	public Seller() {
		
	}
	
	public Seller( String name, String email, String password, String role, LocalDateTime createdAt,
			LocalDateTime updatedAt, String shopName, String shopDescription, String gstNumber) {
		super(name, email, password, role, createdAt, updatedAt);
		this.shopName = shopName;
		this.shopDescription = shopDescription;
		this.gstNumber = gstNumber;
	}


	public String getShopName() {
		return shopName;
	}


	public void setShopName(String shopName) {
		this.shopName = shopName;
	}


	public String getShopDescription() {
		return shopDescription;
	}


	public void setShopDescription(String shopDescription) {
		this.shopDescription = shopDescription;
	}


	public String getGstNumber() {
		return gstNumber;
	}


	public void setGstNumber(String gstNumber) {
		this.gstNumber = gstNumber;
	}
	
	

	public List<Product> getProducts() {
		return products;
	}


	public void setProducts(List<Product> products) {
		this.products = products;
	}


	@Override
	public String toString() {
		return "Seller [shopName=" + shopName + ", shopDescription=" + shopDescription + ", gstNumber=" + gstNumber
				+ ", products=" + products + "]";
	}
	
	
}
