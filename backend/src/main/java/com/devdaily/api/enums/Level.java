package com.devdaily.api.enums;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum Level {
    STUDENT("student"),
    JUNIOR("junior"),
    SEMI_SENIOR("semi-senior"),
    SENIOR("senior");

    private final String value;

    Level(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }

    @JsonCreator
    public static Level fromValue(String value) {
        for (Level level : Level.values()) {
            if (level.value.equalsIgnoreCase(value) || level.name().equalsIgnoreCase(value)) {
                return level;
            }
        }
        throw new IllegalArgumentException("Nivel desconocido: " + value);
    }
}
