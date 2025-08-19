package com.capstone.controller.buyer;

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
	  public String profile() {
		  return "profile";
	  }
	  
	  public String getMethodName(@RequestParam String param) {
	  	return new String();
	  }
	  
	

}
