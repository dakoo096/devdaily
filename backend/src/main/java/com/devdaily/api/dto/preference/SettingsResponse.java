package com.devdaily.api.dto.preference;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class SettingsResponse {
    private Long id;
    private boolean darkMode;
    private boolean notificationsEnabled;
    private String notificationTime;
    private LocalDateTime updatedAt;
}
