package com.devdaily.api.dto.auth;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SocialLoginRequest {

    @NotBlank(message = "El nombre es requerido")
    private String name;

    @NotBlank(message = "El correo electrónico es requerido")
    @Email(message = "El formato de correo electrónico es inválido")
    private String email;

    @NotBlank(message = "El proveedor es requerido")
    private String provider; // "google" o "facebook"

    @NotBlank(message = "El ID del proveedor es requerido")
    private String providerId;
}
