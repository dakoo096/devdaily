package com.devdaily.api.controller;

import com.devdaily.api.dto.content.HistoryResponse;
import com.devdaily.api.security.CustomUserDetails;
import com.devdaily.api.service.HistoryService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/history")
@RequiredArgsConstructor
@Tag(name = "History", description = "Endpoints for viewing user reading timeline history")
public class HistoryController {

    private final HistoryService historyService;

    @GetMapping
    @Operation(summary = "Get the complete reading timeline history for the authenticated user")
    public ResponseEntity<List<HistoryResponse>> getHistory(@AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(historyService.getHistory(userDetails.getId()));
    }
}
