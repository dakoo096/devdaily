package com.devdaily.api.dto.preference;

import com.devdaily.api.enums.Area;
import com.devdaily.api.enums.ContentType;
import com.devdaily.api.enums.Level;
import com.devdaily.api.enums.Technology;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.Set;

@Data
public class PreferencesRequest {

    @NotNull(message = "El nivel es requerido")
    private Level level;

    @NotEmpty(message = "Debes seleccionar al menos un tipo de contenido")
    private Set<ContentType> contentTypes;

    @NotEmpty(message = "Debes seleccionar al menos un área de interés")
    private Set<Area> areas;

    @NotEmpty(message = "Debes seleccionar al menos una tecnología")
    private Set<Technology> technologies;
}
