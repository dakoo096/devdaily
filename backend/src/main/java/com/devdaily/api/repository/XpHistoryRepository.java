package com.devdaily.api.repository;

import com.devdaily.api.entity.XpHistory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface XpHistoryRepository extends JpaRepository<XpHistory, Long> {
    List<XpHistory> findByUserIdOrderByCreatedAtDesc(Long userId);
}
