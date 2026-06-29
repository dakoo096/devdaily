package com.devdaily.api.dto.preference;

import com.devdaily.api.enums.Area;
import com.devdaily.api.enums.ContentType;
import com.devdaily.api.enums.Level;
import com.devdaily.api.enums.Technology;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Set;

@Data
public class PreferencesResponse {
    private Long id;
    private Level level;
    private Set<ContentType> contentTypes;
    private Set<Area> areas;
    private Set<Technology> technologies;
    private LocalDateTime updatedAt;
}
