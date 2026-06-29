package com.devdaily.api.enums;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum Difficulty {
    BEGINNER("beginner"),
    INTERMEDIATE("intermediate"),
    ADVANCED("advanced");

    private final String value;

    Difficulty(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }

    @JsonCreator
    public static Difficulty fromValue(String value) {
        for (Difficulty diff : Difficulty.values()) {
            if (diff.value.equalsIgnoreCase(value) || diff.name().equalsIgnoreCase(value)) {
                return diff;
            }
        }
        throw new IllegalArgumentException("Dificultad desconocida: " + value);
    }
}
