package com.devdaily.api.service;

import com.devdaily.api.dto.auth.AuthResponse;
import com.devdaily.api.dto.auth.LoginRequest;
import com.devdaily.api.dto.auth.RegisterRequest;
import com.devdaily.api.entity.User;
import com.devdaily.api.enums.Role;
import com.devdaily.api.exception.BadRequestException;
import com.devdaily.api.repository.UserPreferenceRepository;
import com.devdaily.api.repository.UserRepository;
import com.devdaily.api.security.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final AuthenticationManager authenticationManager;
    private final UserRepository userRepository;
    private final UserPreferenceRepository userPreferenceRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider tokenProvider;

    @Transactional
    public AuthResponse login(LoginRequest loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.getEmail(),
                        loginRequest.getPassword()
                )
        );

        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = tokenProvider.generateToken(authentication);

        User user = userRepository.findByEmail(loginRequest.getEmail())
                .orElseThrow(() -> new BadRequestException("Credenciales inválidas"));

        user.setLastLogin(LocalDateTime.now());
        userRepository.save(user);

        boolean onboardingCompleted = !userPreferenceRepository.findByUserId(user.getId()).isEmpty();

        return AuthResponse.builder()
                .token(jwt)
                .id(user.getId())
                .name(user.getName())
                .email(user.getEmail())
                .role(user.getRole())
                .onboardingCompleted(onboardingCompleted)
                .build();
    }

    @Transactional
    public AuthResponse register(RegisterRequest registerRequest) {
        if (userRepository.existsByEmail(registerRequest.getEmail())) {
            throw new BadRequestException("El correo electrónico ya está registrado");
        }

        Role targetRole = Role.USER;
        if (registerRequest.getRole() != null) {
            if (registerRequest.getRole() == Role.ADMIN) {
                Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                boolean isAdmin = auth != null && auth.isAuthenticated() &&
                        auth.getAuthorities().stream()
                                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));
                if (!isAdmin) {
                    throw new BadRequestException("Solo un administrador puede registrar usuarios con el rol ADMIN.");
                }
                targetRole = Role.ADMIN;
            } else {
                targetRole = registerRequest.getRole();
            }
        }

        User user = User.builder()
                .name(registerRequest.getName())
                .email(registerRequest.getEmail())
                .password(passwordEncoder.encode(registerRequest.getPassword()))
                .role(targetRole)
                .build();

        userRepository.save(user);

        // Autenticar automáticamente al registrar
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        registerRequest.getEmail(),
                        registerRequest.getPassword()
                )
        );

        SecurityContextHolder.getContext().setAuthentication(authentication);
        String jwt = tokenProvider.generateToken(authentication);

        return AuthResponse.builder()
                .token(jwt)
                .id(user.getId())
                .name(user.getName())
                .email(user.getEmail())
                .role(user.getRole())
                .onboardingCompleted(false) // Al registrarse no tiene preferencias aún
                .build();
    }
}
