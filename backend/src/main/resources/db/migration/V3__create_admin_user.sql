-- =========================================================================
-- CREATE DEFAULT ADMIN USER AND CORRESPONDING PREFERENCES/SETTINGS
-- =========================================================================

-- Password is BCrypt hash for 'admin123'
-- Hashed value: $2a$10$EpJp3J6596j7yJ8D0C4C1eG0W5O2r1k4q9a3cK2l0hVb5l102q2q2
INSERT INTO users (id, name, email, password, role, created_at, last_login) VALUES
(1, 'Admin DevDaily', 'admin@devdaily.com', '$2a$10$EpJp3J6596j7yJ8D0C4C1eG0W5O2r1k4q9a3cK2l0hVb5l102q2q2', 'ADMIN', NOW(), NULL);

-- Admin default preferences
INSERT INTO user_preferences (id, user_id, level, updated_at) VALUES
(1, 1, 'SENIOR', NOW());

INSERT INTO user_pref_areas (preference_id, area) VALUES
(1, 'FRONTEND'),
(1, 'BACKEND'),
(1, 'DATABASES'),
(1, 'DEVOPS');

INSERT INTO user_pref_tech (preference_id, technology) VALUES
(1, 'JAVA'),
(1, 'SPRING_BOOT'),
(1, 'VUE'),
(1, 'DOCKER');

INSERT INTO user_pref_types (preference_id, content_type) VALUES
(1, 'TIP'),
(1, 'CURIOSITY'),
(1, 'CONCEPT'),
(1, 'QUESTION');

-- Admin default settings
INSERT INTO user_settings (id, user_id, dark_mode, notifications_enabled, notification_time, updated_at) VALUES
(1, 1, TRUE, FALSE, '09:00', NOW());
