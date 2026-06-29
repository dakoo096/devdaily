package com.devdaily.api.entity;

import com.devdaily.api.enums.Area;
import com.devdaily.api.enums.ContentType;
import com.devdaily.api.enums.Difficulty;
import com.devdaily.api.enums.Technology;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "contents")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Content extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 100)
    private String slug;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private ContentType type;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private Difficulty difficulty;

    @Column(nullable = false, length = 150)
    private String title;

    @Column(nullable = false, columnDefinition = "TEXT")
    private String body;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 50)
    private Area area;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 50)
    private Technology technology;

    @Column(nullable = false, length = 10)
    private String emoji;

    @Column(nullable = false)
    private boolean active;
}
