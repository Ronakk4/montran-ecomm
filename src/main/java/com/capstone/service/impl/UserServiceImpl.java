package com.capstone.service.impl;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.UserDao;
import com.capstone.model.Buyer;
import com.capstone.model.User;
import com.capstone.service.UserService;

@Service
public class UserServiceImpl implements UserService{
	
	@Autowired
	private UserDao userDao;

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
	public void updateUser(User user) {
		// TODO Auto-generated method stub
		 if (userDao.findUserByEmail(user.getEmail()) != null) {
	            userDao.saveUser(user);
	        }
		
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
