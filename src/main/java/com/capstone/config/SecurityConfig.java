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
	                // Public resources
	                .antMatchers("/resources/**", "/static/**", "/css/**", "/js/**", "/images/**").permitAll()
	                // Public pages
	                .antMatchers("/", "/index/**", "/home/**", "/app/login/**", "/users/**").permitAll()
	                // Public APIs
	                .antMatchers("/api/seller/category/**").permitAll()
	                .antMatchers("/app/seller-login/**").permitAll()
	                .antMatchers("/app/register/**").permitAll()
	                .antMatchers("/app/registerseller/**").permitAll()
	                .antMatchers("/app/product-list", "/app/product-list/**").permitAll() // fixed
	                // Buyer area
	                .antMatchers("/app/buyer/**").hasAuthority("buyer")
	                // Seller area
	                .antMatchers("/api/cart/**").hasAuthority("buyer")
	                .antMatchers("/app/seller/**").hasAuthority("seller")
	                .antMatchers("/app/product-details/**").permitAll()
	                // All others require authentication
	                .anyRequest().authenticated()
	            .and()
	            // Add JWT filter before UsernamePasswordAuthenticationFilter
	            .addFilterBefore(jwtAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);
	
	        return http.build();
	    }
	
	    @Bean
	    public JwtAuthenticationFilter jwtAuthenticationFilter() {
	        JwtAuthenticationFilter filter = new JwtAuthenticationFilter();
	
	        // Configure public URLs to skip
	        RequestMatcher publicUrls = new OrRequestMatcher(
	            new AntPathRequestMatcher("/"),
	            new AntPathRequestMatcher("/index/**"),
	            new AntPathRequestMatcher("/home/**"),
	            new AntPathRequestMatcher("/app/login/**"),
	            new AntPathRequestMatcher("/users/**"),
	            new AntPathRequestMatcher("/api/seller/category/**"),
	            new AntPathRequestMatcher("/resources/**"),
	            new AntPathRequestMatcher("/static/**"),
	            new AntPathRequestMatcher("/css/**"),
	            new AntPathRequestMatcher("/js/**"),
	            new AntPathRequestMatcher("/images/**"),
	            new AntPathRequestMatcher("/app/seller-login/**"),
	            new AntPathRequestMatcher("/app/register/**"),
	            new AntPathRequestMatcher("/app/registerseller/**"),
	            new AntPathRequestMatcher("/app/product-list"),          // exact path
	            new AntPathRequestMatcher("/app/product-list/**"),
	            new AntPathRequestMatcher("/"),
	            // subpaths
	            new AntPathRequestMatcher("/app/product-details/**")
	           
	        );  
	
	        filter.setSkipUrls(publicUrls);
	        return filter;
	    }
	}
