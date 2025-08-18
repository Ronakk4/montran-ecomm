//package com.capstone.controller;
//
//
//
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//
//@Controller
//@RequestMapping("/app")
//public class InitialController {
//
//    @GetMapping("/login")
//    public String loginPage() {
//        return "login";
//    }
//    
//    @GetMapping("/home")
//    public String homePage() {
//    	return "home";
//    }
//
//    @GetMapping("/register")
//    public String registerBuyerPage() {
//        return "registerBuyer";
//    }
//    @GetMapping("/registerseller")
//    public String registerSellerPage() {
//    	return "registerSeller";
//    }
//    
//
//    @GetMapping("login/products")
//    public String productsPage() {
//        return "product";
//    }
//
//    @GetMapping("/orders")
//    public String ordersPage() {
//        return "orders";
//    }
//
//    @GetMapping("/dashboard")
//    public String dashboardPage() {
//        return "dashboard";
//    }
//    
//    
//}

package com.capstone.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/app")
public class InitialController {

	@GetMapping("/")
	public String indexPage() {
		return "redirect:/";
	}

	@GetMapping("/login")
	public String loginPage() {
		return "login";
	}

	@GetMapping("/seller-login")
	public String sellerLoginPage() {
		return "sellerLogin";
	}

	@GetMapping("/home")
	public String homePage(HttpSession session, Model model) {
// Check if user is logged in
		Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
		if (isLoggedIn != null && isLoggedIn) {
			String userRole = (String) session.getAttribute("userRole");
			String userEmail = (String) session.getAttribute("userEmail");

			model.addAttribute("userRole", userRole);
			model.addAttribute("userEmail", userEmail);

// Redirect to appropriate dashboard based on role
			if ("SELLER".equalsIgnoreCase(userRole)) {
				return "redirect:/seller/dashboard";
			} else {
				return "home";
			}
		}
		return "redirect:/";
	}

	@GetMapping("/register")
	public String registerBuyerPage() {
		return "registerBuyer";
	}

	@GetMapping("/register-seller")
	public String registerSellerPage() {
		return "registerSeller";
	}

	@GetMapping("/products")
	public String productsPage(HttpSession session) {
		Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
		if (isLoggedIn == null || !isLoggedIn) {
			return "redirect:/app/login";
		}
		return "product";
	}

	@GetMapping("/orders")
	public String ordersPage(HttpSession session) {
		Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
		if (isLoggedIn == null || !isLoggedIn) {
			return "redirect:/app/login";
		}
		return "orders";
	}

	@GetMapping("/dashboard")
	public String dashboardPage(HttpSession session) {
		Boolean isLoggedIn = (Boolean) session.getAttribute("isLoggedIn");
		if (isLoggedIn == null || !isLoggedIn) {
			return "redirect:/app/login";
		}

		String userRole = (String) session.getAttribute("userRole");
		if ("SELLER".equalsIgnoreCase(userRole)) {
			return "redirect:/seller/dashboard";
		}

		return "dashboard";
	}
}