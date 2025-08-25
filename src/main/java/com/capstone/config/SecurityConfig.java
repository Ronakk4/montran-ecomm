package com.capstone.config;

import com.capstone.filter.JwtAuthenticationFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf().disable()
            .authorizeRequests()
                // ✅ allow static resources
                .antMatchers("/resources/**", "/static/**", "/css/**", "/js/**", "/images/**").permitAll()

                // ✅ homepage + login + users (prefix matching)
                .antMatchers("/", "/index/**", "/home/**", "/app/login/**", "/users/**").permitAll()

                // ✅ public APIs
                .antMatchers("/api/seller/category/**").permitAll()

                // ✅ buyer area
                .antMatchers("/app/buyer/**").hasAuthority("buyer")

                // ✅ seller area
                .antMatchers("/app/seller/**").hasAuthority("seller")

                // ✅ everything else requires authentication
                .anyRequest().authenticated()
            .and()
            // add JWT filter
            .addFilterBefore(new JwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }
}
