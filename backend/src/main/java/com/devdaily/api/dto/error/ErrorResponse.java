package com.devdaily.api.dto.error;

import java.time.LocalDateTime;

public record ErrorResponse(
    String message,
    String path,
    LocalDateTime timestamp
) {}
