package com.devdaily.api.controller;

import com.devdaily.api.dto.content.ContentResponse;
import com.devdaily.api.security.CustomUserDetails;
import com.devdaily.api.service.FavoriteService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/favorites")
@RequiredArgsConstructor
@Tag(name = "Favorites", description = "Endpoints for managing user favorites")
public class FavoriteController {

    private final FavoriteService favoriteService;

    @GetMapping
    @Operation(summary = "Get list of all user favorite contents")
    public ResponseEntity<List<ContentResponse>> getFavorites(@AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(favoriteService.getFavorites(userDetails.getId()));
    }

    @PostMapping("/{contentId}/toggle")
    @Operation(summary = "Toggle favorite status of a specific content (add/remove)")
    public ResponseEntity<Boolean> toggleFavorite(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @PathVariable Long contentId) {
        return ResponseEntity.ok(favoriteService.toggleFavorite(userDetails.getId(), contentId));
    }
}
