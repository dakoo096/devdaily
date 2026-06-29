package com.devdaily.api.controller;

import com.devdaily.api.dto.preference.PreferencesRequest;
import com.devdaily.api.dto.preference.PreferencesResponse;
import com.devdaily.api.dto.preference.SettingsRequest;
import com.devdaily.api.dto.preference.SettingsResponse;
import com.devdaily.api.dto.user.UpdateProfileRequest;
import com.devdaily.api.dto.user.UserResponse;
import com.devdaily.api.dto.user.UserStatsResponse;
import com.devdaily.api.security.CustomUserDetails;
import com.devdaily.api.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
@RequiredArgsConstructor
@Tag(name = "User Management", description = "Endpoints for profile, stats, preferences, and settings")
public class UserController {

    private final UserService userService;

    @PutMapping("/profile")
    @Operation(summary = "Update authenticated user profile details")
    public ResponseEntity<UserResponse> updateProfile(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @RequestBody UpdateProfileRequest request) {
        return ResponseEntity.ok(userService.updateProfile(userDetails.getId(), request));
    }

    @GetMapping("/preferences")
    @Operation(summary = "Get user developer preferences")
    public ResponseEntity<PreferencesResponse> getPreferences(@AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(userService.getPreferences(userDetails.getId()));
    }

    @PutMapping("/preferences")
    @Operation(summary = "Create or update user developer preferences")
    public ResponseEntity<PreferencesResponse> updatePreferences(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @RequestBody PreferencesRequest request) {
        return ResponseEntity.ok(userService.updatePreferences(userDetails.getId(), request));
    }

    @GetMapping("/settings")
    @Operation(summary = "Get user app settings (dark mode, notifications)")
    public ResponseEntity<SettingsResponse> getSettings(@AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(userService.getSettings(userDetails.getId()));
    }

    @PutMapping("/settings")
    @Operation(summary = "Create or update user app settings")
    public ResponseEntity<SettingsResponse> updateSettings(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @RequestBody SettingsRequest request) {
        return ResponseEntity.ok(userService.updateSettings(userDetails.getId(), request));
    }

    @GetMapping("/stats")
    @Operation(summary = "Get user activity statistics (days active, favorites, read counts)")
    public ResponseEntity<UserStatsResponse> getStats(@AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(userService.getUserStats(userDetails.getId()));
    }
}
