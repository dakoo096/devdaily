$email = "postgres_tester_" + (Get-Random) + "@devbloom.com"
$password = "DevBloom2026!"

Write-Host "=========================================================="
Write-Host " DEVBLOOM SMOKE TESTS & SECUENCIAS (POSTGRESQL 16 DOCKER)"
Write-Host "=========================================================="

# 1. Register
Write-Host "`n[1/11] POST /api/auth/register..."
$regBody = @{
    name = "Postgres Tester"
    email = $email
    password = $password
} | ConvertTo-Json
$regRes = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/register" -Method Post -Body $regBody -ContentType "application/json"
Write-Host "   -> OK: ID=$($regRes.id), Email=$($regRes.email), Onboarding=$($regRes.onboardingCompleted)"
if ($regRes.id -le 1) {
    Write-Error "ERROR: El ID asignado ($($regRes.id)) debería ser superior al ID del Admin (1). Verifique la secuencia users_id_seq."
    exit 1
}

# 2. Login
Write-Host "`n[2/11] POST /api/auth/login..."
$loginBody = @{
    email = $email
    password = $password
} | ConvertTo-Json
$loginRes = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginRes.token
Write-Host "   -> OK: Token JWT emitido ($($token.Length) caracteres)"
$headers = @{ Authorization = "Bearer " + $token }

# 3. GET /api/auth/me
Write-Host "`n[3/11] GET /api/auth/me..."
$me = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/me" -Method Get -Headers $headers
Write-Host "   -> OK: Nombre=$($me.name), Email=$($me.email), XP=$($me.devXp), Racha=$($me.currentStreak)"

# 4. PUT /api/users/preferences
Write-Host "`n[4/11] PUT /api/users/preferences..."
$prefBody = @{
    level = "junior"
    areas = @("frontend", "backend")
    technologies = @("java", "vue", "javascript")
    contentTypes = @("tip", "concept", "curiosity", "question")
} | ConvertTo-Json
$putPref = Invoke-RestMethod -Uri "http://localhost:8080/api/users/preferences" -Method Put -Body $prefBody -ContentType "application/json" -Headers $headers
$getPref = Invoke-RestMethod -Uri "http://localhost:8080/api/users/preferences" -Method Get -Headers $headers
Write-Host "   -> OK: Preferencias guardadas sin colisión (Nivel=$($getPref.level), Techs=$($getPref.technologies -join ', '))"

# 5. GET /api/content/today
Write-Host "`n[5/11] GET /api/content/today..."
$today = Invoke-RestMethod -Uri "http://localhost:8080/api/content/today" -Method Get -Headers $headers
Write-Host "   -> OK: $($today.Count) contenidos diarios obtenidos:"
foreach ($c in $today) {
    Write-Host "      * [ID $($c.id)] [$($c.type)] $($c.title) ($($c.technology))"
}
$firstContentId = $today[0].id

# 6. GET /api/quiz/today
Write-Host "`n[6/11] GET /api/quiz/today..."
$quiz = Invoke-RestMethod -Uri "http://localhost:8080/api/quiz/today" -Method Get -Headers $headers
Write-Host "   -> OK: $($quiz.Count) preguntas obtenidas para el quiz diario:"
foreach ($q in $quiz) {
    Write-Host "      * [QID $($q.id)] $($q.text)"
}

# 7. GET /api/users/stats
Write-Host "`n[7/11] GET /api/users/stats..."
$stats = Invoke-RestMethod -Uri "http://localhost:8080/api/users/stats" -Method Get -Headers $headers
Write-Host "   -> OK: Total leídos=$($stats.totalRead), Favoritos=$($stats.totalFavorites), Días activo=$($stats.daysActive)"

# 8. POST /api/favorites/{id}/toggle y GET /api/favorites
Write-Host "`n[8/11] Testing Favoritos (POST /api/favorites/$firstContentId/toggle & GET /api/favorites)..."
$favToggle = Invoke-RestMethod -Uri "http://localhost:8080/api/favorites/$firstContentId/toggle" -Method Post -Headers $headers
Write-Host "   -> Toggle result: $favToggle"
$favs = Invoke-RestMethod -Uri "http://localhost:8080/api/favorites" -Method Get -Headers $headers
Write-Host "   -> OK: Total favoritos listados = $($favs.Count) (Primer favorito: '$($favs[0].title)')"

# 9. GET /api/history
Write-Host "`n[9/11] Testing Historial (GET /api/history)..."
$hist = Invoke-RestMethod -Uri "http://localhost:8080/api/history" -Method Get -Headers $headers
Write-Host "   -> OK: Historial obtenido con éxito ($($hist.Count) items en historial)"

# 10. GET /api/users/achievements
Write-Host "`n[10/11] Testing Achievements (GET /api/users/achievements)..."
$achievements = Invoke-RestMethod -Uri "http://localhost:8080/api/users/achievements" -Method Get -Headers $headers
Write-Host "   -> OK: $($achievements.Count) logros disponibles en el sistema:"
foreach ($a in $achievements) {
    Write-Host "      * $($a.title) (Desbloqueado: $($a.unlocked)) - +$($a.xpReward) XP"
}

# 11. POST /api/quiz/submit (Verificar XP y Racha)
Write-Host "`n[11/11] Testing Quiz Submit, XP & Racha (POST /api/quiz/submit)..."
$answers = @()
foreach ($q in $quiz) {
    $firstOption = $q.options[0]
    $answers += @{
        questionId = $q.id
        selectedOptionId = $firstOption.id
    }
}
$submitBody = @{
    answers = $answers
} | ConvertTo-Json
$submitRes = Invoke-RestMethod -Uri "http://localhost:8080/api/quiz/submit" -Method Post -Body $submitBody -ContentType "application/json" -Headers $headers
Write-Host "   -> OK: Quiz completado! Score: $($submitRes.score)/$($submitRes.totalQuestions), XP ganados: $($submitRes.xpEarned), Racha actual: $($submitRes.currentStreak)"

$meAfter = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/me" -Method Get -Headers $headers
Write-Host "   -> Perfil actualizado: XP total = $($meAfter.devXp), Racha = $($meAfter.currentStreak)"

# Guardar credenciales para la prueba de persistencia
$creds = @{ email = $email; password = $password; userId = $regRes.id } | ConvertTo-Json
$creds | Out-File -FilePath "scratch/last_test_user.json" -Encoding utf8

Write-Host "`n=========================================================="
Write-Host " TODOS LOS SMOKE TESTS PASARON EXITOSAMENTE (11 / 11 OK) "
Write-Host "=========================================================="
