package com.capstone.config;

import com.capstone.filter.JwtAuthenticationFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.OrRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .csrf().disable()
            .authorizeRequests()
                // static resources
                .antMatchers("/resources/**", "/static/**", "/css/**", "/js/**", "/images/**").permitAll()

                // root and jsp landing pages
                .antMatchers("/", "/*.jsp").permitAll()

                // all InitialController endpoints (public)
                .antMatchers(
                        "/app/login/**",
                        "/app/home/**",
                        "/app/register/**",
                        "/app/registerseller/**",
                        "/app/seller-login/**",
                        "/app/login/products/**",
                        "/app/orders/**",
                        "/app/product-details/**",
                        "/app/product-list/**"
                ).permitAll()

                // public APIs
                .antMatchers("/api/seller/category/**", "/users/**").permitAll()

                // buyer area
                .antMatchers("/app/buyer/**").hasAuthority("buyer")

                // seller area
                .antMatchers("/app/seller/**").hasAuthority("seller")

                // everything else requires authentication
                .anyRequest().authenticated()
            .and()
            // add JWT filter
            .addFilterBefore(jwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);

        return http.build();
    }

    @Bean
    public JwtAuthenticationFilter jwtAuthenticationFilter() {
        JwtAuthenticationFilter filter = new JwtAuthenticationFilter();

        // configure public URLs to skip JWT filter
        RequestMatcher publicUrls = new OrRequestMatcher(
            new AntPathRequestMatcher("/"),
            new AntPathRequestMatcher("/*.jsp"),
            new AntPathRequestMatcher("/resources/**"),
            new AntPathRequestMatcher("/static/**"),
            new AntPathRequestMatcher("/css/**"),
            new AntPathRequestMatcher("/js/**"),
            new AntPathRequestMatcher("/images/**"),

            // controller mappings
            new AntPathRequestMatcher("/app/login/**"),
            new AntPathRequestMatcher("/app/home/**"),
            new AntPathRequestMatcher("/app/register/**"),
            new AntPathRequestMatcher("/app/registerseller/**"),
            new AntPathRequestMatcher("/app/seller-login/**"),
            new AntPathRequestMatcher("/app/login/products/**"),
            new AntPathRequestMatcher("/app/orders/**"),
            new AntPathRequestMatcher("/app/product-details/**"),
            new AntPathRequestMatcher("/app/product-list/**"),

            // APIs
            new AntPathRequestMatcher("/api/seller/category/**"),
            new AntPathRequestMatcher("/users/**")
        );

        filter.setSkipUrls(publicUrls);
        return filter;
    }
}