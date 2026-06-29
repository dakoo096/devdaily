package com.devdaily.api.dto.content;

import com.devdaily.api.enums.Area;
import com.devdaily.api.enums.ContentType;
import com.devdaily.api.enums.Difficulty;
import com.devdaily.api.enums.Technology;
import lombok.Data;

@Data
public class ContentResponse {
    private Long id;
    private String slug;
    private ContentType type;
    private Difficulty difficulty;
    private String title;
    private String body;
    private Area area;
    private Technology technology;
    private String emoji;
    private boolean isFavorite;
    private boolean isRead;
}
