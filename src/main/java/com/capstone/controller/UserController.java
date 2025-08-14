package com.capstone.controller;

import com.capstone.dto.BuyerDTO;
import com.capstone.dto.LoginRequestDTO;
import com.capstone.dto.SellerDTO;
import com.capstone.dto.UserDTO;
import com.capstone.model.Buyer;

import com.capstone.model.User;
import com.capstone.service.UserService;



import java.util.Map;


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



 



    @PostMapping("/login")
    public String loginUser(@RequestBody LoginRequestDTO user) {
        userService.loginUser(user);
        return "User login processed";
    }


    @GetMapping("/{id}")
    public User findUser(@PathVariable long id) {

        return userService.findUser(id);
    }

    @PutMapping("/{id}")
    public String updateUser(@PathVariable long id, @RequestBody Map<String, Object> json) {
        String role = json.get("role") != null ? json.get("role").toString() : null;

        UserDTO dto;

        if ("BUYER".equalsIgnoreCase(role)) {
            BuyerDTO buyerDTO = new BuyerDTO();
            mapCommonFields(buyerDTO, json);
            buyerDTO.setShippingAddress((String) json.get("shippingAddress"));
            buyerDTO.setPhoneNumber((String) json.get("phoneNumber"));
            dto = buyerDTO;
        }
        else if ("SELLER".equalsIgnoreCase(role)) {
            SellerDTO sellerDTO = new SellerDTO();
            mapCommonFields(sellerDTO, json);
            sellerDTO.setShopName((String) json.get("shopName"));
            sellerDTO.setShopDescription((String) json.get("shopDescription"));
            sellerDTO.setGstNumber((String) json.get("gstNumber"));
            dto = sellerDTO;
        }
        else {
            throw new RuntimeException("Invalid role. Must be BUYER or SELLER.");
        }

        userService.updateUser(id, dto);
        return "User updated successfully";
    }



//    @DeleteMapping("/{id}")
//    public String deleteUser(@PathVariable Long id) {
//        userService.deleteUser(id);
//        return "User deleted successfully";
//    }
    
    private void mapCommonFields(UserDTO dto, Map<String, Object> json) {
        dto.setName((String) json.get("name"));
        dto.setEmail((String) json.get("email"));
        dto.setPassword((String) json.get("password"));
        dto.setRole((String) json.get("role"));
    }

}