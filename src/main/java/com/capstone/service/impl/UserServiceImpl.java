package com.capstone.service.impl;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.UserDao;
import com.capstone.dto.BuyerDTO;
import com.capstone.dto.LoginRequestDTO;
import com.capstone.dto.SellerDTO;
import com.capstone.dto.UserDTO;
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
	public void updateUser(Long id, UserDTO dto) {
	    User existingUser = userDao.findUserById(id);

	    // Common fields update
	    if (dto.getName() != null) existingUser.setName(dto.getName());
	    if (dto.getEmail() != null) existingUser.setEmail(dto.getEmail());
	    if (dto.getPassword() != null) existingUser.setPassword(dto.getPassword());
	    if (dto.getRole() != null) existingUser.setRole(dto.getRole());

	    // Buyer-specific update
	    if (existingUser instanceof Buyer && dto instanceof BuyerDTO) {
	        Buyer buyer = (Buyer) existingUser;
	        BuyerDTO buyerDTO = (BuyerDTO) dto;

	        if (buyerDTO.getShippingAddress() != null) buyer.setShippingAddress(buyerDTO.getShippingAddress());
	        if (buyerDTO.getPhoneNumber() != null) buyer.setPhoneNumber(buyerDTO.getPhoneNumber());
	    }

	    // Seller-specific update
	    if (existingUser instanceof Seller && dto instanceof SellerDTO) {
	        Seller seller = (Seller) existingUser;
	        SellerDTO sellerDTO = (SellerDTO) dto;

	        if (sellerDTO.getShopName() != null) seller.setShopName(sellerDTO.getShopName());
	        if (sellerDTO.getShopDescription() != null) seller.setShopDescription(sellerDTO.getShopDescription());
	        if (sellerDTO.getGstNumber() != null) seller.setGstNumber(sellerDTO.getGstNumber());
	    }

	    userDao.saveUser(existingUser);
	}


	@Override
	public boolean loginUser(LoginRequestDTO user) {
	    if (user.getEmail() == null || user.getPassword() == null) {
	        System.out.println("Email and password must be provided");
	        return false;
	    }

	    User existingUser = userDao.findUserByEmail(user.getEmail().trim());

	    if (existingUser == null) {
	       return false;
	    } 
	    else {
	        if (user.getPassword().equals(existingUser.getPassword())) {
	        	return true;
	        } 
	        else {
	            return false;
	        }
	    
	}

		 
		
		 
		
	}

			
		
	






	@Override
	public User findUserByEmail(String email) {
		// TODO Auto-generated method stub
		return userDao.findUserByEmail(email);
	}


}
