package com.capstone.util;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import java.util.Base64;
import java.util.Date;
import java.security.Key;

public class JwtUtil {

    // Use a fixed secret key (should be stored securely in production)
    private static final String SECRET = "ThisIsASecretKeyForJwtSigningAndItShouldBeLongEnough123!";
    private static final Key key = Keys.hmacShaKeyFor(SECRET.getBytes());

    private static final long EXPIRATION_TIME = 1000 * 60 * 30; // 30 minutes

    public static String generateToken(String username, String userType, Long userId) {
        return Jwts.builder()
                .setSubject(username)
                .setIssuer("")
                .claim("userType", userType)
                .claim("userId", userId)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(key)
                .compact();
    }

    public static Jws<Claims> validateToken(String token) {
        return Jwts.parserBuilder()
                   .setSigningKey(key)
                   .build()
                   .parseClaimsJws(token);
    }

    public static Long getId(String token) {
        return validateToken(token).getBody().get("userId", Long.class);
    }

    public static String getUserType(String token) {
        return validateToken(token).getBody().get("userType", String.class);
    }

    public static String getUsername(String token) {
        return validateToken(token).getBody().getSubject();
    }
}
