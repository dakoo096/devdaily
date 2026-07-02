package com.devdaily.api.repository;

import com.devdaily.api.entity.QuizQuestion;
import com.devdaily.api.enums.Difficulty;
import com.devdaily.api.enums.Technology;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Set;

public interface QuizQuestionRepository extends JpaRepository<QuizQuestion, Long> {

    @Query("SELECT q FROM QuizQuestion q WHERE q.difficulty = :difficulty AND q.technology IN :techs")
    List<QuizQuestion> findCandidates(
            @Param("difficulty") Difficulty difficulty,
            @Param("techs") Set<Technology> techs
    );

    List<QuizQuestion> findByDifficulty(Difficulty difficulty);
}
