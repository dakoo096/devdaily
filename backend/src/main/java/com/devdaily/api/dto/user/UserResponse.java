package com.devdaily.api.dto.user;

import com.devdaily.api.enums.Role;
import lombok.Data;

import java.time.LocalDateTime;
import java.time.LocalDate;

@Data
public class UserResponse {
    private Long id;
    private String name;
    private String email;
    private Role role;
    private LocalDateTime createdAt;
    private int devXp;
    private int devLevel;
    private int currentStreak;
    private int longestStreak;
    private LocalDate lastQuizDate;
}
