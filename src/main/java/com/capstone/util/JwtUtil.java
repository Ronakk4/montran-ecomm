//package com.capstone.util;
//import java.security.Key;
//import java.util.Date;
//
//import io.jsonwebtoken.Claims;
//import io.jsonwebtoken.Jws;
//import io.jsonwebtoken.JwtException;
//import io.jsonwebtoken.Jwts;
//import io.jsonwebtoken.SignatureAlgorithm;
//import io.jsonwebtoken.security.Keys;
//
//
//public class JwtUtil {
//	// TODO Auto-generated constructor stub
//
//
//    // Use a secret key (in production, store securely)
//    private static final Key key = Keys.secretKeyFor(SignatureAlgorithm.HS256);
//
//    private static final long EXPIRATION_TIME = 1000 * 60 * 60; // 1 hour
//
//    public static String generateToken(String username) {
//        return Jwts.builder()
//                .setSubject(username)
//                .setIssuer("")
//                .setIssuedAt(new Date())
//                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
//                .signWith(key)
//                .compact();
//    }
//
//
//    public static Jws<Claims> validateToken(String token)  throws JwtException{
//    	
//    	return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token);
//    	
//    }
//}



//package com.capstone.util;
//
//import java.util.Date;
//import java.util.HashMap;
//import java.util.Map;
//
//import javax.crypto.spec.SecretKeySpec;
//import javax.xml.bind.DatatypeConverter;
//import java.security.Key;
//
//// Note: For a full JWT implementation, you would typically use a library like jjwt
//// This is a simplified version for basic token generation
//public class JwtUtil {
//    
//    private static final String SECRET_KEY = "mySecretKey123456789"; // In production, use environment variable
//    private static final long EXPIRATION_TIME = 86400000; // 24 hours in milliseconds
//    
//    public static String generateToken(String email) {
//        // In a real implementation, you would use a proper JWT library
//        // For now, creating a simple token format
//        long currentTime = System.currentTimeMillis();
//        long expirationTime = currentTime + EXPIRATION_TIME;
//        
//        // Simple token format: email:currentTime:expirationTime:hash
//        String tokenData = email + ":" + currentTime + ":" + expirationTime;
//        String hash = generateHash(tokenData);
//        
//        return tokenData + ":" + hash;
//    }
//    
//    public static boolean validateToken(String token) {
//        try {
//            String[] parts = token.split(":");
//            if (parts.length != 4) {
//                return false;
//            }
//            
//            String email = parts[0];
//            long currentTime = Long.parseLong(parts[1]);
//            long expirationTime = Long.parseLong(parts[2]);
//            String hash = parts[3];
//            
//            // Check if token is expired
//            if (System.currentTimeMillis() > expirationTime) {
//                return false;
//            }
//            
//            // Validate hash
//            String expectedHash = generateHash(email + ":" + currentTime + ":" + expirationTime);
//            return hash.equals(expectedHash);
//            
//        } catch (Exception e) {
//            return false;
//        }
//    }
//    
//    public static String extractEmail(String token) {
//        try {
//            String[] parts = token.split(":");
//            return parts[0];
//        } catch (Exception e) {
//            return null;
//        }
//    }
//    
//    private static String generateHash(String data) {
//        try {
//            // Simple hash generation - in production, use proper HMAC
//            return Integer.toHexString((data + SECRET_KEY).hashCode());
//        } catch (Exception e) {
//            return "";
//        }
//    }
//}


//package com.capstone.util;
//
//import io.jsonwebtoken.Claims;
//import io.jsonwebtoken.Jws;
//import io.jsonwebtoken.Jwts;
//import io.jsonwebtoken.SignatureAlgorithm;
//import io.jsonwebtoken.security.Keys;
//
//import java.security.Key;
//import java.util.Date;
//
//public class JwtUtil {
//
//    // Ideally load from application properties or env variable
//    private static final String SECRET = "my-super-secret-key-my-super-secret-key"; 
//    private static final Key key = Keys.hmacShaKeyFor(SECRET.getBytes());
//
//    private static final long EXPIRATION_TIME = 1000 * 60 * 60; // 1 hour
//
//    // Generate a JWT token
//    public static String generateToken(String subject, String role) {
//        return Jwts.builder()
//                .setSubject(subject) // usually user email/username
//                .claim("role", role)
//                .setIssuedAt(new Date())
//                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
//                .signWith(key, SignatureAlgorithm.HS256)
//                .compact();
//    }
//
//    // Validate token and return Claims
//    public static Jws<Claims> validateToken(String token) {
//        return Jwts.parserBuilder()
//                .setSigningKey(key)
//                .build()
//                .parseClaimsJws(token);  // if invalid, throws an exception
//    }
//
//    // Extract username (subject) from token
//    public static String getUsername(String token) {
//        return validateToken(token).getBody().getSubject();
//    }
//
//    // Extract role from token
//    public static String getRole(String token) {
//        return validateToken(token).getBody().get("role", String.class);
//    }
//}


package com.capstone.util;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;
import java.security.Key;

// Note: For a full JWT implementation, you would typically use a library like jjwt
// This is a simplified version for basic token generation
public class JwtUtil {
    
    private static final String SECRET_KEY = "mySecretKey123456789"; // In production, use environment variable
    private static final long EXPIRATION_TIME = 86400000; // 24 hours in milliseconds
    
    public static String generateToken(String email) {
        // In a real implementation, you would use a proper JWT library
        // For now, creating a simple token format
        long currentTime = System.currentTimeMillis();
        long expirationTime = currentTime + EXPIRATION_TIME;
        
        // Simple token format: email:currentTime:expirationTime:hash
        String tokenData = email + ":" + currentTime + ":" + expirationTime;
        String hash = generateHash(tokenData);
        
        return tokenData + ":" + hash;
    }
    
    public static boolean validateToken(String token) {
        try {
            String[] parts = token.split(":");
            if (parts.length != 4) {
                return false;
            }
            
            String email = parts[0];
            long currentTime = Long.parseLong(parts[1]);
            long expirationTime = Long.parseLong(parts[2]);
            String hash = parts[3];
            
            // Check if token is expired
            if (System.currentTimeMillis() > expirationTime) {
                return false;
            }
            
            // Validate hash
            String expectedHash = generateHash(email + ":" + currentTime + ":" + expirationTime);
            return hash.equals(expectedHash);
            
        } catch (Exception e) {
            return false;
        }
    }
    
    public static String extractEmail(String token) {
        try {
            String[] parts = token.split(":");
            return parts[0];
        } catch (Exception e) {
            return null;
        }
    }
    
    private static String generateHash(String data) {
        try {
            // Simple hash generation - in production, use proper HMAC
            return Integer.toHexString((data + SECRET_KEY).hashCode());
        } catch (Exception e) {
            return "";
        }
    }
}