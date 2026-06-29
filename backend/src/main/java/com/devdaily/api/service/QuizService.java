package com.devdaily.api.service;

import com.devdaily.api.dto.quiz.*;
import com.devdaily.api.entity.*;
import com.devdaily.api.enums.Difficulty;
import com.devdaily.api.enums.Level;
import com.devdaily.api.enums.Technology;
import com.devdaily.api.exception.BadRequestException;
import com.devdaily.api.exception.ResourceNotFoundException;
import com.devdaily.api.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class QuizService {

    private final UserRepository userRepository;
    private final QuizQuestionRepository quizQuestionRepository;
    private final DailyQuizRepository dailyQuizRepository;
    private final UserQuizResultRepository userQuizResultRepository;
    private final UserPreferenceRepository userPreferenceRepository;
    private final XpHistoryRepository xpHistoryRepository;
    private final AchievementService achievementService;

    private Difficulty mapLevelToDifficulty(Level level) {
        if (level == null) return Difficulty.BEGINNER;
        switch (level) {
            case STUDENT:
                return Difficulty.BEGINNER;
            case JUNIOR:
                return Difficulty.BEGINNER;
            case SEMI_SENIOR:
                return Difficulty.INTERMEDIATE;
            case SENIOR:
                return Difficulty.ADVANCED;
            default:
                return Difficulty.BEGINNER;
        }
    }

    @Transactional
    public List<QuizQuestionResponse> getDailyQuiz(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));

        LocalDate today = LocalDate.now();

        // 1. Fetch User Preference
        List<UserPreference> prefs = userPreferenceRepository.findByUserId(userId);
        if (prefs.isEmpty()) {
            throw new BadRequestException("Debes configurar tus preferencias de onboarding primero");
        }
        UserPreference pref = prefs.get(0);
        Difficulty targetDifficulty = mapLevelToDifficulty(pref.getLevel());

        // 2. Find or Generate DailyQuiz
        DailyQuiz dailyQuiz = dailyQuizRepository.findByDateAndDifficulty(today, targetDifficulty)
                .orElseGet(() -> {
                    // Generate new quiz of 3 questions
                    List<QuizQuestion> candidates = quizQuestionRepository.findCandidates(
                            targetDifficulty,
                            pref.getTechnologies()
                    );

                    if (candidates.size() < 3) {
                        candidates = quizQuestionRepository.findByDifficulty(targetDifficulty);
                    }

                    if (candidates.size() < 3) {
                        candidates = quizQuestionRepository.findAll();
                    }

                    if (candidates.isEmpty()) {
                        throw new ResourceNotFoundException("No hay preguntas de quiz disponibles.");
                    }

                    Collections.shuffle(candidates);
                    List<QuizQuestion> selected = candidates.stream().limit(3).collect(Collectors.toList());

                    DailyQuiz newQuiz = DailyQuiz.builder()
                            .date(today)
                            .difficulty(targetDifficulty)
                            .questions(selected)
                            .build();

                    return dailyQuizRepository.save(newQuiz);
                });

        // 3. Check if user already solved this quiz
        if (userQuizResultRepository.findByUserIdAndQuizId(userId, dailyQuiz.getId()).isPresent()) {
            throw new BadRequestException("Ya has completado tu quiz de hoy");
        }

        // 4. Map to response
        return dailyQuiz.getQuestions().stream().map(q -> QuizQuestionResponse.builder()
                .id(q.getId())
                .text(q.getText())
                .codeSnippet(q.getCodeSnippet())
                .area(q.getArea().getValue())
                .technology(q.getTechnology().getValue())
                .difficulty(q.getDifficulty().getValue())
                .relatedContentId(q.getRelatedContent() != null ? q.getRelatedContent().getId() : null)
                .relatedContentTitle(q.getRelatedContent() != null ? q.getRelatedContent().getTitle() : null)
                .options(q.getOptions().stream().map(o -> QuizOptionResponse.builder()
                        .id(o.getId())
                        .text(o.getText())
                        .build()
                ).collect(Collectors.toList()))
                .build()
        ).collect(Collectors.toList());
    }

    @Transactional
    public QuizSubmitResponse submitQuiz(Long userId, QuizSubmitRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));

        LocalDate today = LocalDate.now();

        // 1. Find the current quiz of user's difficulty for today
        List<UserPreference> prefs = userPreferenceRepository.findByUserId(userId);
        if (prefs.isEmpty()) {
            throw new BadRequestException("Debes configurar tus preferencias de onboarding primero");
        }
        UserPreference pref = prefs.get(0);
        Difficulty targetDifficulty = mapLevelToDifficulty(pref.getLevel());

        DailyQuiz dailyQuiz = dailyQuizRepository.findByDateAndDifficulty(today, targetDifficulty)
                .orElseThrow(() -> new BadRequestException("No hay un quiz diario generado para hoy. Carga el quiz primero."));

        // 2. Check if already submitted
        if (userQuizResultRepository.findByUserIdAndQuizId(userId, dailyQuiz.getId()).isPresent()) {
            throw new BadRequestException("Ya has completado tu quiz de hoy");
        }

        List<QuizSubmitResponse.QuestionResult> results = new ArrayList<>();
        int score = 0;

        for (QuizSubmitRequest.Answer answer : request.getAnswers()) {
            QuizQuestion question = dailyQuiz.getQuestions().stream()
                    .filter(q -> q.getId().equals(answer.getQuestionId()))
                    .findFirst()
                    .orElseThrow(() -> new BadRequestException("La pregunta no pertenece al quiz de hoy: " + answer.getQuestionId()));

            QuizOption correctOption = question.getOptions().stream()
                    .filter(QuizOption::isCorrect)
                    .findFirst()
                    .orElseThrow(() -> new IllegalStateException("La pregunta no tiene una opción correcta configurada"));

            boolean isCorrect = correctOption.getId().equals(answer.getChosenOptionId());
            if (isCorrect) {
                score++;
                // Check if they unlock technology achievements (Java Lover, Docker Fan)
                achievementService.checkAndUnlockTechnology(userId, question.getTechnology());
            }

            results.add(QuizSubmitResponse.QuestionResult.builder()
                    .questionId(question.getId())
                    .correctOptionId(correctOption.getId())
                    .chosenOptionId(answer.getChosenOptionId())
                    .correct(isCorrect)
                    .explanation(question.getExplanation())
                    .relatedContentId(question.getRelatedContent() != null ? question.getRelatedContent().getId() : null)
                    .relatedContentTitle(question.getRelatedContent() != null ? question.getRelatedContent().getTitle() : null)
                    .build());
        }

        // Calculate XP: 10 XP per correct answer, +20 XP for completing the quiz
        int correctXp = score * 10;
        int completionXp = 20;
        int xpEarned = correctXp + completionXp;

        // Streak updates (Duolingo style)
        int currentStreak = user.getCurrentStreak();
        int longestStreak = user.getLongestStreak();
        LocalDate lastQuizDate = user.getLastQuizDate();

        if (lastQuizDate == null) {
            currentStreak = 1;
        } else if (lastQuizDate.equals(today.minusDays(1))) {
            currentStreak += 1;
        } else if (!lastQuizDate.equals(today)) {
            // Missed a day: reset
            currentStreak = 1;
        }

        if (currentStreak > longestStreak) {
            longestStreak = currentStreak;
        }

        // Update user stats
        user.setDevXp(user.getDevXp() + xpEarned);
        user.setCurrentStreak(currentStreak);
        user.setLongestStreak(longestStreak);
        user.setLastQuizDate(today);

        // Level up check
        int newLevel = 1 + (user.getDevXp() / 100);
        user.setDevLevel(newLevel);
        userRepository.save(user);

        // Save XP History for quiz completion
        XpHistory xpHist = XpHistory.builder()
                .user(user)
                .xp(xpEarned)
                .reason("Quiz diario completo: " + score + "/3 aciertos")
                .createdAt(LocalDateTime.now())
                .build();
        xpHistoryRepository.save(xpHist);

        // Save Quiz Result
        UserQuizResult quizResult = UserQuizResult.builder()
                .user(user)
                .quiz(dailyQuiz)
                .score(score)
                .xpEarned(xpEarned)
                .completedAt(LocalDateTime.now())
                .build();
        userQuizResultRepository.save(quizResult);

        // Achievements triggers
        achievementService.checkAndUnlockStreak(userId, currentStreak);
        achievementService.checkAndUnlockQuizCount(userId);

        return QuizSubmitResponse.builder()
                .score(score)
                .xpEarned(xpEarned)
                .totalXp(user.getDevXp())
                .currentStreak(currentStreak)
                .longestStreak(longestStreak)
                .results(results.stream().map(r -> {
                    // Resolve lambda Title logic
                    String relatedTitle = null;
                    QuizQuestion q = dailyQuiz.getQuestions().stream().filter(item -> item.getId().equals(r.getQuestionId())).findFirst().orElse(null);
                    if (q != null && q.getRelatedContent() != null) {
                        relatedTitle = q.getRelatedContent().getTitle();
                    }
                    r.setRelatedContentTitle(relatedTitle);
                    return r;
                }).collect(Collectors.toList()))
                .build();
    }
}
