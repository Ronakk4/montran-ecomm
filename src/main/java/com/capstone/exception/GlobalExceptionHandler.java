//package com.capstone.exception;
//
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.MethodArgumentNotValidException;
//import org.springframework.web.bind.annotation.ControllerAdvice;
//import org.springframework.web.bind.annotation.ExceptionHandler;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@ControllerAdvice
//public class GlobalExceptionHandler {
//	@ExceptionHandler(UserNotFoundException.class)
//    public ResponseEntity<Map<String, Object>> handleUserNotFound(UserNotFoundException ex) {
//		System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
//        Map<String, Object> errorBody = new HashMap<>();
//        errorBody.put("status", "error");
//        errorBody.put("message", ex.getMessage());
//        return new ResponseEntity<>(errorBody, HttpStatus.NOT_FOUND);
//    }
//	
//
//	@ExceptionHandler(ProductNotFoundException.class)
//    public ResponseEntity<Map<String, Object>> handleProductNotFound(ProductNotFoundException ex) {
//		System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
//        Map<String, Object> errorBody = new HashMap<>();
//        errorBody.put("status", "error");
//        errorBody.put("message", ex.getMessage());
//        return new ResponseEntity<>(errorBody, HttpStatus.NOT_FOUND);
//    }
//	
//	@ExceptionHandler(MethodArgumentNotValidException.class)
//	public ResponseEntity<Map<String, Object>> handleValidationExceptions(MethodArgumentNotValidException ex) {
//	    Map<String, List<String>> fieldErrors = new HashMap<>();
//	    List<String> allMessages = new ArrayList<>();
//
//	    ex.getBindingResult().getFieldErrors().forEach(error -> {
//	        String field = error.getField();
//	        String message = error.getDefaultMessage();
//	        allMessages.add(message);
//	        fieldErrors.computeIfAbsent(field, k -> new ArrayList<>()).add(message);
//	    });
//
//	    // Clean log for STS console
//	    String combinedMessage = String.join(". ", allMessages) + ".";
//	    System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + combinedMessage);
//
//	    // Structured response for Postman
//	    Map<String, Object> errorBody = new HashMap<>();
//	    errorBody.put("status", "error");
//	    errorBody.put("message", "Validation failed");
//	    errorBody.put("errors", fieldErrors);
//
//	    return new ResponseEntity<>(errorBody, HttpStatus.BAD_REQUEST);
//	}
//	
//	@ExceptionHandler(org.springframework.http.converter.HttpMessageNotReadableException.class)
//	public ResponseEntity<Map<String,Object>> handleBadJson(Exception ex) {
//		System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
//		Map<String,Object> body = new HashMap<>();
//	    body.put("status", "error");
//	    body.put("message", "Malformed JSON or wrong data types");
//	    return new ResponseEntity<>(body, HttpStatus.BAD_REQUEST);
//	}
//
//	// if you ever validate @RequestParam/@PathVariable with @Validated
//	@ExceptionHandler(javax.validation.ConstraintViolationException.class)
//	public ResponseEntity<Map<String, Object>> handleConstraintViolation(javax.validation.ConstraintViolationException ex) {
//	    Map<String, String> fieldErrors = new HashMap<>();
//	    StringBuilder consoleMsg = new StringBuilder();
//
//	    ex.getConstraintViolations().forEach(v -> {
//	        String field = v.getPropertyPath().toString();
//	        String message = v.getMessage();
//	        fieldErrors.put(field, message);
//	        consoleMsg.append(message).append("; ");
//	    });
//
//	    System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + consoleMsg.toString().trim());
//
//	    Map<String, Object> errorBody = new HashMap<>();
//	    errorBody.put("status", "error");
//	    errorBody.put("message", "Validation failed");
//	    errorBody.put("errors", fieldErrors);
//
//	    return new ResponseEntity<>(errorBody, HttpStatus.BAD_REQUEST);
//	}
//
//
//	@ExceptionHandler(IllegalArgumentException.class)
//	public ResponseEntity<Map<String, Object>> handleIllegalArgument(IllegalArgumentException ex) {
//	    System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
//
//	    Map<String, Object> errorBody = new HashMap<>();
//	    errorBody.put("status", "error");
//	    errorBody.put("message", ex.getMessage());
//
//	    return new ResponseEntity<>(errorBody, HttpStatus.BAD_REQUEST);
//	}
//	
//	@ExceptionHandler(DuplicateEmailException.class)
//	public ResponseEntity<Map<String, Object>> handleDuplicateEmail(DuplicateEmailException ex) {
//	    System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
//	    Map<String, Object> errorBody = new HashMap<>();
//	    errorBody.put("status", "error");
//	    errorBody.put("message", ex.getMessage());
//	    return new ResponseEntity<>(errorBody, HttpStatus.CONFLICT); // 409 Conflict
//	}
//
//	@ExceptionHandler(DuplicateProductException.class)
//	public ResponseEntity<Map<String, Object>> handleDuplicateProduct(DuplicateProductException ex) {
//	    System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
//	    Map<String, Object> errorBody = new HashMap<>();
//	    errorBody.put("status", "error");
//	    errorBody.put("message", ex.getMessage());
//	    return new ResponseEntity<>(errorBody, HttpStatus.CONFLICT); // 409 Conflict
//	}
//	
//	@ExceptionHandler(OutOfStockException.class)
//	public ResponseEntity<Map<String, Object>> handleOutOfStock(OutOfStockException ex) {
//	    System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
//	    Map<String, Object> errorBody = new HashMap<>();
//	    errorBody.put("status", "error");
//	    errorBody.put("message", ex.getMessage());
//	    return new ResponseEntity<>(errorBody, HttpStatus.BAD_REQUEST); // or HttpStatus.CONFLICT
//	}
//
//
//
//}

package com.capstone.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.validation.ConstraintViolationException;
import java.util.*;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Throwable.class)
    public Object handleAllExceptions(Throwable ex, HttpServletRequest request) {
        // Log cleanly for developers
        System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());

        // 1. If it's an API call (JSON expected)
        if (isApiRequest(request)) {
            Map<String, Object> errorBody = new HashMap<>();
            errorBody.put("status", "error");
            
            HttpStatus status = HttpStatus.INTERNAL_SERVER_ERROR; // default
            String userMessage = "Something went wrong. Please try again later.";

            if (ex instanceof UserNotFoundException || ex instanceof ProductNotFoundException) {
                status = HttpStatus.NOT_FOUND;
                userMessage = ex.getMessage();
            } 
            else if (ex instanceof DuplicateEmailException || ex instanceof DuplicateProductException) {
                status = HttpStatus.CONFLICT;
                userMessage = ex.getMessage();
            } 
            else if (ex instanceof OutOfStockException) {
                status = HttpStatus.BAD_REQUEST;
                userMessage = ex.getMessage();
            } 
            else if (ex instanceof IllegalArgumentException) {
                status = HttpStatus.BAD_REQUEST;
                userMessage = ex.getMessage();
            }
            else if (ex instanceof MethodArgumentNotValidException) {
                status = HttpStatus.BAD_REQUEST;
                errorBody.put("message", "Validation failed");
                errorBody.put("errors", extractFieldErrors((MethodArgumentNotValidException) ex));
                return new ResponseEntity<>(errorBody, status);
            }
            else if (ex instanceof ConstraintViolationException) {
                status = HttpStatus.BAD_REQUEST;
                errorBody.put("message", "Validation failed");
                errorBody.put("errors", extractConstraintErrors((ConstraintViolationException) ex));
                return new ResponseEntity<>(errorBody, status);
            }
            else if (ex instanceof org.springframework.http.converter.HttpMessageNotReadableException) {
                status = HttpStatus.BAD_REQUEST;
                userMessage = "Malformed JSON or wrong data types";
            }

            // Default clean response
            errorBody.put("message", userMessage);
            return new ResponseEntity<>(errorBody, status);
        }

        // 2. If it's a browser call (JSP expected)
        ModelAndView mav = new ModelAndView("errors"); // JSP: /WEB-INF/views/errors.jsp
        mav.addObject("errorType", ex.getClass().getSimpleName());
        mav.addObject("errorMessage", formatMessageForUI(ex));
        return mav;
    }

    // Helper to detect if request is API call (e.g., URL starts with /api or Accept header is JSON)
//    private boolean isApiRequest(HttpServletRequest request) {
//        String uri = request.getRequestURI();
//        String accept = request.getHeader("Accept");
//        return (uri.startsWith("/api") || (accept != null && accept.contains("application/json")));
//    }
    
    private boolean isApiRequest(HttpServletRequest request) {
        String uri = request.getRequestURI();
        String accept = request.getHeader("Accept");
        String contentType = request.getHeader("Content-Type");

        // If URL starts with /api → always JSON
        if (uri.startsWith(request.getContextPath() + "/api") || uri.startsWith("/api")) {
            return true;
        }

        // If request explicitly asks for JSON → JSON
        if (accept != null && accept.contains("application/json")) {
            return true;
        }

        // If content is being sent as JSON → treat as API
        if (contentType != null && contentType.contains("application/json")) {
            return true;
        }

        return false; // Default to JSP for browser
    }


    // Helper for @Valid binding errors
    private Map<String, List<String>> extractFieldErrors(MethodArgumentNotValidException ex) {
        Map<String, List<String>> fieldErrors = new HashMap<>();
        ex.getBindingResult().getFieldErrors().forEach(error -> {
            fieldErrors.computeIfAbsent(error.getField(), k -> new ArrayList<>())
                       .add(error.getDefaultMessage());
        });
        return fieldErrors;
    }

    // Helper for @Validated path/query param errors
    private Map<String, String> extractConstraintErrors(ConstraintViolationException ex) {
        Map<String, String> fieldErrors = new HashMap<>();
        ex.getConstraintViolations().forEach(v -> {
            fieldErrors.put(v.getPropertyPath().toString(), v.getMessage());
        });
        return fieldErrors;
    }

    // Format clean message for JSP view
    private String formatMessageForUI(Throwable ex) {
        if (ex.getMessage() != null && !ex.getMessage().isEmpty()) {
            return ex.getMessage();
        }
        return "An unexpected error occurred. Please contact support.";
    }
}
