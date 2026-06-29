package com.devdaily.api.service;

import com.devdaily.api.dto.content.ContentResponse;
import com.devdaily.api.dto.content.HistoryResponse;
import com.devdaily.api.entity.History;
import com.devdaily.api.exception.ResourceNotFoundException;
import com.devdaily.api.mapper.ContentMapper;
import com.devdaily.api.repository.FavoriteRepository;
import com.devdaily.api.repository.HistoryRepository;
import com.devdaily.api.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class HistoryService {

    private final UserRepository userRepository;
    private final HistoryRepository historyRepository;
    private final FavoriteRepository favoriteRepository;
    private final ContentMapper contentMapper;

    @Transactional(readOnly = true)
    public List<HistoryResponse> getHistory(Long userId) {
        if (!userRepository.existsById(userId)) {
            throw new ResourceNotFoundException("Usuario no encontrado");
        }

        List<History> histories = historyRepository.findByUserId(userId);

        return histories.stream()
                .map(h -> {
                    ContentResponse contentResponse = contentMapper.toResponse(h.getContent());
                    contentResponse.setFavorite(favoriteRepository.existsByUserIdAndContentId(userId, h.getContent().getId()));
                    contentResponse.setRead(h.isRead());

                    return HistoryResponse.builder()
                            .viewDate(h.getViewDate())
                            .isRead(h.isRead())
                            .content(contentResponse)
                            .build();
                })
                .collect(Collectors.toList());
    }
}
