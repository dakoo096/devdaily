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
public class QuizQuestionResponse {
    private Long id;
    private String text;
    private String codeSnippet;
    private String area;
    private String technology;
    private String difficulty;
    private List<QuizOptionResponse> options;
    private Long relatedContentId;
    private String relatedContentTitle;
}
