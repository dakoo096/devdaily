package com.devdaily.api.dto.quiz;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class QuizSubmitResponse {
    private int score;
    private int xpEarned;
    private int totalXp;
    private int currentStreak;
    private int longestStreak;
    private List<QuestionResult> results;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class QuestionResult {
        private Long questionId;
        private Long correctOptionId;
        private Long chosenOptionId;
        private boolean correct;
        private String explanation;
        private Long relatedContentId;
        private String relatedContentTitle;
    }
}
