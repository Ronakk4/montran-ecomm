package com.capstone.controller.buyer;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/app/buyer")
public class BuyerViewController {
	 @GetMapping("/")
	    public String dashboard() {
	        return "buyer-dashboard"; 
	    }
	

}
