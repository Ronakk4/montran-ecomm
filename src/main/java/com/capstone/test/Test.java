package com.capstone.test;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

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
        Transaction t = session.beginTransaction();

        try {
            // --- SELLER ---
            Seller seller = new Seller(
                "Rohit", 
                "rohit.sharma@example.com", 
                "securePassword123", 
                "SELLER",
                LocalDateTime.of(2025, 8, 13, 10, 30),
                LocalDateTime.of(2025, 8, 13, 10, 45),
                "Amit's Electronics",
                "We sell the latest gadgets and accessories",
                "27ABCDE1234F1Z5"
            );
            
            Seller seller2 = new Seller(
            		"michael Sharma", 
            		"mich.sharma@example.com", 
            		"securePassword123", 
            		"SELLER",
            		LocalDateTime.of(2025, 8, 13, 10, 30),
            		LocalDateTime.of(2025, 8, 13, 10, 45),
            		"Amit's Electronics",
            		"We sell the latest gadgets and accessories",
            		"27ABCDE1234F1Z5"
            		);

            // --- BUYER ---
            Buyer buyer = new Buyer(
                "Greha Verma", 
                "greha.verma@example.com", 
                "mySecurePass456", 
                "BUYER",
                LocalDateTime.of(2025, 8, 13, 9, 15),
                LocalDateTime.of(2025, 8, 13, 9, 45),
                "Flat 302, Green Heights, Borivali West, Mumbai", 
                "+91-9876543210"
            );

            // --- PRODUCTS ---
            Product p1 = new Product(
                "RTX 5080",
                "100% cotton round-neck T-shirt in navy blue",
                499.00,
                120,
                "Electronics",
                LocalDateTime.of(2025, 8, 13, 12, 0),
                LocalDateTime.of(2025, 8, 13, 12, 30)
            );

<<<<<<< HEAD

		
			seller.getProducts().add(p2);
			seller.getProducts().add(p1);
			
//		order.setBuyer(buyer)
//		buyer.getOrders().add(order);
			p1.setSeller(seller);
			//p2.setSeller(seller);
			
			
			

=======
            Product p2 = new Product(
                "Brush",
                "Noise-cancelling over-ear headphones",
                2.99,
                50,
                "Utility",
                LocalDateTime.of(2025, 8, 13, 11, 0),
                LocalDateTime.of(2025, 8, 13, 11, 30)
            );
>>>>>>> 3ac3de90508ca577f5544b11bd736df2a024a05b

            // link seller <-> products
            p1.setSeller(seller);
            p2.setSeller(seller);
            seller.getProducts().add(p1);
            seller.getProducts().add(p2);
            // --- ORDER HEADER ---
            OrderHeader orderHeader = new OrderHeader();
            orderHeader.setBuyer(buyer);
            orderHeader.setStatus("Pending");
            orderHeader.setTotalAmount(499.00 * 2 + 2999.99); // just an example total

            // --- ORDER ITEMS ---
            List<OrderItem> items = new ArrayList<>();

            OrderItem item1 = new OrderItem();
            item1.setOrderHeader(orderHeader);
            item1.setProduct(p1);
            item1.setSeller(seller);
            item1.setQuantity(2);
            item1.setPrice(499.00 * 2);

            OrderItem item2 = new OrderItem();
            item2.setOrderHeader(orderHeader);
            item2.setProduct(p2);
            item2.setSeller(seller2);
            item2.setQuantity(1);
            item2.setPrice(2999.99);

            items.add(item1);
            items.add(item2);

            orderHeader.setItems(items);

            // --- SAVE ALL ---
            session.save(seller);
            session.save(seller2);
            session.save(buyer);
            session.save(p1);
            session.save(p2);
            session.save(orderHeader); // cascade should handle order items

            t.commit();
            System.out.println("✅ Sample order inserted successfully!");
        } catch (Exception e) {
            if (t != null) t.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }
}
