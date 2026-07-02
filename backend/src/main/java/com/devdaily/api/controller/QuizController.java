package com.devdaily.api.controller;

import com.devdaily.api.dto.quiz.*;
import com.devdaily.api.security.CustomUserDetails;
import com.devdaily.api.service.QuizService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/quiz")
@RequiredArgsConstructor
@Tag(name = "Quiz", description = "Endpoints for daily quiz and leaderboard")
public class QuizController {

    private final QuizService quizService;

    @GetMapping("/today")
    @Operation(summary = "Get today's daily quiz of 3 questions for the user")
    public ResponseEntity<List<QuizQuestionResponse>> getDailyQuiz(@AuthenticationPrincipal CustomUserDetails userDetails) {
        return ResponseEntity.ok(quizService.getDailyQuiz(userDetails.getId()));
    }

    @PostMapping("/submit")
    @Operation(summary = "Submit quiz answers, get score, explanations, and update points/streak")
    public ResponseEntity<QuizSubmitResponse> submitQuiz(
            @AuthenticationPrincipal CustomUserDetails userDetails,
            @Valid @RequestBody QuizSubmitRequest request) {
        return ResponseEntity.ok(quizService.submitQuiz(userDetails.getId(), request));
    }

}
