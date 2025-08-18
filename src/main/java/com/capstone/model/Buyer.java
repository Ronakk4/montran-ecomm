//package com.capstone.model;
//
//import java.time.LocalDateTime;
//import java.util.ArrayList;
//import java.util.List;
//
//import javax.persistence.CascadeType;
//import javax.persistence.Entity;
//import javax.persistence.OneToMany;
//
//import com.fasterxml.jackson.annotation.JsonIgnore;
//
//@Entity
//public class Buyer extends User{
//	private String shippingAddress;
//	private String phoneNumber;
//
//	@OneToMany(mappedBy = "buyer", cascade = CascadeType.ALL, orphanRemoval = true)
//	@JsonIgnore
//	private List<OrderHeader> orders = new ArrayList<OrderHeader>();
//	
//	public Buyer() {}
//	
//	public Buyer(String name, String email, String password, String role, LocalDateTime createdAt,
//			LocalDateTime updatedAt, String shippingAddress, String phoneNumber) {
//		super(name, email, password, role, createdAt, updatedAt);
//		this.shippingAddress = shippingAddress;
//		this.phoneNumber = phoneNumber;
//	}
//
//	public String getShippingAddress() {
//		return shippingAddress;
//	}
//
//	public void setShippingAddress(String shippingAddress) {
//		this.shippingAddress = shippingAddress;
//	}
//
//	public String getPhoneNumber() {
//		return phoneNumber;
//	}
//
//	public void setPhoneNumber(String phoneNumber) {
//		this.phoneNumber = phoneNumber;
//	}
//
//	public List<OrderHeader> getOrders() {
//		return orders;
//	}
//
//	public void setOrders(List<OrderHeader> orders) {
//		this.orders = orders;
//	}
//	
//	
//	
//}


package com.capstone.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "buyer")
public class Buyer extends User {

	@NotBlank(message = "Shipping address is required")
	@Size(max = 255, message = "Shipping address must be at most 255 characters")
	@Column(name = "shipping_address", nullable = false, length = 255)
	private String shippingAddress;

// Accepts digits, spaces, +, -, parentheses; at least 10 digits overall is a common rule,
// but here we just validate pattern format to avoid over-strictness.
	@NotBlank(message = "Phone number is required")
	@Size(max = 25, message = "Phone number must be at most 25 characters")
	@Pattern(regexp = "^[0-9+()\\-\\s]{7,25}$", message = "Phone can include digits, spaces, +, -, ()")
	@Column(name = "phone_number", nullable = false, length = 25)
	private String phoneNumber;

	@OneToMany(mappedBy = "buyer", cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonIgnore
	private List<OrderHeader> orders = new ArrayList<>();

	public Buyer() {
	}

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