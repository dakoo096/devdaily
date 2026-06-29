package com.devdaily.api.dto.preference;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class SettingsRequest {

    @NotNull(message = "El modo oscuro es requerido")
    private Boolean darkMode;

    @NotNull(message = "El estado de notificaciones es requerido")
    private Boolean notificationsEnabled;

    @NotBlank(message = "La hora de notificación es requerida")
    @Pattern(regexp = "^([01]?[0-9]|2[0-3]):[0-5][0-9]$", message = "La hora debe tener formato HH:mm")
    private String notificationTime;
}
