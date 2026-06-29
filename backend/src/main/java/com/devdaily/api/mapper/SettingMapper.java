package com.devdaily.api.mapper;

import com.devdaily.api.entity.UserSetting;
import com.devdaily.api.dto.preference.SettingsResponse;
import org.springframework.stereotype.Component;

@Component
public class SettingMapper {

    public SettingsResponse toResponse(UserSetting setting) {
        if (setting == null) {
            return null;
        }
        SettingsResponse response = new SettingsResponse();
        response.setId(setting.getId());
        response.setDarkMode(setting.isDarkMode());
        response.setNotificationsEnabled(setting.isNotificationsEnabled());
        response.setNotificationTime(setting.getNotificationTime());
        response.setUpdatedAt(setting.getUpdatedAt());
        return response;
    }
}
