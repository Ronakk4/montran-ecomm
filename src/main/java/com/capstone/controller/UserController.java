package com.capstone.controller;

import com.capstone.model.Buyer;

import com.capstone.model.User;
import com.capstone.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;


    @PostMapping
    public String registerUser(@RequestBody Buyer user) {

        userService.registerUser(user);
        return "User registered successfully";
    }

    
    
//    @GetMapping
//    public List<User> getAllUsers() {
//        return userService.getAllUsers();
//    }


 



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



//    @DeleteMapping("/{id}")
//    public String deleteUser(@PathVariable Long id) {
//        userService.deleteUser(id);
//        return "User deleted successfully";
//    }

}
