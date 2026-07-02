package com.devdaily.api.repository;

import com.devdaily.api.entity.History;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

public interface HistoryRepository extends JpaRepository<History, Long> {
    List<History> findByUserId(Long userId);
    List<History> findByUserIdAndViewDate(Long userId, LocalDate date);
    Optional<History> findByUserIdAndContentIdAndViewDate(Long userId, Long contentId, LocalDate date);
    long countByUserId(Long userId);

    @Query("SELECT COUNT(DISTINCT h.viewDate) FROM History h WHERE h.user.id = :userId")
    long countDistinctDaysActive(@Param("userId") Long userId);

    @Query("SELECT COUNT(h) FROM History h WHERE h.user.id = :userId AND h.content.technology = :tech")
    long countByUserIdAndTechnology(@Param("userId") Long userId, @Param("tech") com.devdaily.api.enums.Technology tech);
}
