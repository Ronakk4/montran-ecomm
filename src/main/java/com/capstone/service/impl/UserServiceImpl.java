package com.capstone.service.impl;
import java.time.LocalDateTime;
 
import javax.transaction.Transactional;
import javax.validation.Valid;
 
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
 
import com.capstone.dao.UserDao;
import com.capstone.dto.BuyerDTO;
import com.capstone.dto.LoginRequestDTO;
import com.capstone.dto.SellerDTO;
import com.capstone.dto.UserDTO;
import com.capstone.dto.UserRegisterDTO;
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
	public void registerUser(@Valid UserRegisterDTO user) {
		// TODO Auto-generated method stub
		 if (user.getEmail() != null && userDao.findUserByEmail(user.getEmail().trim()) != null) {
			 System.out.println("user exists");
	        }
		 	
		 if ("SELLER".equalsIgnoreCase(user.getRole())) {
	            Seller seller = new Seller(
	                    user.getName(), user.getEmail(), user.getPassword(),
	                    "SELLER", LocalDateTime.now(), LocalDateTime.now(),
	                    user.getShopName(), user.getShopDescription(), user.getGstNumber()
	            );
	             userDao.saveUser(seller);
 
	        } else if ("BUYER".equalsIgnoreCase(user.getRole())) {
	            Buyer buyer = new Buyer(
	                    user.getName(), user.getEmail(), user.getPassword(),
	                    "BUYER", LocalDateTime.now(), LocalDateTime.now(),
	                    user.getShippingAddress(), user.getPhoneNumber()
	            );
	             userDao.saveUser(buyer);
	        }
		
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
 
	    userDao.updateUser(existingUser);
	}
 
 
	@Override
	public boolean loginUser(LoginRequestDTO user) {
	    if (user.getEmail() == null || user.getPassword() == null) {
	        System.out.println("Email and password must be provided");
	        return false;
	    }
 
	    User existingUser = userDao.findUserByEmail(user.getEmail().trim());
 
	    if (existingUser == null) {
	        System.out.println("User does not exist");
	    }
	    else {
	        if (user.getPassword().equals(existingUser.getPassword())) {
	            System.out.println("Authenticated");
	            return true;
	        }
	        else {
	            System.out.println("Not authenticated");
	            return false;
	        }
	}
		return false;		
	}

	
}
 
 