package com.capstone.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class FallbackApiController {
    @RequestMapping("/**")
    public ResponseEntity<Map<String, Object>> handleInvalidApiPath(HttpServletRequest request) {
        Map<String, Object> errorBody = new HashMap<>();
        errorBody.put("status", "error");
        errorBody.put("message", "API endpoint not found");
        return new ResponseEntity<>(errorBody, HttpStatus.NOT_FOUND);
    }
}
