package com.devdaily.api.dto.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserStatsResponse {
    private long daysActive;
    private long favorites;
    private long contentsRead;
    private long quizzesCompleted;
    private int accuracy;
    private int longestStreak;
    private int level;
    private int xp;
}
