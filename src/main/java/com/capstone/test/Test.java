

package com.capstone.test;

import java.time.LocalDateTime;
import java.util.ArrayList;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.capstone.model.Buyer;
import com.capstone.model.OrderHeader;
import com.capstone.model.OrderItem;
import com.capstone.model.Product;
import com.capstone.model.Seller;
import com.capstone.util.HibernateUtil;

public class Test {
	public static void main(String[] args) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		
		Seller seller = new Seller("Amit Sharma", // name
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

		Product p1 = new Product(
			    "Cotton T-Shirt",                               // prodName
			    "100% cotton round-neck T-shirt in navy blue",  // prodDescription
			    499.00,                                         // price
			    120,                                            // stockQuantity
			    "Clothing",                                     // category
			    LocalDateTime.of(2025, 8, 13, 12, 0),           // createdAt
			    LocalDateTime.of(2025, 8, 13, 12, 30)	        // updatedAt

			);
		Product p2 = new Product(
			    "Wireless Headphones",                          // prodName
			    "Noise-cancelling over-ear headphones",         // prodDescription
			    2999.99,                                        // price
			    50,                                             // stockQuantity
			    "Electronics",                                  // category
			    LocalDateTime.of(2025, 8, 13, 11, 0),           // createdAt
			    LocalDateTime.of(2025, 8, 13, 11, 30)          // updatedAt
			                                            
			);
			
		OrderHeader orderHeader = new OrderHeader(
			    "PLACED",
			    0.0, // will update after adding items
			    buyer,
			    new ArrayList<>()
			);
		
		OrderItem item1 = new OrderItem(orderHeader, p1, seller, 1, p1.getPrice());
		OrderItem item2 = new OrderItem(orderHeader, p2, seller, 2, p2.getPrice());

 

		
			seller.getProducts().add(p2);
			seller.getProducts().add(p1);
			
//			order.setBuyer(buyer);
//			buyer.getOrders().add(order);
			p1.setSeller(seller);
			p2.setSeller(seller);
			
			
			

		Transaction t = session.beginTransaction();
		session.save(p1);
		session.save(p2);
		session.save(buyer);
		session.save(seller);
		session.save(orderHeader);
		session.save(item1);
		session.save(item2);
		t.commit();

	}
}

