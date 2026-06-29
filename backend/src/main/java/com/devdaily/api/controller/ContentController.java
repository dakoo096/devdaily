package com.devdaily.api.controller;

import com.devdaily.api.dto.content.ContentResponse;
import com.devdaily.api.security.CustomUserDetails;
import com.devdaily.api.service.ContentService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/content")
@RequiredArgsConstructor
@Tag(name = "Content Delivery", description = "Endpoints for retrieving daily personalized content")
public class ContentController {

    private final ContentService contentService;

    @GetMapping("/today")
    @Operation(summary = "Get the daily compiled contents personalized for the user")
    public ResponseEntity<List<ContentResponse>> getTodayContent(@AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(contentService.getDailyContent(userDetails.getId()));
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get content item by ID")
    public ResponseEntity<ContentResponse> getContentById(
            @PathVariable Long id,
            @AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(contentService.getContentById(id));
    }
}
