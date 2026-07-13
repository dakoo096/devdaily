package com.devdaily.api.repository;

import com.devdaily.api.entity.Content;
import com.devdaily.api.enums.Area;
import com.devdaily.api.enums.ContentType;
import com.devdaily.api.enums.Technology;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.Set;

public interface ContentRepository extends JpaRepository<Content, Long> {
    Optional<Content> findBySlug(String slug);

    @Query("SELECT c FROM Content c WHERE c.active = true AND (c.type IN :types) AND (c.technology IN :techs) AND (c.area IN :areas)")
    List<Content> findDailyCandidates(
            @Param("types") Set<ContentType> types,
            @Param("areas") Set<Area> areas,
            @Param("techs") Set<Technology> techs
    );

    @Query("SELECT c FROM Content c WHERE c.active = true AND (c.technology IN :techs)")
    List<Content> findFallbackCandidates(
            @Param("techs") Set<Technology> techs
    );
}
