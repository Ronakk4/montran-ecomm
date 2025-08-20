package com.capstone.service;

import javax.validation.Valid;

import com.capstone.dto.LoginRequestDTO;
import com.capstone.dto.UserDTO;
import com.capstone.dto.UserRegisterDTO;
import com.capstone.model.User;

public interface UserService {
	User findUser(long id);
	void updateUser(Long id ,UserDTO u);
	User loginUser(LoginRequestDTO u);
	void registerUser(@Valid UserRegisterDTO user);
	//void changePassword(@Valid String newPassword, long id);
	boolean changePassword(String newPassword, String oldPassword, long id);	

}