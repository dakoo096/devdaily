ALTER TABLE users ADD COLUMN dev_xp INT NOT NULL DEFAULT 0;
ALTER TABLE users ADD COLUMN dev_level INT NOT NULL DEFAULT 1;
ALTER TABLE users ADD COLUMN current_streak INT NOT NULL DEFAULT 0;
ALTER TABLE users ADD COLUMN longest_streak INT NOT NULL DEFAULT 0;
ALTER TABLE users ADD COLUMN last_quiz_date DATE;

CREATE TABLE xp_history (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    xp INT NOT NULL,
    reason VARCHAR(100) NOT NULL,
    created_at DATETIME NOT NULL,
    CONSTRAINT fk_xp_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE quiz_questions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    text VARCHAR(255) NOT NULL,
    code_snippet TEXT,
    explanation TEXT,
    category VARCHAR(50) NOT NULL,
    difficulty VARCHAR(30) NOT NULL,
    area VARCHAR(50) NOT NULL,
    technology VARCHAR(50) NOT NULL,
    related_content_id BIGINT,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    CONSTRAINT fk_question_content FOREIGN KEY (related_content_id) REFERENCES contents(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE quiz_options (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    question_id BIGINT NOT NULL,
    text VARCHAR(255) NOT NULL,
    is_correct BOOLEAN NOT NULL,
    CONSTRAINT fk_option_question FOREIGN KEY (question_id) REFERENCES quiz_questions(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE daily_quizzes (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    difficulty VARCHAR(30) NOT NULL,
    UNIQUE KEY uq_quiz_date_diff (date, difficulty)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE daily_quiz_questions (
    quiz_id BIGINT NOT NULL,
    question_id BIGINT NOT NULL,
    PRIMARY KEY (quiz_id, question_id),
    CONSTRAINT fk_dqq_quiz FOREIGN KEY (quiz_id) REFERENCES daily_quizzes(id) ON DELETE CASCADE,
    CONSTRAINT fk_dqq_question FOREIGN KEY (question_id) REFERENCES quiz_questions(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE user_quiz_results (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    quiz_id BIGINT NOT NULL,
    score INT NOT NULL,
    xp_earned INT NOT NULL,
    completed_at DATETIME NOT NULL,
    CONSTRAINT fk_result_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_result_quiz FOREIGN KEY (quiz_id) REFERENCES daily_quizzes(id) ON DELETE CASCADE,
    UNIQUE KEY uq_user_quiz (user_id, quiz_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE achievements (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    key_name VARCHAR(50) NOT NULL UNIQUE,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,
    xp_reward INT NOT NULL DEFAULT 50
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE user_achievements (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    achievement_id BIGINT NOT NULL,
    unlocked_at DATETIME NOT NULL,
    CONSTRAINT fk_ua_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_ua_achievement FOREIGN KEY (achievement_id) REFERENCES achievements(id) ON DELETE CASCADE,
    UNIQUE KEY uq_user_achievement (user_id, achievement_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE INDEX idx_quiz_questions_tech ON quiz_questions(technology);
CREATE INDEX idx_quiz_options_question ON quiz_options(question_id);
CREATE INDEX idx_xp_history_user ON xp_history(user_id);
