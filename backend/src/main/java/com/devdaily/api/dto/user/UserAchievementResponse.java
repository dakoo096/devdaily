package com.devdaily.api.dto.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserAchievementResponse {
    private String keyName;
    private String title;
    private String description;
    private int xpReward;
    private boolean unlocked;
    private LocalDateTime unlockedAt;
}
