package com.capstone.controller;
import com.capstone.model.Buyer;

import com.capstone.dao.UserDao;

import com.capstone.model.User;
import com.capstone.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import java.util.List;
	
@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;
    
    @PostMapping
    public void registerUser(@RequestBody Buyer user) {
    	System.out.println("called");
        userService.registerUser(user);
    }
    
    
//    @GetMapping
//    public List<User> getAllUsers() {
//        return userService.getAllUsers();
//    }


    @GetMapping("/{id}")
    public User getUserById(@PathVariable Long id) {
        return userService.findUser(id);
    }


    @PutMapping("/{id}")
    public String updateUser(@PathVariable Long id, @RequestBody User updatedUser) {
        updatedUser.setId(id);
        userService.updateUser(updatedUser);
        return "User updated successfully";
    }


//    @DeleteMapping("/{id}")
//    public String deleteUser(@PathVariable Long id) {
//        userService.deleteUser(id);
//        return "User deleted successfully";
//    }
}
