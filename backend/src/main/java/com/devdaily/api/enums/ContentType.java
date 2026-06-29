package com.devdaily.api.enums;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum ContentType {
    TIP("tip"),
    CURIOSITY("curiosity"),
    PHRASE("phrase"),
    CONCEPT("concept"),
    QUESTION("question"),
    SHORTCUT("shortcut");

    private final String value;

    ContentType(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }

    @JsonCreator
    public static ContentType fromValue(String value) {
        for (ContentType type : ContentType.values()) {
            if (type.value.equalsIgnoreCase(value) || type.name().equalsIgnoreCase(value)) {
                return type;
            }
        }
        throw new IllegalArgumentException("Tipo de contenido desconocido: " + value);
    }
}
