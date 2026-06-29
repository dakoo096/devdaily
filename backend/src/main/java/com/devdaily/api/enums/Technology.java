package com.devdaily.api.enums;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonValue;

public enum Technology {
    JAVA("java"),
    SPRING_BOOT("spring-boot"),
    VUE("vue"),
    REACT("react"),
    JAVASCRIPT("javascript"),
    TYPESCRIPT("typescript"),
    DOCKER("docker"),
    GIT("git"),
    MYSQL("mysql"),
    POSTGRESQL("postgresql");

    private final String value;

    Technology(String value) {
        this.value = value;
    }

    @JsonValue
    public String getValue() {
        return value;
    }

    @JsonCreator
    public static Technology fromValue(String value) {
        for (Technology tech : Technology.values()) {
            if (tech.value.equalsIgnoreCase(value) || tech.name().equalsIgnoreCase(value)) {
                return tech;
            }
        }
        throw new IllegalArgumentException("Tecnología desconocida: " + value);
    }
}
