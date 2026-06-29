package com.devdaily.api.repository;

import com.devdaily.api.entity.DailyContent;
import org.springframework.data.jpa.repository.JpaRepository;
import java.time.LocalDate;
import java.util.List;

public interface DailyContentRepository extends JpaRepository<DailyContent, Long> {
    List<DailyContent> findByUserIdAndDate(Long userId, LocalDate date);
    boolean existsByUserIdAndDate(Long userId, LocalDate date);
}
