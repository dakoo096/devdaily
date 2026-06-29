package com.devdaily.api.service;

import com.devdaily.api.dto.preference.PreferencesRequest;
import com.devdaily.api.dto.preference.PreferencesResponse;
import com.devdaily.api.dto.preference.SettingsRequest;
import com.devdaily.api.dto.preference.SettingsResponse;
import com.devdaily.api.dto.user.UpdateProfileRequest;
import com.devdaily.api.dto.user.UserResponse;
import com.devdaily.api.dto.user.UserStatsResponse;
import com.devdaily.api.entity.User;
import com.devdaily.api.entity.UserPreference;
import com.devdaily.api.entity.UserSetting;
import com.devdaily.api.exception.ResourceNotFoundException;
import com.devdaily.api.mapper.PreferenceMapper;
import com.devdaily.api.mapper.SettingMapper;
import com.devdaily.api.mapper.UserMapper;
import com.devdaily.api.repository.FavoriteRepository;
import com.devdaily.api.repository.HistoryRepository;
import com.devdaily.api.repository.UserPreferenceRepository;
import com.devdaily.api.repository.UserSettingRepository;
import com.devdaily.api.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final UserPreferenceRepository userPreferenceRepository;
    private final UserSettingRepository userSettingRepository;
    private final FavoriteRepository favoriteRepository;
    private final HistoryRepository historyRepository;

    private final UserMapper userMapper;
    private final PreferenceMapper preferenceMapper;
    private final SettingMapper settingMapper;

    @Transactional(readOnly = true)
    public UserResponse getUserProfile(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));
        return userMapper.toResponse(user);
    }

    @Transactional
    public UserResponse updateProfile(Long userId, UpdateProfileRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));
        user.setName(request.getName());
        user.setEmail(request.getEmail());
        userRepository.save(user);
        return userMapper.toResponse(user);
    }

    @Transactional(readOnly = true)
    public PreferencesResponse getPreferences(Long userId) {
        java.util.List<UserPreference> preferences = userPreferenceRepository.findByUserId(userId);
        if (preferences.isEmpty()) {
            throw new ResourceNotFoundException("Preferencias no encontradas");
        }
        return preferenceMapper.toResponse(preferences.get(0));
    }

    @Transactional
    public PreferencesResponse updatePreferences(Long userId, PreferencesRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));

        java.util.List<UserPreference> preferences = userPreferenceRepository.findByUserId(userId);
        UserPreference preference = preferences.isEmpty() ?
                UserPreference.builder().user(user).build() : preferences.get(0);

        preference.setLevel(request.getLevel());
        preference.setAreas(request.getAreas());
        preference.setTechnologies(request.getTechnologies());
        preference.setContentTypes(request.getContentTypes());
        preference.setUpdatedAt(LocalDateTime.now());

        userPreferenceRepository.save(preference);
        return preferenceMapper.toResponse(preference);
    }

    @Transactional(readOnly = true)
    public SettingsResponse getSettings(Long userId) {
        UserSetting setting = userSettingRepository.findByUserId(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Configuraciones no encontradas"));
        return settingMapper.toResponse(setting);
    }

    @Transactional
    public SettingsResponse updateSettings(Long userId, SettingsRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));

        UserSetting setting = userSettingRepository.findByUserId(userId)
                .orElseGet(() -> UserSetting.builder().user(user).build());

        setting.setDarkMode(request.getDarkMode());
        setting.setNotificationsEnabled(request.getNotificationsEnabled());
        setting.setNotificationTime(request.getNotificationTime());
        setting.setUpdatedAt(LocalDateTime.now());

        userSettingRepository.save(setting);
        return settingMapper.toResponse(setting);
    }

    @Transactional(readOnly = true)
    public UserStatsResponse getUserStats(Long userId) {
        if (!userRepository.existsById(userId)) {
            throw new ResourceNotFoundException("Usuario no encontrado");
        }

        long daysActive = historyRepository.countDistinctDaysActive(userId);
        long favorites = favoriteRepository.countByUserId(userId);
        long contentsRead = historyRepository.countByUserId(userId);

        return UserStatsResponse.builder()
                .daysActive(daysActive)
                .favorites(favorites)
                .contentsRead(contentsRead)
                .build();
    }
}
