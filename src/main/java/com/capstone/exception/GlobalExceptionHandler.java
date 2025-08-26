package com.capstone.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ControllerAdvice
public class GlobalExceptionHandler {
	@ExceptionHandler(UserNotFoundException.class)
    public ResponseEntity<Map<String, Object>> handleUserNotFound(UserNotFoundException ex) {
		System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
        Map<String, Object> errorBody = new HashMap<>();
        errorBody.put("status", "error");
        errorBody.put("message", ex.getMessage());
        return new ResponseEntity<>(errorBody, HttpStatus.NOT_FOUND);
    }
	
	@ExceptionHandler(ProductNotFoundException.class)
    public ResponseEntity<Map<String, Object>> handleProductNotFound(ProductNotFoundException ex) {
		System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
        Map<String, Object> errorBody = new HashMap<>();
        errorBody.put("status", "error");
        errorBody.put("message", ex.getMessage());
        return new ResponseEntity<>(errorBody, HttpStatus.NOT_FOUND);
    }
	
	@ExceptionHandler(MethodArgumentNotValidException.class)
	public ResponseEntity<Map<String, Object>> handleValidationExceptions(MethodArgumentNotValidException ex) {
	    Map<String, List<String>> fieldErrors = new HashMap<>();
	    List<String> allMessages = new ArrayList<>();

	    ex.getBindingResult().getFieldErrors().forEach(error -> {
	        String field = error.getField();
	        String message = error.getDefaultMessage();
	        allMessages.add(message);
	        fieldErrors.computeIfAbsent(field, k -> new ArrayList<>()).add(message);
	    });

	    // Clean log for STS console
	    String combinedMessage = String.join(". ", allMessages) + ".";
	    System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + combinedMessage);

	    // Structured response for Postman
	    Map<String, Object> errorBody = new HashMap<>();
	    errorBody.put("status", "error");
	    errorBody.put("message", "Validation failed");
	    errorBody.put("errors", fieldErrors);

	    return new ResponseEntity<>(errorBody, HttpStatus.BAD_REQUEST);
	}
	
	@ExceptionHandler(org.springframework.http.converter.HttpMessageNotReadableException.class)
	public ResponseEntity<Map<String,Object>> handleBadJson(Exception ex) {
		System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
		Map<String,Object> body = new HashMap<>();
	    body.put("status", "error");
	    body.put("message", "Malformed JSON or wrong data types");
	    return new ResponseEntity<>(body, HttpStatus.BAD_REQUEST);
	}

	// if you ever validate @RequestParam/@PathVariable with @Validated
	@ExceptionHandler(javax.validation.ConstraintViolationException.class)
	public ResponseEntity<Map<String, Object>> handleConstraintViolation(javax.validation.ConstraintViolationException ex) {
	    Map<String, String> fieldErrors = new HashMap<>();
	    StringBuilder consoleMsg = new StringBuilder();

	    ex.getConstraintViolations().forEach(v -> {
	        String field = v.getPropertyPath().toString();
	        String message = v.getMessage();
	        fieldErrors.put(field, message);
	        consoleMsg.append(message).append("; ");
	    });

	    System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + consoleMsg.toString().trim());

	    Map<String, Object> errorBody = new HashMap<>();
	    errorBody.put("status", "error");
	    errorBody.put("message", "Validation failed");
	    errorBody.put("errors", fieldErrors);

	    return new ResponseEntity<>(errorBody, HttpStatus.BAD_REQUEST);
	}


	@ExceptionHandler(IllegalArgumentException.class)
	public ResponseEntity<Map<String, Object>> handleIllegalArgument(IllegalArgumentException ex) {
	    System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());

	    Map<String, Object> errorBody = new HashMap<>();
	    errorBody.put("status", "error");
	    errorBody.put("message", ex.getMessage());

	    return new ResponseEntity<>(errorBody, HttpStatus.BAD_REQUEST);
	}
	
	@ExceptionHandler(DuplicateEmailException.class)
	public ResponseEntity<Map<String, Object>> handleDuplicateEmail(DuplicateEmailException ex) {
	    System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
	    Map<String, Object> errorBody = new HashMap<>();
	    errorBody.put("status", "error");
	    errorBody.put("message", ex.getMessage());
	    return new ResponseEntity<>(errorBody, HttpStatus.CONFLICT); // 409 Conflict
	}

	@ExceptionHandler(DuplicateProductException.class)
	public ResponseEntity<Map<String, Object>> handleDuplicateProduct(DuplicateProductException ex) {
	    System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
	    Map<String, Object> errorBody = new HashMap<>();
	    errorBody.put("status", "error");
	    errorBody.put("message", ex.getMessage());
	    return new ResponseEntity<>(errorBody, HttpStatus.CONFLICT); // 409 Conflict
	}
	
	@ExceptionHandler(OutOfStockException.class)
	public ResponseEntity<Map<String, Object>> handleOutOfStock(OutOfStockException ex) {
	    System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
	    Map<String, Object> errorBody = new HashMap<>();
	    errorBody.put("status", "error");
	    errorBody.put("message", ex.getMessage());
	    return new ResponseEntity<>(errorBody, HttpStatus.BAD_REQUEST); // or HttpStatus.CONFLICT
	}



}