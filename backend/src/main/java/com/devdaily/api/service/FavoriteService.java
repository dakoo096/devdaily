package com.devdaily.api.service;

import com.devdaily.api.dto.content.ContentResponse;
import com.devdaily.api.entity.Content;
import com.devdaily.api.entity.Favorite;
import com.devdaily.api.entity.User;
import com.devdaily.api.exception.ResourceNotFoundException;
import com.devdaily.api.mapper.ContentMapper;
import com.devdaily.api.repository.ContentRepository;
import com.devdaily.api.repository.FavoriteRepository;
import com.devdaily.api.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class FavoriteService {

    private final UserRepository userRepository;
    private final ContentRepository contentRepository;
    private final FavoriteRepository favoriteRepository;
    private final ContentMapper contentMapper;

    @Transactional
    public boolean toggleFavorite(Long userId, Long contentId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));
        Content content = contentRepository.findById(contentId)
                .orElseThrow(() -> new ResourceNotFoundException("Contenido no encontrado"));

        Optional<Favorite> existing = favoriteRepository.findByUserIdAndContentId(userId, contentId);

        if (existing.isPresent()) {
            favoriteRepository.delete(existing.get());
            return false;
        } else {
            Favorite favorite = Favorite.builder()
                    .user(user)
                    .content(content)
                    .build();
            favoriteRepository.save(favorite);
            return true;
        }
    }

    @Transactional(readOnly = true)
    public List<ContentResponse> getFavorites(Long userId) {
        if (!userRepository.existsById(userId)) {
            throw new ResourceNotFoundException("Usuario no encontrado");
        }

        List<Favorite> favorites = favoriteRepository.findByUserId(userId);

        return favorites.stream().map(f -> {
            ContentResponse response = contentMapper.toResponse(f.getContent());
            response.setFavorite(true);
            response.setRead(true);
            return response;
        }).collect(Collectors.toList());
    }
}
