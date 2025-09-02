package com.capstone.dto;

import javax.persistence.Column;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import com.capstone.validation.CreateGroup;
import com.capstone.validation.UpdateGroup;

public class UserRegisterDTO {
	@NotBlank(message = "Name is required",groups= CreateGroup.class)
    private String name;

    @Email(message = "Email should be valid",groups= {CreateGroup.class,UpdateGroup.class})
    @NotBlank(message = "Email is required",groups = CreateGroup.class)
    private String email;

    @Size(min = 8, message = "Password must be at least 8 characters",groups= {CreateGroup.class,UpdateGroup.class})
    @Pattern(
        regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$",
        message = "Password must contain uppercase, lowercase, number, and special character",
        groups= {CreateGroup.class,UpdateGroup.class}
    )
    private String password;

    @NotBlank(message = "Role is required",groups={CreateGroup.class,UpdateGroup.class})
    private String role; // "SELLER" or "BUYER"

    private String shopName;
    private String shopDescription;
    private String gstNumber;

    private String shippingAddress;

    @NotBlank(message = "Phone number is required",groups= CreateGroup.class)
    private String phoneNumber;
    
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
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


    
    
    
}
