package com.capstone.service.impl;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.UserDao;
import com.capstone.model.Buyer;
import com.capstone.model.Seller;
import com.capstone.model.User;
import com.capstone.service.UserService;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	@Transactional
	public User findUser(long id) {
		// TODO Auto-generated method stub
		return userDao.findUserById(id);
	}

	@Override
	@Transactional
	public void registerUser(Buyer user) {
		// TODO Auto-generated method stub
		 if (user.getEmail() != null && userDao.findUserByEmail(user.getEmail().trim()) != null) {
			 System.out.println("user exists");
	        }
		 	
	        userDao.saveUser(user);
	        System.out.println("user created");
		
	}

	@Override
	@Transactional
	public void updateUser(User u) {


	    // Load the actual subclass from DB (Buyer or Seller)
	    User existingUser = sessionFactory.getCurrentSession().get(User.class, u.getId());
	    if (existingUser == null) {
	        throw new IllegalArgumentException("User not found with ID: " + u.getId());
	    }

	    // Common fields
	    existingUser.setName(u.getName());
	    existingUser.setEmail(u.getEmail());
	    existingUser.setPassword(u.getPassword());
	    existingUser.setRole(u.getRole());

	    // Subclass-specific updates
	    if (existingUser instanceof Buyer && u instanceof Buyer) {
	        Buyer existingBuyer = (Buyer) existingUser;
	        Buyer incomingBuyer = (Buyer) u;
	        existingBuyer.setShippingAddress(incomingBuyer.getShippingAddress());
	        existingBuyer.setPhoneNumber(incomingBuyer.getPhoneNumber());
	    } 
	    else if (existingUser instanceof Seller && u instanceof Seller) {
	        Seller existingSeller = (Seller) existingUser;
	        Seller incomingSeller = (Seller) u;
	        existingSeller.setShopName(incomingSeller.getShopName());
	        existingSeller.setShopDescription(incomingSeller.getShopDescription());
	        existingSeller.setGstNumber(incomingSeller.getGstNumber());
	    }

	    // No need to call update() or merge()
	    // Hibernate will flush changes automatically at transaction commit
	}
	



	@Override
	@Transactional
	public void loginUser(User user) {
		// TODO Auto-generated method stub
		 if (userDao.findUserByEmail(user.getEmail()) != null) {
	             userDao.saveUser(user);
	        }
		 
			
		
	}



}
