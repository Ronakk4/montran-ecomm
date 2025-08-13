package com.capstone.controller;



import com.capstone.model.Buyer;
import com.capstone.model.User;
import com.capstone.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;

import java.util.List;

@RestController
@RequestMapping("/register")
public class UserController {
	
	@Autowired
    private UserService userService;
	
//	@GetMapping
//	public void getUser(id) {
//		
//	}

    @PostMapping
    public void registerUser(@RequestBody Buyer user) {
    	System.out.println("called");
        userService.registerUser(user);
    }



//    @GetMapping
//    public List<User> listUsers() {
//        return userDao.list();
//    }

//    @PutMapping("/{id}")
//    public void updateDepartment(@PathVariable Long id, @RequestBody User user) {
//        user.setid(id);
//        userDao.update(user);
//    }

//    @DeleteMapping("/{id}")
//    public void deleteUser(@PathVariable Long id) {
//        userDao.delete(id);
//    }
//	
	

}
