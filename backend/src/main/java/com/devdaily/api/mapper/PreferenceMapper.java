package com.devdaily.api.mapper;

import com.devdaily.api.entity.UserPreference;
import com.devdaily.api.dto.preference.PreferencesResponse;
import org.springframework.stereotype.Component;

import java.util.HashSet;

@Component
public class PreferenceMapper {

    public PreferencesResponse toResponse(UserPreference preference) {
        if (preference == null) {
            return null;
        }
        PreferencesResponse response = new PreferencesResponse();
        response.setId(preference.getId());
        response.setLevel(preference.getLevel());
        response.setContentTypes(preference.getContentTypes() != null ? new HashSet<>(preference.getContentTypes()) : new HashSet<>());
        response.setAreas(preference.getAreas() != null ? new HashSet<>(preference.getAreas()) : new HashSet<>());
        response.setTechnologies(preference.getTechnologies() != null ? new HashSet<>(preference.getTechnologies()) : new HashSet<>());
        response.setUpdatedAt(preference.getUpdatedAt());
        return response;
    }
}
