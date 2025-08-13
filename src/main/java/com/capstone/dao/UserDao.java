package com.capstone.dao;

import com.capstone.model.User;

public interface UserDao {
	User findUser(long id);
	User findByEmail(String email);
	void saveUser(User u);
	void updateUser(User u);
    void deleteUser(User u);	
	
}
