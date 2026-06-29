package com.devdaily.api.repository;

import com.devdaily.api.entity.UserSetting;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface UserSettingRepository extends JpaRepository<UserSetting, Long> {
    Optional<UserSetting> findByUserId(Long userId);
}
