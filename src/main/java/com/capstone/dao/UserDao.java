package com.capstone.dao;



import com.capstone.dto.UserRegisterDTO;
import com.capstone.model.User;

public interface UserDao {
	User findUserById(long id);
	User findUserByEmail(String email);
	void saveUser(User user);
	void updateUser(User u);
    void deleteUser(User u);	
	
}
