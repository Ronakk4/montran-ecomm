package com.capstone.service.impl;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.UserDao;
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
		return userDao.findUser(id);
	}

	@Override
	@Transactional
	public void registerUser(User user) {
		// TODO Auto-generated method stub
		 if (user.getEmail() != null && userDao.findByEmail(user.getEmail().trim()) != null) {
	         //   return false; 
	        }
	        userDao.save(user);
	       // return true;
		
	}
//
//	@Override
//	@Transactional
//	public void updateUser(User user) {
//		// TODO Auto-generated method stub
//		 if (userDao.findByEmail(user.getEmail()) != null) {
//	            userDao.update(user);
//	        }
//		
//	}

//	@Override
//	@Transactional
//	public boolean loginUser(User user) {
//		// TODO Auto-generated method stub
//		 if (userDao.findByEmail(user.getEmail()) != null) {
//	            return userDao.login(user);
//	        }
//		 return false;
//			
//		
//	}



}
