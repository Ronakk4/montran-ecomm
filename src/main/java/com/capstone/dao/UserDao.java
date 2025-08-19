package com.capstone.dao;

import com.capstone.model.User;

public interface UserDao {
	User findUserById(long id);
	User findUserByEmail(String email);
	void saveUser(User u);
	void updateUser(User u);
    void deleteUser(User u);
	void changePassword(String newPassword, long id);	
	
}
