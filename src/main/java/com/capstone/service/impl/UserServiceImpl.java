//package com.capstone.service.impl;
//import javax.transaction.Transactional;
//import javax.validation.Valid;
//
//import org.hibernate.SessionFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import com.capstone.dao.UserDao;
//import com.capstone.dto.BuyerDTO;
//import com.capstone.dto.LoginRequestDTO;
//import com.capstone.dto.SellerDTO;
//import com.capstone.dto.UserDTO;
//import com.capstone.exception.UserNotFoundException;
//import com.capstone.model.Buyer;
//import com.capstone.model.Seller;
//import com.capstone.model.User;
//import com.capstone.service.UserService;
//
//@Service
//public class UserServiceImpl implements UserService{
//	
//	@Autowired
//	private UserDao userDao;
//	
//	@Autowired
//	private SessionFactory sessionFactory;
//
//	@Override
//	@Transactional
//	public User findUser(long id) throws UserNotFoundException{
//		// TODO Auto-generated method stub
//		User user = userDao.findUserById(id);
//		if(user == null) {
//			throw new UserNotFoundException("User with ID "+ id + " not found !!");
//		}
//		return user;
//	}
//
//	@Override
//	@Transactional
//	
//	public void registerUser(@Valid User user) {
//		// TODO Auto-generated method stub
//		 if (user.getEmail() != null && userDao.findUserByEmail(user.getEmail().trim()) != null) {
//			 System.out.println("user exists");
//	        }
//		 	
//	        userDao.saveUser(user);
//	        System.out.println("user created");
//		
//	}
//
//	@Override
//	@Transactional
//	public void updateUser(Long id, UserDTO dto) {
//	    User existingUser = userDao.findUserById(id);
//
//	    // Common fields update
//	    if (dto.getName() != null) existingUser.setName(dto.getName());
//	    if (dto.getEmail() != null) existingUser.setEmail(dto.getEmail());
//	    if (dto.getPassword() != null) existingUser.setPassword(dto.getPassword());
//	    if (dto.getRole() != null) existingUser.setRole(dto.getRole());
//
//	    // Buyer-specific update
//	    if (existingUser instanceof Buyer && dto instanceof BuyerDTO) {
//	        Buyer buyer = (Buyer) existingUser;
//	        BuyerDTO buyerDTO = (BuyerDTO) dto;
//
//	        if (buyerDTO.getShippingAddress() != null) buyer.setShippingAddress(buyerDTO.getShippingAddress());
//	        if (buyerDTO.getPhoneNumber() != null) buyer.setPhoneNumber(buyerDTO.getPhoneNumber());
//	    }
//
//	    // Seller-specific update
//	    if (existingUser instanceof Seller && dto instanceof SellerDTO) {
//	        Seller seller = (Seller) existingUser;
//	        SellerDTO sellerDTO = (SellerDTO) dto;
//
//	        if (sellerDTO.getShopName() != null) seller.setShopName(sellerDTO.getShopName());
//	        if (sellerDTO.getShopDescription() != null) seller.setShopDescription(sellerDTO.getShopDescription());
//	        if (sellerDTO.getGstNumber() != null) seller.setGstNumber(sellerDTO.getGstNumber());
//	    }
//
//	    userDao.saveUser(existingUser);
//	}
//
//
//	@Override
//	public boolean loginUser(LoginRequestDTO user) {
//	    if (user.getEmail() == null || user.getPassword() == null) {
//	        System.out.println("Email and password must be provided");
//	        return false;
//	    }
//
//	    User existingUser = userDao.findUserByEmail(user.getEmail().trim());
//
//	    if (existingUser == null) {
//	        System.out.println("User does not exist");
//	    } 
//	    else {
//	        if (user.getPassword().equals(existingUser.getPassword())) {
//	            System.out.println("Authenticated");
//	            return true;
//	        } 
//	        else {
//	            System.out.println("Not authenticated");
//	            return false;
//	        }
//	}
//		return false;		
//	}
//}


package com.capstone.service.impl;

import java.time.LocalDateTime;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;
    
    private BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    public User findUser(long id) {
        return userDao.findUserById(id);
    }

    @Override
    public void updateUser(Long id, UserDTO userDTO) {
        User existingUser = userDao.findUserById(id);
        if (existingUser == null) {
            throw new RuntimeException("User not found with id: " + id);
        }

        // Update common fields
        existingUser.setName(userDTO.getName());
        existingUser.setEmail(userDTO.getEmail());
        if (userDTO.getPassword() != null && !userDTO.getPassword().isEmpty()) {
            existingUser.setPassword(passwordEncoder.encode(userDTO.getPassword()));
        }
        existingUser.setUpdatedAt(LocalDateTime.now());

        // Update role-specific fields
        if (userDTO instanceof BuyerDTO) {
            BuyerDTO buyerDTO = (BuyerDTO) userDTO;
            if (existingUser instanceof Buyer) {
                Buyer buyer = (Buyer) existingUser;
                buyer.setShippingAddress(buyerDTO.getShippingAddress());
                buyer.setPhoneNumber(buyerDTO.getPhoneNumber());
                buyer.setRole("BUYER");
            } else {
                throw new RuntimeException("Cannot update non-buyer user with buyer data");
            }
        } else if (userDTO instanceof SellerDTO) {
            SellerDTO sellerDTO = (SellerDTO) userDTO;
            if (existingUser instanceof Seller) {
                Seller seller = (Seller) existingUser;
                seller.setShopName(sellerDTO.getShopName());
                seller.setShopDescription(sellerDTO.getShopDescription());
                seller.setGstNumber(sellerDTO.getGstNumber());
                seller.setRole("SELLER");
            } else {
                throw new RuntimeException("Cannot update non-seller user with seller data");
            }
        }

        userDao.updateUser(existingUser);
    }

    @Override
    public boolean loginUser(LoginRequestDTO loginRequest) {
        try {
            User user = userDao.findUserByEmail(loginRequest.getEmail());
            if (user == null) {
                System.out.println("User not found with email: " + loginRequest.getEmail());
                return false;
            }

            // Check if role matches (if role is specified in login request)
            if (loginRequest.getRole() != null && !loginRequest.getRole().isEmpty()) {
                if (!loginRequest.getRole().equalsIgnoreCase(user.getRole())) {
                    System.out.println("Role mismatch. Expected: " + loginRequest.getRole() + ", Found: " + user.getRole());
                    return false;
                }
            }

            // Check password
            boolean passwordMatches = passwordEncoder.matches(loginRequest.getPassword(), user.getPassword());
            System.out.println("Password matches: " + passwordMatches);
            
            return passwordMatches;
            
        } catch (Exception e) {
            System.err.println("Login error: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public void registerUser(@Valid User user) {
        try {
            // Check if user already exists
            User existingUser = userDao.findUserByEmail(user.getEmail());
            if (existingUser != null) {
                throw new RuntimeException("User with email " + user.getEmail() + " already exists");
            }

            // Encode password
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            
            // Set timestamps
            user.setCreatedAt(LocalDateTime.now());
            user.setUpdatedAt(LocalDateTime.now());

            userDao.saveUser(user);
            System.out.println("User registered successfully: " + user.getEmail());
            
        } catch (Exception e) {
            System.err.println("Registration error: " + e.getMessage());
            throw new RuntimeException("Failed to register user: " + e.getMessage());
        }
    }
}