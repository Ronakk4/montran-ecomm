//package com.capstone.controller;
//
//import com.capstone.dto.BuyerDTO;
//import com.capstone.dto.LoginRequestDTO;
//import com.capstone.dto.LoginResponseDTO;
//import com.capstone.dto.SellerDTO;
//import com.capstone.dto.UpdateUserDTO;
//import com.capstone.dto.UserDTO;
//import com.capstone.model.Buyer;
//
//import com.capstone.model.User;
//import com.capstone.service.UserService;
//import com.capstone.util.JwtUtil;
//
//import java.util.Map;
//
//import javax.validation.Valid;
//
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//@RestController
//@RequestMapping("/users")
//public class UserController {
//
//    @Autowired
//    private UserService userService;
//    
//   
//   
//    
//    @PostMapping
//    public String registerUser(@Valid @RequestBody User user) {
//        userService.registerUser(user);
//        return "User registered successfully";
//    }
//
//
//    @PostMapping("/login")
//    public ResponseEntity<LoginResponseDTO> loginUser(@RequestBody LoginRequestDTO user) {
//    	System.out.println("called");
//        if (userService.loginUser(user)) {
//            String token = JwtUtil.generateToken(user.getEmail());
//
//            // store token in session
//            session.setAttribute("jwtToken", token);
//
//            LoginResponseDTO response = new LoginResponseDTO("User login processed", token);
//            return ResponseEntity.ok(response);
//        }
//        return ResponseEntity.status(HttpServletResponse.SC_UNAUTHORIZED)
//                             .body(new LoginResponseDTO("Invalid credentials", null));
//    }
//
//
//
//    
//    @GetMapping("/id/{id}")
//    public User findUser(@PathVariable long id) {
//        return userService.findUser(id);
//    }
//
//    
////    @PutMapping("/{id}")
////    public String updateUser(@PathVariable long id, @RequestBody Map<String, Object> json) {
////        String role = json.get("role") != null ? json.get("role").toString() : null;
////
////        UserDTO dto;
////
////        if ("BUYER".equalsIgnoreCase(role)) {
////            BuyerDTO buyerDTO = new BuyerDTO();
////            mapCommonFields(buyerDTO, json);
////            buyerDTO.setShippingAddress((String) json.get("shippingAddress"));
////            buyerDTO.setPhoneNumber((String) json.get("phoneNumber"));
////            dto = buyerDTO;
////        }
////        else if ("SELLER".equalsIgnoreCase(role)) {
////            SellerDTO sellerDTO = new SellerDTO();
////            mapCommonFields(sellerDTO, json);
////            sellerDTO.setShopName((String) json.get("shopName"));
////            sellerDTO.setShopDescription((String) json.get("shopDescription"));
////            sellerDTO.setGstNumber((String) json.get("gstNumber"));
////            dto = sellerDTO;
////        }
////        else {
////            throw new RuntimeException("Invalid role. Must be BUYER or SELLER.");
////        }
////
////        userService.updateUser(id, dto);
////        return "User updated successfully";
////    }
//    
//    @PutMapping("/{id}")
//    public String updateUser(@PathVariable long id, @RequestBody UpdateUserDTO dto) {
//        if ("BUYER".equalsIgnoreCase(dto.getRole())) {
//            BuyerDTO buyerDTO = new BuyerDTO();
//            buyerDTO.setName(dto.getName());
//            buyerDTO.setEmail(dto.getEmail());
//            buyerDTO.setPassword(dto.getPassword());
//            buyerDTO.setRole(dto.getRole());
//            buyerDTO.setShippingAddress(dto.getShippingAddress());
//            buyerDTO.setPhoneNumber(dto.getPhoneNumber());
//            userService.updateUser(id, buyerDTO);
//        }
//        else if ("SELLER".equalsIgnoreCase(dto.getRole())) {
//            SellerDTO sellerDTO = new SellerDTO();
//            sellerDTO.setName(dto.getName());
//            sellerDTO.setEmail(dto.getEmail());
//            sellerDTO.setPassword(dto.getPassword());
//            sellerDTO.setRole(dto.getRole());
//            sellerDTO.setShopName(dto.getShopName());
//            sellerDTO.setShopDescription(dto.getShopDescription());
//            sellerDTO.setGstNumber(dto.getGstNumber());
//            userService.updateUser(id, sellerDTO);
//        }
//        else {
//            throw new RuntimeException("Invalid role. Must be BUYER or SELLER.");
//        }
//
//        return "User updated successfully";
//    }
//
//
//
//
////    @DeleteMapping("/{id}")
////    public String deleteUser(@PathVariable Long id) {
////        userService.deleteUser(id);
////        return "User deleted successfully";
////    }
//    
//    private void mapCommonFields(UserDTO dto, Map<String, Object> json) {
//        dto.setName((String) json.get("name"));
//        dto.setEmail((String) json.get("email"));
//        dto.setPassword((String) json.get("password"));
//        dto.setRole((String) json.get("role"));
//    }
//
//}


package com.capstone.controller;

import com.capstone.dto.BuyerDTO;
import com.capstone.dto.LoginRequestDTO;
import com.capstone.dto.LoginResponseDTO;
import com.capstone.dto.SellerDTO;
import com.capstone.dto.UpdateUserDTO;
import com.capstone.dto.UserDTO;
import com.capstone.model.Buyer;
import com.capstone.model.Seller;
import com.capstone.model.User;
import com.capstone.service.UserService;
import com.capstone.util.JwtUtil;

import java.time.LocalDateTime;
import java.util.Map;

import javax.validation.Valid;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;
    
    @PostMapping("/register/buyer")
    public ResponseEntity<String> registerBuyer(@Valid @RequestBody BuyerDTO buyerDTO) {
        Buyer buyer = new Buyer();
        buyer.setName(buyerDTO.getName());
        buyer.setEmail(buyerDTO.getEmail());
        buyer.setPassword(buyerDTO.getPassword());
        buyer.setRole("BUYER");
        buyer.setShippingAddress(buyerDTO.getShippingAddress());
        buyer.setPhoneNumber(buyerDTO.getPhoneNumber());
        buyer.setCreatedAt(LocalDateTime.now());
        buyer.setUpdatedAt(LocalDateTime.now());
        
        userService.registerUser(buyer);
        return ResponseEntity.ok("Buyer registered successfully");
    }
    
    @PostMapping("/register/seller")
    public ResponseEntity<String> registerSeller(@Valid @RequestBody SellerDTO sellerDTO) {
        Seller seller = new Seller();
        seller.setName(sellerDTO.getName());
        seller.setEmail(sellerDTO.getEmail());
        seller.setPassword(sellerDTO.getPassword());
        seller.setRole("SELLER");
        seller.setShopName(sellerDTO.getShopName());
        seller.setShopDescription(sellerDTO.getShopDescription());
        seller.setGstNumber(sellerDTO.getGstNumber());
        seller.setCreatedAt(LocalDateTime.now());
        seller.setUpdatedAt(LocalDateTime.now());
        
        userService.registerUser(seller);
        return ResponseEntity.ok("Seller registered successfully");
    }
    
    @PostMapping
    public String registerUser(@Valid @RequestBody User user) {
        userService.registerUser(user);
        return "User registered successfully";
    }

//    @PostMapping("/login")
//    public ResponseEntity<LoginResponseDTO> loginUser(@RequestBody LoginRequestDTO loginRequest, HttpSession session) {
//        System.out.println("Login attempt for: " + loginRequest.getEmail() + " as " + loginRequest.getRole());
//        
//        if (userService.loginUser(loginRequest)) {
//            String token = JwtUtil.generateToken(loginRequest.getEmail());
//            
//            // Store user info in session
//            session.setAttribute("jwtToken", token);
//            session.setAttribute("userEmail", loginRequest.getEmail());
//            session.setAttribute("userRole", loginRequest.getRole());
//            session.setAttribute("isLoggedIn", true);
//
//            LoginResponseDTO response = new LoginResponseDTO("User login successful", token);
//            return ResponseEntity.ok(response);
//        }
//        return ResponseEntity.status(HttpServletResponse.SC_UNAUTHORIZED)
//                             .body(new LoginResponseDTO("Invalid credentials", null));
//    }
    
    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> loginUser(@RequestBody LoginRequestDTO loginRequest, HttpSession session) {
        System.out.println("Login attempt for: " + loginRequest.getEmail() + " as " + loginRequest.getRole());

        if (userService.loginUser(loginRequest)) {
            // Generate token with email and role
            String token = JwtUtil.generateToken(loginRequest.getEmail(), loginRequest.getRole());

            // Store user info in session
            session.setAttribute("jwtToken", token);
            session.setAttribute("userEmail", loginRequest.getEmail());
            session.setAttribute("userRole", loginRequest.getRole());
            session.setAttribute("isLoggedIn", true);

            LoginResponseDTO response = new LoginResponseDTO("User login successful", token);
            return ResponseEntity.ok(response);
        }
        return ResponseEntity.status(HttpServletResponse.SC_UNAUTHORIZED)
                             .body(new LoginResponseDTO("Invalid credentials", null));
    }


    @PostMapping("/logout")
    public ResponseEntity<String> logoutUser(HttpSession session) {
        session.invalidate();
        return ResponseEntity.ok("Logged out successfully");
    }
    
    @GetMapping("/id/{id}")
    public User findUser(@PathVariable long id) {
        return userService.findUser(id);
    }
    
    @PutMapping("/{id}")
    public String updateUser(@PathVariable long id, @RequestBody UpdateUserDTO dto) {
        if ("BUYER".equalsIgnoreCase(dto.getRole())) {
            BuyerDTO buyerDTO = new BuyerDTO();
            buyerDTO.setName(dto.getName());
            buyerDTO.setEmail(dto.getEmail());
            buyerDTO.setPassword(dto.getPassword());
            buyerDTO.setRole(dto.getRole());
            buyerDTO.setShippingAddress(dto.getShippingAddress());
            buyerDTO.setPhoneNumber(dto.getPhoneNumber());
            userService.updateUser(id, buyerDTO);
        }
        else if ("SELLER".equalsIgnoreCase(dto.getRole())) {
            SellerDTO sellerDTO = new SellerDTO();
            sellerDTO.setName(dto.getName());
            sellerDTO.setEmail(dto.getEmail());
            sellerDTO.setPassword(dto.getPassword());
            sellerDTO.setRole(dto.getRole());
            sellerDTO.setShopName(dto.getShopName());
            sellerDTO.setShopDescription(dto.getShopDescription());
            sellerDTO.setGstNumber(dto.getGstNumber());
            userService.updateUser(id, sellerDTO);
        }
        else {
            throw new RuntimeException("Invalid role. Must be BUYER or SELLER.");
        }

        return "User updated successfully";
    }
}