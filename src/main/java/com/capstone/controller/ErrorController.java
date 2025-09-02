package com.capstone.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController {
    @RequestMapping("/errors") 
    public String handleError(HttpServletRequest request) {
        // optionally log status code
        Integer statusCode = (Integer) request.getAttribute("javax.servlet.error.status_code");
        return "errors";  // resolves to /WEB-INF/views/errors.jsp
    }
}
