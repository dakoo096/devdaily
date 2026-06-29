package com.devdaily.api.repository;

import com.devdaily.api.entity.UserAchievement;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserAchievementRepository extends JpaRepository<UserAchievement, Long> {
    List<UserAchievement> findByUserId(Long userId);
    boolean existsByUserIdAndAchievementId(Long userId, Long achievementId);
    boolean existsByUserIdAndAchievementKeyName(Long userId, String keyName);
}
