package com.capstone.model;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name="app_user")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	private String name;
	
	@Email(message="Email should be valid")
	@NotBlank(message= "Email is required")
	private String email;
	
	
	@NotBlank(message="Password is required")
	@Size(min=8,message= "Password must be atleast 8 characters")
	@Pattern(
			regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]+$",
	        message = "Password must contain uppercase, lowercase, number, and special character"
	    )
	private String password;
	
	private String role;
//	LocalDateTime createdAt;
//	LocalDateTime updatedAt;
	
	public User() {}
	
//	
//	public User(String name, String email, String password, String role, LocalDateTime createdAt,
//			LocalDateTime updatedAt) {
//		super();
//		
//		this.name = name;
//		this.email = email;
//		this.password = password;
//		this.role = role;
////		this.createdAt = createdAt;
////		this.updatedAt = updatedAt;
//	}


	public long getId() {
		return id;
	}


	public void setId(long id) {
		this.id = id;
	}


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


//	public LocalDateTime getCreatedAt() {
//		return createdAt;
//	}
//
//
//	public void setCreatedAt(LocalDateTime createdAt) {
//		this.createdAt = createdAt;
//	}
//
//
//	public LocalDateTime getUpdatedAt() {
//		return updatedAt;
//	}
//
//
//	public void setUpdatedAt(LocalDateTime updatedAt) {
//		this.updatedAt = updatedAt;
//	}
	
	
}
