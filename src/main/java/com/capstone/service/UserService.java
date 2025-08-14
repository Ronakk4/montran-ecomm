package com.capstone.service;

import com.capstone.model.Buyer;
import com.capstone.model.User;

public interface UserService {
	User findUser(long id);
	void updateUser(User u);
	void loginUser(User u);
	void registerUser(Buyer u);
}