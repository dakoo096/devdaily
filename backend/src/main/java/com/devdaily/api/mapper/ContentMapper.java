package com.devdaily.api.mapper;

import com.devdaily.api.entity.Content;
import com.devdaily.api.dto.content.ContentResponse;
import org.springframework.stereotype.Component;

@Component
public class ContentMapper {

    public ContentResponse toResponse(Content content) {
        if (content == null) {
            return null;
        }
        ContentResponse response = new ContentResponse();
        response.setId(content.getId());
        response.setSlug(content.getSlug());
        response.setType(content.getType());
        response.setDifficulty(content.getDifficulty());
        response.setTitle(content.getTitle());
        response.setBody(content.getBody());
        response.setArea(content.getArea());
        response.setTechnology(content.getTechnology());
        response.setEmoji(content.getEmoji());
        return response;
    }
}
