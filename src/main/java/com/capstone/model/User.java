//package com.capstone.model;
//
//import java.time.LocalDateTime;
//
//import javax.persistence.Entity;
//import javax.persistence.GeneratedValue;
//import javax.persistence.GenerationType;
//import javax.persistence.Id;
//import javax.persistence.Inheritance;
//import javax.persistence.InheritanceType;
//import javax.persistence.Table;
//import javax.validation.constraints.Email;
//import javax.validation.constraints.NotBlank;
//import javax.validation.constraints.Pattern;
//import javax.validation.constraints.Size;
//
//@Entity
//@Inheritance(strategy = InheritanceType.JOINED)
//@Table(name="app_user")
//public class User {
//	@Id
//	@GeneratedValue(strategy = GenerationType.IDENTITY)
//	private long id;
//	
//	private String name;
//	
//	@Email(message="Email should be valid")
//	@NotBlank(message= "Email is required")
//	private String email;
//	
//	
//	@NotBlank(message="Password is required")
//	@Size(min=8,message= "Password must be atleast 8 characters")
//	@Pattern(
//			regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]+$",
//	        message = "Password must contain uppercase, lowercase, number, and special character"
//	    )
//	private String password;
//	
//	private String role;
//	LocalDateTime createdAt;
//	LocalDateTime updatedAt;
//	
//	public User() {}
//	
//	
//	public User(String name, String email, String password, String role, LocalDateTime createdAt,
//			LocalDateTime updatedAt) {
//		super();
//		
//		this.name = name;	
//		this.email = email;
//		this.password = password;
//		this.role = role;
//		this.createdAt = createdAt;
//		this.updatedAt = updatedAt;
//	}
//
//
//	public long getId() {
//		return id;
//	}
//
//
//	public void setId(long id) {
//		this.id = id;
//	}
//
//
//	public String getName() {
//		return name;
//	}
//
//
//	public void setName(String name) {
//		this.name = name;
//	}
//
//
//	public String getEmail() {
//		return email;
//	}
//
//
//	public void setEmail(String email) {
//		this.email = email;
//	}
//
//
//	public String getPassword() {
//		return password;
//	}
//
//
//	public void setPassword(String password) {
//		this.password = password;
//	}
//
//
//	public String getRole() {
//		return role;
//	}
//
//
//	public void setRole(String role) {
//		this.role = role;
//	}
//
//
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
//	
//	
//}



package com.capstone.model;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(
    name = "app_user",
    uniqueConstraints = {
        @UniqueConstraint(name = "uk_app_user_email", columnNames = "email")
    }
)
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @NotBlank(message = "Name is required")
    @Size(max = 100, message = "Name must be at most 100 characters")
    @Column(name = "name", nullable = false, length = 100)
    private String name;

    @Email(message = "Email should be valid")
    @NotBlank(message = "Email is required")
    @Size(max = 180, message = "Email must be at most 180 characters")
    @Column(name = "email", nullable = false, length = 180)
    private String email;

    @NotBlank(message = "Password is required")
    @Size(min = 8, message = "Password must be at least 8 characters")
    @Pattern(
        // at least one lower, one upper, one digit, one special; any special char allowed
        regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[^A-Za-z0-9]).{8,}$",
        message = "Password must include upper, lower, number, and special character"
    )
    @Column(name = "password", nullable = false)
    private String password;

    @NotBlank(message = "Role is required")
    @Size(max = 30, message = "Role must be at most 30 characters")
    @Column(name = "role", nullable = false, length = 30)
    private String role;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    public User() {}

    public User(String name, String email, String password, String role,
                LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    @PrePersist
    public void onCreate() {
        LocalDateTime now = LocalDateTime.now();
        this.createdAt = (this.createdAt == null) ? now : this.createdAt;
        this.updatedAt = (this.updatedAt == null) ? now : this.updatedAt;
        // Normalize role just in case
        if (this.role != null) this.role = this.role.trim().toUpperCase();
    }

    @PreUpdate
    public void onUpdate() {
        this.updatedAt = LocalDateTime.now();
        if (this.role != null) this.role = this.role.trim().toUpperCase();
    }

    // Getters & Setters

    public long getId() { return id; }

    public void setId(long id) { this.id = id; }

    public String getName() { return name; }

    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }

    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }

    public void setPassword(String password) { this.password = password; }

    public String getRole() { return role; }

    public void setRole(String role) { this.role = role; }

    public LocalDateTime getCreatedAt() { return createdAt; }

    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }

    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
}
