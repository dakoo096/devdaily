package com.devdaily.api.entity;

import com.devdaily.api.enums.Area;
import com.devdaily.api.enums.Difficulty;
import com.devdaily.api.enums.QuizCategory;
import com.devdaily.api.enums.Technology;
import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "quiz_questions")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class QuizQuestion extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 255)
    private String text;

    @Column(name = "code_snippet", columnDefinition = "TEXT")
    private String codeSnippet;

    @Column(columnDefinition = "TEXT")
    private String explanation;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 50)
    private QuizCategory category;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private Difficulty difficulty;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 50)
    private Area area;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 50)
    private Technology technology;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "related_content_id")
    private Content relatedContent;

    @OneToMany(mappedBy = "question", cascade = CascadeType.ALL, orphanRemoval = true)
    @Builder.Default
    private List<QuizOption> options = new ArrayList<>();
}
