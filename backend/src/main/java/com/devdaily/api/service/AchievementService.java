package com.devdaily.api.service;

import com.devdaily.api.entity.*;
import com.devdaily.api.enums.Technology;
import com.devdaily.api.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AchievementService {

    private final UserRepository userRepository;
    private final AchievementRepository achievementRepository;
    private final UserAchievementRepository userAchievementRepository;
    private final XpHistoryRepository xpHistoryRepository;
    private final HistoryRepository historyRepository;
    private final UserQuizResultRepository userQuizResultRepository;

    @Transactional
    public void unlockAchievement(Long userId, String keyName) {
        if (userAchievementRepository.existsByUserIdAndAchievementKeyName(userId, keyName)) {
            return; // Already unlocked
        }

        Optional<Achievement> achievementOpt = achievementRepository.findByKeyName(keyName);
        if (achievementOpt.isEmpty()) {
            return; // Achievement doesn't exist
        }
        Achievement achievement = achievementOpt.get();

        User user = userRepository.findById(userId).orElse(null);
        if (user == null) {
            return;
        }

        // 1. Create relation
        UserAchievement userAchievement = UserAchievement.builder()
                .user(user)
                .achievement(achievement)
                .unlockedAt(LocalDateTime.now())
                .build();
        userAchievementRepository.save(userAchievement);

        // 2. Award XP
        int xpReward = achievement.getXpReward();
        user.setDevXp(user.getDevXp() + xpReward);
        
        // Calculate new level: e.g., level = 1 + (xp / 100)
        int newLevel = 1 + (user.getDevXp() / 100);
        user.setDevLevel(newLevel);
        
        userRepository.save(user);

        // 3. Log XP History
        XpHistory xpHistory = XpHistory.builder()
                .user(user)
                .xp(xpReward)
                .reason("Logro desbloqueado: " + achievement.getTitle())
                .createdAt(LocalDateTime.now())
                .build();
        xpHistoryRepository.save(xpHistory);
    }

    @Transactional
    public void checkAndUnlockFirstRead(Long userId) {
        long count = historyRepository.countByUserId(userId);
        if (count >= 1) {
            unlockAchievement(userId, "FIRST_READ");
        }
    }

    @Transactional
    public void checkAndUnlockStreak(Long userId, int streak) {
        if (streak >= 3) {
            unlockAchievement(userId, "STREAK_3");
        }
        if (streak >= 7) {
            unlockAchievement(userId, "STREAK_7");
        }
    }

    @Transactional
    public void checkAndUnlockQuizCount(Long userId) {
        List<UserQuizResult> results = userQuizResultRepository.findByUserId(userId);
        int totalCorrect = results.stream().mapToInt(UserQuizResult::getScore).sum();
        if (totalCorrect >= 10) {
            unlockAchievement(userId, "QUIZ_10");
        }
    }

    @Transactional
    public void checkAndUnlockTechnology(Long userId, Technology tech) {
        long count = historyRepository.countByUserIdAndTechnology(userId, tech);
        if (tech == Technology.JAVA && count >= 5) {
            unlockAchievement(userId, "TECH_JAVA");
        } else if (tech == Technology.DOCKER && count >= 5) {
            unlockAchievement(userId, "TECH_DOCKER");
        }
    }
}
