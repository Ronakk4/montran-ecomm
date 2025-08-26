//package com.capstone.security;
//
//import com.capstone.dao.UserDao;
//import com.capstone.model.User;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.security.core.userdetails.*;
//import org.springframework.stereotype.Component;
//
//import java.util.Collections;
//
///**
// * Loads UserDetails from the database. Adjust username field as your project uses (email/username).
// * This implementation expects UserDao.findUserByEmail(email) or findUserBy... as available in your DAO.
// */
//@Component
//public class CustomUserDetailsService implements UserDetailsService {
//
//    @Autowired
//    private UserDao userDao; // your DAO implementation (UserDaoImpl)
//
//    @Override
//    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//        // In your project the field may be email; adapt as needed (you have findUserByEmail in DAO impl)
//        User user = userDao.findUserByEmail(username);
//        if (user == null) {
//            throw new UsernameNotFoundException("User not found: " + username);
//        }
//
//        // Use email as username if your login uses email
//        return User.withUsername(user.getEmail())
//                .password(user.getPassword())   // DB-stored hash (BCrypt)
//                .authorities(new SimpleGrantedAuthority(user.getRole() == null ? "ROLE_USER" : user.getRole()))
//                .build();
//    }
//}