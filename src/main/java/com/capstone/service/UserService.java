package com.capstone.service;

import com.capstone.dto.LoginRequestDTO;
import com.capstone.dto.UserDTO;
import com.capstone.model.Buyer;
import com.capstone.model.User;

public interface UserService {
	User findUser(long id);
	void updateUser(Long id ,UserDTO u);
	boolean loginUser(LoginRequestDTO u);
	void registerUser(Buyer u);
}