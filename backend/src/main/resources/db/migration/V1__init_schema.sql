CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    last_login TIMESTAMP
);

CREATE TABLE user_preferences (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    level VARCHAR(30) NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    CONSTRAINT fk_pref_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE user_pref_areas (
    preference_id BIGINT NOT NULL,
    area VARCHAR(50) NOT NULL,
    PRIMARY KEY (preference_id, area),
    CONSTRAINT fk_pref_areas_pref FOREIGN KEY (preference_id) REFERENCES user_preferences(id) ON DELETE CASCADE
);

CREATE TABLE user_pref_tech (
    preference_id BIGINT NOT NULL,
    technology VARCHAR(50) NOT NULL,
    PRIMARY KEY (preference_id, technology),
    CONSTRAINT fk_pref_tech_pref FOREIGN KEY (preference_id) REFERENCES user_preferences(id) ON DELETE CASCADE
);

CREATE TABLE user_pref_types (
    preference_id BIGINT NOT NULL,
    content_type VARCHAR(50) NOT NULL,
    PRIMARY KEY (preference_id, content_type),
    CONSTRAINT fk_pref_types_pref FOREIGN KEY (preference_id) REFERENCES user_preferences(id) ON DELETE CASCADE
);

CREATE TABLE user_settings (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    dark_mode BOOLEAN NOT NULL DEFAULT FALSE,
    notifications_enabled BOOLEAN NOT NULL DEFAULT TRUE,
    notification_time VARCHAR(5) NOT NULL DEFAULT '09:00',
    updated_at TIMESTAMP NOT NULL,
    CONSTRAINT fk_settings_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE contents (
    id BIGSERIAL PRIMARY KEY,
    slug VARCHAR(100) NOT NULL UNIQUE,
    type VARCHAR(30) NOT NULL,
    difficulty VARCHAR(30) NOT NULL,
    title VARCHAR(150) NOT NULL,
    body TEXT NOT NULL,
    area VARCHAR(50) NOT NULL,
    technology VARCHAR(50) NOT NULL,
    emoji VARCHAR(10) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE daily_content (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    content_id BIGINT NOT NULL,
    date DATE NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    CONSTRAINT fk_daily_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_daily_content FOREIGN KEY (content_id) REFERENCES contents(id) ON DELETE CASCADE
);

CREATE TABLE favorites (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    content_id BIGINT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    CONSTRAINT fk_fav_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_fav_content FOREIGN KEY (content_id) REFERENCES contents(id) ON DELETE CASCADE,
    CONSTRAINT uq_fav_user_content UNIQUE (user_id, content_id)
);

CREATE TABLE history (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    content_id BIGINT NOT NULL,
    view_date DATE NOT NULL,
    is_read BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT fk_hist_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_hist_content FOREIGN KEY (content_id) REFERENCES contents(id) ON DELETE CASCADE,
    CONSTRAINT uq_hist_user_content_date UNIQUE (user_id, content_id, view_date)
);

-- Indexes for performance
CREATE INDEX idx_contents_slug ON contents(slug);
CREATE INDEX idx_daily_user_date ON daily_content(user_id, date);
CREATE INDEX idx_history_user_date ON history(user_id, view_date);
CREATE INDEX idx_favorites_user ON favorites(user_id);
CREATE INDEX idx_pref_user ON user_preferences(user_id);
CREATE INDEX idx_settings_user ON user_settings(user_id);
