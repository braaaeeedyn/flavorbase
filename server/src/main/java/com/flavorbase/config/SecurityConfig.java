package com.flavorbase.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(authz -> authz
                .requestMatchers("/actuator/**").permitAll()  // Allow health checks
                .requestMatchers("/h2-console/**").permitAll()  // Allow H2 console access
                .anyRequest().authenticated()
            )
            .csrf(csrf -> csrf
                .ignoringRequestMatchers("/h2-console/**")  // Disable CSRF for H2 console
            )
            .headers(headers -> headers
                .frameOptions().sameOrigin()  // Allow H2 console frames
            )
            .formLogin(form -> form
                .defaultSuccessUrl("/h2-console", true)  // Redirect to H2 console after login
            );

        return http.build();
    }
}
