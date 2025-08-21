	package com.capstone.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.capstone.model.Product;
import com.capstone.service.ProductService;

@RestController
@RequestMapping("/products")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	
	@GetMapping("/category/{category}")
	public List<Product> getProductsFromCategory(@PathVariable String category){
		return productService.getProductsFromCategory(category);
		
	}
	
	 @GetMapping
	 public Map<String, Object> getProducts(
	            @RequestParam(defaultValue = "1") int page,
	            @RequestParam(defaultValue = "8") int size,
	            @RequestParam(defaultValue = "all") String category,
	            @RequestParam(required = false) String sort) {

	        List<Product> products = productService.getProductsByPage(page, size, category, sort);
	        long total = productService.getProductCount(category);

	        Map<String, Object> response = new HashMap<>();
	        response.put("products", products);
	        response.put("total", total);
	        response.put("page", page);
	        response.put("size", size);

	        return response;
	    }

}
