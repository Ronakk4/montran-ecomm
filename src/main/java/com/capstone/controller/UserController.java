package com.capstone.controller;

import com.capstone.dto.BuyerDTO;
import com.capstone.dto.ChangePasswordDTO;
import com.capstone.dto.LoginRequestDTO;
import com.capstone.dto.LoginResponseDTO;
import com.capstone.dto.SellerDTO;
import com.capstone.dto.UpdateUserDTO;
import com.capstone.dto.UserDTO;
//	import com.capstone.model.Buyer;
import com.capstone.dto.UserRegisterDTO;
import com.capstone.model.User;
import com.capstone.service.UserService;
import com.capstone.util.JwtUtil;

import java.io.IOException;
import java.util.Map;
 
import javax.validation.Valid;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
 
@RestController
@RequestMapping("/users")
public class UserController {


	@Autowired
	private UserService userService;

	@PostMapping
    public String registerUser(@Valid @RequestBody UserRegisterDTO user) {
        userService.registerUser(user);
        return "User registered successfully";
    }

	@PostMapping("/login")
	public void loginUser(@RequestBody LoginRequestDTO user, 
	                      HttpServletResponse response) throws IOException {
  

		User existingUser = userService.loginUser(user);
	    if (existingUser!=null) {
	        String token = JwtUtil.generateToken(existingUser.getName(), existingUser.getRole(), existingUser.getId());

          
	        // Store JWT in HttpOnly cookie (browser-specific)
	        Cookie cookie = new Cookie("jwtToken", token);
	        cookie.setHttpOnly(true); 
	        cookie.setPath("/");      
	        cookie.setMaxAge(30 * 60 * 1000); 
	        response.addCookie(cookie);

	        
	        // Redirect based on role
	       
	    } else {
	        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid credentials");
	    }
	}
	
	
	@GetMapping("/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    // 1. Invalidate session
	    if (request.getSession(false) != null) {
	        request.getSession().invalidate();
	    }

	    // 2. Remove JWT cookie
	    Cookie cookie = new Cookie("jwtToken", null);
	    cookie.setHttpOnly(true);
	    cookie.setPath("/"); // make sure path matches cookie path in login
	    cookie.setMaxAge(0); // expire immediately
	    response.addCookie(cookie);

	    // 3. Redirect to login page
	    response.sendRedirect(request.getContextPath() + "/app/login");
	}


	@GetMapping("/id/{id}")
	public User findUser(@PathVariable long id) {
		return userService.findUser(id);
	}
	
	@PutMapping("/changepassword")
	public String updatePassword( @RequestBody ChangePasswordDTO changePasswordDTO) {
		if(userService.changePassword(changePasswordDTO.getNewPassword(),changePasswordDTO.getOldPassword(),changePasswordDTO.getId()))
		return "password changed successfully";
		return "password cannot be changed";
		
	}

	@PutMapping("/{id}")
	public String updateUser(@PathVariable long id, @RequestBody UpdateUserDTO dto) {
	    if ("BUYER".equalsIgnoreCase(dto.getRole())) {
	        BuyerDTO buyerDTO = new BuyerDTO();
	        buyerDTO.setName(dto.getName());
	        buyerDTO.setEmail(dto.getEmail());
	        buyerDTO.setRole(dto.getRole());
	        buyerDTO.setPassword(dto.getPassword());   //  service will handle hashing
	        buyerDTO.setShippingAddress(dto.getShippingAddress());
	        buyerDTO.setPhoneNumber(dto.getPhoneNumber());

	        userService.updateUser(id, buyerDTO);

	    } else if ("SELLER".equalsIgnoreCase(dto.getRole())) {
	        SellerDTO sellerDTO = new SellerDTO();
	        sellerDTO.setName(dto.getName());
	        sellerDTO.setEmail(dto.getEmail());
	        sellerDTO.setRole(dto.getRole());
	        sellerDTO.setPassword(dto.getPassword());
	        sellerDTO.setShopName(dto.getShopName());
	        sellerDTO.setShopDescription(dto.getShopDescription());
	        sellerDTO.setGstNumber(dto.getGstNumber());
//	        sellerDTO.setPhoneNumber(dto.getPhoneNumber()); 

	        userService.updateUser(id, sellerDTO);

	    } else {
	        throw new RuntimeException("Invalid role. Must be BUYER or SELLER.");
	    }

	    return "User updated successfully";
	}

	// @DeleteMapping("/{id}")
	// public String deleteUser(@PathVariable Long id) {
	// userService.deleteUser(id);
	// return "User deleted successfully";
	// }

	private void mapCommonFields(UserDTO dto, Map<String, Object> json) {
		dto.setName((String) json.get("name"));
		dto.setEmail((String) json.get("email"));
		dto.setPassword((String) json.get("password"));
		dto.setRole((String) json.get("role"));

	}

}