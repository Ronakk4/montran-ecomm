package com.capstone.test;

import java.time.LocalDateTime;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.capstone.model.Buyer;
import com.capstone.model.Seller;
import com.capstone.model.User;
import com.capstone.util.HibernateUtil;

public class Test {
	public static void main(String[] args) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		User seller = new Seller("Amit Sharma", // name
				"amit.sharma@example.com", // email
				"securePassword123", // password
				"SELLER", // role
				LocalDateTime.of(2025, 8, 13, 10, 30), // createdAt
				LocalDateTime.of(2025, 8, 13, 10, 45), // updatedAt
				"Amit's Electronics", // shopName
				"We sell the latest gadgets and accessories", // shopDescription
				"27ABCDE1234F1Z5" // gstNumber
		);
		Buyer buyer = new Buyer("Neha Verma", // name
				"neha.verma@example.com", // email
				"mySecurePass456", // password
				"BUYER", // role
				LocalDateTime.of(2025, 8, 13, 9, 15), // createdAt
				LocalDateTime.of(2025, 8, 13, 9, 45), // updatedAt
				"Flat 302, Green Heights, Borivali West, Mumbai", // shippingAddress
				"+91-9876543210" // phoneNumber
		);
		
		Transaction t = session.beginTransaction();
		session.save(buyer);
		session.save(seller);
		t.commit();

	}
}
