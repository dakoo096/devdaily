package com.devdaily.api.enums;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum Area {
    FRONTEND("frontend"),
    BACKEND("backend"),
    DATABASES("databases"),
    UIUX("uiux"),
    DEVOPS("devops"),
    TESTING("testing"),
    CYBERSECURITY("cybersecurity"),
    MOBILE("mobile");

    private final String value;

    Area(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }

    @JsonCreator
    public static Area fromValue(String value) {
        for (Area area : Area.values()) {
            if (area.value.equalsIgnoreCase(value) || area.name().equalsIgnoreCase(value)) {
                return area;
            }
        }
        throw new IllegalArgumentException("Área desconocida: " + value);
    }
}
