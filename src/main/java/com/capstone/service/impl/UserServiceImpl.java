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
import com.capstone.exception.DuplicateEmailException;
import com.capstone.exception.UserNotFoundException;
import com.capstone.model.Buyer;
import com.capstone.model.Seller;
import com.capstone.model.User;
import com.capstone.service.UserService;
import com.capstone.util.PasswordUtil;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public User findUser(long id) throws UserNotFoundException {
        User user = userDao.findUserById(id);
        if (user == null) {
            throw new UserNotFoundException("User with ID " + id + " not found !!");
        }
        return user;
    }

    @Override
    @Transactional
    public void registerUser(@Valid UserRegisterDTO user) throws DuplicateEmailException {
        if (user.getEmail() != null && userDao.findUserByEmail(user.getEmail().trim()) != null) {
            throw new DuplicateEmailException("Email already registered: " + user.getEmail());
        }

        // Hash the password before saving
        String hashedPassword = PasswordUtil.hashPassword(user.getPassword());


        if ("SELLER".equalsIgnoreCase(user.getRole())) {
            Seller seller = new Seller(
                user.getName(), user.getEmail(), hashedPassword,
                "SELLER", LocalDateTime.now(), LocalDateTime.now(),
                user.getShopName(), user.getShopDescription(), user.getGstNumber(), user.getPhoneNumber()
            );
            userDao.saveUser(seller);

        } else if ("BUYER".equalsIgnoreCase(user.getRole())) {
            Buyer buyer = new Buyer(
                user.getName(), user.getEmail(), hashedPassword,
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
        if (existingUser == null) {
            throw new UserNotFoundException("User not found with id " + id);
        }

        // Common fields
        if (dto.getName() != null) existingUser.setName(dto.getName());
        if (dto.getEmail() != null) existingUser.setEmail(dto.getEmail());
        if (dto.getRole() != null) existingUser.setRole(dto.getRole());
//        if (dto.getPhoneNumber() != null) existingUser.setPhoneNumber(dto.getPhoneNumber()); 

        // Password handling 
        if (dto.getPassword() != null && !dto.getPassword().isEmpty()) {
            existingUser.setPassword(PasswordUtil.hashPassword(dto.getPassword()));
        }

        // Role-specific fields
        if (existingUser instanceof Buyer && dto instanceof BuyerDTO) {
            Buyer buyer = (Buyer) existingUser;
            BuyerDTO buyerDTO = (BuyerDTO) dto;
            if (buyerDTO.getShippingAddress() != null) buyer.setShippingAddress(buyerDTO.getShippingAddress());
            if (buyerDTO.getPhoneNumber() != null) buyer.setPhoneNumber(buyerDTO.getPhoneNumber());
        }

        if (existingUser instanceof Seller && dto instanceof SellerDTO) {
            Seller seller = (Seller) existingUser;
            SellerDTO sellerDTO = (SellerDTO) dto;
            if (sellerDTO.getShopName() != null) seller.setShopName(sellerDTO.getShopName());
            if (sellerDTO.getShopDescription() != null) seller.setShopDescription(sellerDTO.getShopDescription());
            if (sellerDTO.getGstNumber() != null) seller.setGstNumber(sellerDTO.getGstNumber());
        }

        // Persist changes
        userDao.updateUser(existingUser);
    }


    @Override
    public User loginUser(LoginRequestDTO user) {
        if (user.getEmail() == null || user.getPassword() == null) return null;

        User existingUser = userDao.findUserByEmail(user.getEmail().trim());
        if (existingUser == null) return null;

        // Verify password using BCrypt
        if (PasswordUtil.verifyPassword(user.getPassword(), existingUser.getPassword())) {
            return existingUser;
        } else {
            return null;
        }
    }
    
    @Override
    public User findUserByEmail(String email) {
    	return userDao.findUserByEmail(email.trim());
    }

    @Override
    public boolean changePassword(String newPassword, String oldPassword, long id) {
        String oldHashed = userDao.getPassword(id);

        // Verify old password
        if (PasswordUtil.verifyPassword(oldPassword, oldHashed)) {
            String newHashed = PasswordUtil.hashPassword(newPassword);
            userDao.changePassword(newHashed, id);
            return true;
        }
        return false;
    }
}