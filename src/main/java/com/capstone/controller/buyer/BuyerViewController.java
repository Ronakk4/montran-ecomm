package com.capstone.controller.buyer;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/app/buyer")
public class BuyerViewController {
	 @GetMapping("/")
	    public String dashboard() {
	        return "buyer-dashboard"; 
	    }
	  @GetMapping("/orders")
	  public String orders() {
		  return "orders";
	  }
	  
	  @GetMapping("/profile")
	  public String profile(HttpServletResponse response) {
		    // Prevent caching
		    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
		    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
		    response.setDateHeader("Expires", 0); // Proxies
		    return "UserProfile"; 
	  }
	  public String getMethodName(@RequestParam String param) {
	  	return new String();
	  }
	  	
	

}
