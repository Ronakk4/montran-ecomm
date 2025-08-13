package com.capstone.model;

<<<<<<< HEAD
public class User {
	String name;
=======
>>>>>>> 8b301421f075e6d318b22c1de7f99fe506b86caf

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Table(name="app_user")
public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	private String name;
	private String email;
	private String password;
	private String role;
	LocalDateTime createdAt;
	LocalDateTime updatedAt;
	
	
}
