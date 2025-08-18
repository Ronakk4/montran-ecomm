package com.capstone.util;
import java.security.Key;
import java.util.Date;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.JwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;


public class JwtUtil {
	// TODO Auto-generated constructor stub


    // Use a secret key (in production, store securely)
    private static final Key key = Keys.secretKeyFor(SignatureAlgorithm.HS256);

    private static final long EXPIRATION_TIME =  1000*60*30 ; // 1 hour

    public static String generateToken(String username,String userType) {
        return Jwts.builder()
                .setSubject(username)
                .setIssuer("") 
                .claim("userType", userType) 
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(key)
                .compact();
    }
    public static String getUsername(String token) {
        return validateToken(token).getBody().getSubject();
    }

   

    public static String getUserType(String token) {
        return validateToken(token).getBody().get("userType", String.class);
    }


    public static Jws<Claims> validateToken(String token)  throws JwtException{
    	
    	return Jwts.parserBuilder().setSigningKey(key).build().parseClaimsJws(token);
    	
    }
    
    
}
