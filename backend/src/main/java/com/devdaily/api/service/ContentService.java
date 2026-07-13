package com.devdaily.api.service;

import com.devdaily.api.dto.content.ContentResponse;
import com.devdaily.api.entity.Content;
import com.devdaily.api.entity.DailyContent;
import com.devdaily.api.entity.History;
import com.devdaily.api.entity.User;
import com.devdaily.api.entity.UserPreference;
import com.devdaily.api.exception.BadRequestException;
import com.devdaily.api.exception.ResourceNotFoundException;
import com.devdaily.api.mapper.ContentMapper;
import com.devdaily.api.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class ContentService {

    private final UserRepository userRepository;
    private final ContentRepository contentRepository;
    private final UserPreferenceRepository userPreferenceRepository;
    private final DailyContentRepository dailyContentRepository;
    private final FavoriteRepository favoriteRepository;
    private final HistoryRepository historyRepository;
    private final ContentMapper contentMapper;
    private final AchievementService achievementService;

    @Transactional
    public List<ContentResponse> getDailyContent(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));

        LocalDate today = LocalDate.now();

        // 1. Check if we already generated content for today
        List<DailyContent> dailyEntries = dailyContentRepository.findByUserIdAndDate(userId, today);

        List<Content> contents;

        if (dailyEntries.isEmpty()) {
            List<UserPreference> prefs = userPreferenceRepository.findByUserId(userId);
            if (prefs.isEmpty()) {
                throw new BadRequestException("Debes configurar tus preferencias de onboarding primero");
            }
            UserPreference pref = prefs.get(0);

            // Fetch candidate matching types AND (areas OR technologies)
            List<Content> candidates = contentRepository.findDailyCandidates(
                    pref.getContentTypes(),
                    pref.getAreas(),
                    pref.getTechnologies()
            );

            // Fallback: If not enough matches, find content matching tech (wider pool)
            if (candidates.size() < 5) {
                List<Content> fallback = contentRepository.findFallbackCandidates(
                        pref.getTechnologies()
                );
                Set<Content> combined = new HashSet<>(candidates);
                combined.addAll(fallback);
                candidates = new ArrayList<>(combined);
            }

            // Fallback 2: If still not enough, just load any active contents
            if (candidates.isEmpty()) {
                candidates = contentRepository.findAll().stream()
                        .filter(Content::isActive)
                        .collect(Collectors.toList());
            }

            // Shuffle and pick between 5 and 8 items
            Collections.shuffle(candidates);
            int count = Math.min(candidates.size(), new Random().nextInt(4) + 5); // 5 to 8
            contents = candidates.subList(0, count);

            // Save generated daily content and add to history
            for (Content c : contents) {
                DailyContent dc = DailyContent.builder()
                        .user(user)
                        .content(c)
                        .date(today)
                        .generatedAt(LocalDateTime.now())
                        .build();
                dailyContentRepository.save(dc);

                // Add to history as read/viewed
                if (historyRepository.findByUserIdAndContentIdAndViewDate(userId, c.getId(), today).isEmpty()) {
                    History history = History.builder()
                            .user(user)
                            .content(c)
                            .viewDate(today)
                            .isRead(true)
                            .build();
                    historyRepository.save(history);
                    achievementService.checkAndUnlockFirstRead(userId);
                    achievementService.checkAndUnlockTechnology(userId, c.getTechnology());
                }
            }
        } else {
            contents = dailyEntries.stream()
                    .map(DailyContent::getContent)
                    .collect(Collectors.toList());
        }

        // 3. Map to responses and set favorite/read states
        return contents.stream().map(c -> {
            ContentResponse response = contentMapper.toResponse(c);
            response.setFavorite(favoriteRepository.existsByUserIdAndContentId(userId, c.getId()));
            response.setRead(true); // Since it was generated/retrieved on screen
            return response;
        }).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public ContentResponse getContentById(Long id) {
        Content content = contentRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Contenido no encontrado"));
        return contentMapper.toResponse(content);
    }
}
