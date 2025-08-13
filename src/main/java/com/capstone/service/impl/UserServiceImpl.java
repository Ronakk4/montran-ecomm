package com.capstone.service.impl;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		return userDao.findById(id);
	}

	@Override
	@Transactional
	public void registerUser(User u) {
		// TODO Auto-generated method stub
		userDao.save(u);
		
	}

	@Override
	public void updateUser(User u) {
		// TODO Auto-generated method stub
		userDao.update(u);
		
	}

	@Override
	public void loginUser(User u) {
		// TODO Auto-generated method stub
		userDao.login(u);
		
	}



}
