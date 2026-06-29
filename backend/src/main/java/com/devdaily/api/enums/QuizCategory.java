package com.devdaily.api.enums;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum QuizCategory {
    CONCEPTO("Concepto"),
    ENCUENTRA_EL_ERROR("Encuentra el error"),
    QUE_IMPRIME("¿Qué imprime?"),
    BUENAS_PRACTICAS("Buenas prácticas"),
    ENTREVISTA("Pregunta de entrevista");

    private final String value;

    QuizCategory(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }

    @JsonCreator
    public static QuizCategory fromValue(String value) {
        for (QuizCategory cat : QuizCategory.values()) {
            if (cat.value.equalsIgnoreCase(value) || cat.name().equalsIgnoreCase(value)) {
                return cat;
            }
        }
        throw new IllegalArgumentException("Categoría de quiz desconocida: " + value);
    }
}
