package com.devdaily.api.entity;

import com.devdaily.api.enums.Area;
import com.devdaily.api.enums.ContentType;
import com.devdaily.api.enums.Level;
import com.devdaily.api.enums.Technology;
import jakarta.persistence.*;
import lombok.*;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "user_preferences")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@EntityListeners(AuditingEntityListener.class)
public class UserPreference {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 30)
    private Level level;

    @ElementCollection(targetClass = ContentType.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_pref_types", joinColumns = @JoinColumn(name = "preference_id"))
    @Column(name = "content_type")
    @Enumerated(EnumType.STRING)
    @Builder.Default
    private Set<ContentType> contentTypes = new HashSet<>();

    @ElementCollection(targetClass = Area.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_pref_areas", joinColumns = @JoinColumn(name = "preference_id"))
    @Column(name = "area")
    @Enumerated(EnumType.STRING)
    @Builder.Default
    private Set<Area> areas = new HashSet<>();

    @ElementCollection(targetClass = Technology.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_pref_tech", joinColumns = @JoinColumn(name = "preference_id"))
    @Column(name = "technology")
    @Enumerated(EnumType.STRING)
    @Builder.Default
    private Set<Technology> technologies = new HashSet<>();

    @LastModifiedDate
    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;
}
