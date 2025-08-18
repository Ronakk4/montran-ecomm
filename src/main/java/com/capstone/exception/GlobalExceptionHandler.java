package com.capstone.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import java.util.HashMap;
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
	public ResponseEntity<Map<String, String>> handleValidationExceptions(MethodArgumentNotValidException ex) {
		System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
		Map<String, String> errors = new HashMap<>();
	    ex.getBindingResult().getFieldErrors().forEach(error ->
	        errors.put(error.getField(), error.getDefaultMessage())
	    );
	    return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
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
	public ResponseEntity<Map<String,Object>> handleConstraintViolation(javax.validation.ConstraintViolationException ex) {
		System.out.println("[EX-HANDLER] " + ex.getClass().getSimpleName() + ": " + ex.getMessage());
		Map<String,Object> errors = new HashMap<>();
	    ex.getConstraintViolations().forEach(v ->
	        errors.put(v.getPropertyPath().toString(), v.getMessage())
	    );
	    return new ResponseEntity<>(errors, HttpStatus.BAD_REQUEST);
	}


}