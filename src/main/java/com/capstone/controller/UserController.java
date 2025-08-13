package com.capstone.controller;

import com.capstone.model.User;
import com.capstone.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;


    @PostMapping("/register")
    public String registerUser(@RequestBody User user) {
        userService.registerUser(user);
        return "User registered successfully";
    }


    @PostMapping("/login")
    public String loginUser(@RequestBody User user) {
        userService.loginUser(user);
        return "User login processed";
    }


    @GetMapping("/{id}")
    public User findUser(@PathVariable long id) {
        return userService.findUser(id);
    }

    @PutMapping("/{id}")
    public String updateUser(@PathVariable long id, @RequestBody User updatedUser) {
        updatedUser.setId(id);
        userService.updateUser(updatedUser);
        return "User updated successfully";
    }
}
