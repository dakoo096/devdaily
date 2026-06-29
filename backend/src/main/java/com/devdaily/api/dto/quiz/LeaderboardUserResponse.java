package com.devdaily.api.dto.quiz;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LeaderboardUserResponse {
    private Long id;
    private String name;
    private int points;
    private int currentStreak;
}
