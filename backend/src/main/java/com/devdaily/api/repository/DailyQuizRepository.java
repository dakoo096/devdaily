package com.devdaily.api.repository;

import com.devdaily.api.entity.DailyQuiz;
import com.devdaily.api.enums.Difficulty;
import org.springframework.data.jpa.repository.JpaRepository;

import java.time.LocalDate;
import java.util.Optional;

public interface DailyQuizRepository extends JpaRepository<DailyQuiz, Long> {
    Optional<DailyQuiz> findByDateAndDifficulty(LocalDate date, Difficulty difficulty);
}
