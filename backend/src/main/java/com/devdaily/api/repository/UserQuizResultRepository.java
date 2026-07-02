package com.devdaily.api.repository;

import com.devdaily.api.entity.UserQuizResult;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserQuizResultRepository extends JpaRepository<UserQuizResult, Long> {
    Optional<UserQuizResult> findByUserIdAndQuizId(Long userId, Long quizId);
    List<UserQuizResult> findByUserId(Long userId);
    long countByUserId(Long userId);
}
