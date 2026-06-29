package com.devdaily.api.repository;

import com.devdaily.api.entity.Achievement;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AchievementRepository extends JpaRepository<Achievement, Long> {
    Optional<Achievement> findByKeyName(String keyName);
}
