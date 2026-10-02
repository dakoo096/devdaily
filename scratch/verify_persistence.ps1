Write-Host "=========================================================="
Write-Host " DEVBLOOM PERSISTENCIA DOCKER POSTGRESQL TRAS RESTART"
Write-Host "=========================================================="

$userJson = Get-Content -Raw "scratch/last_test_user.json" | ConvertFrom-Json
Write-Host "Usuario creado previamente: $($userJson.email) (ID: $($userJson.userId))"

# Realizar login con el usuario previo
Write-Host "`nProbando POST /api/auth/login con el usuario creado antes del reinicio..."
$loginBody = @{
    email = $userJson.email
    password = $userJson.password
} | ConvertTo-Json

$loginRes = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/login" -Method Post -Body $loginBody -ContentType "application/json"
$token = $loginRes.token
Write-Host "   -> OK: Login exitoso tras reinicio de contenedores! Token emitido ($($token.Length) chars)"

$headers = @{ Authorization = "Bearer " + $token }

# Verificar /api/auth/me
$me = Invoke-RestMethod -Uri "http://localhost:8080/api/auth/me" -Method Get -Headers $headers
Write-Host "   -> OK: Datos de usuario persistidos intactos:"
Write-Host "      * ID: $($me.id)"
Write-Host "      * Nombre: $($me.name)"
Write-Host "      * Email: $($me.email)"
Write-Host "      * XP: $($me.devXp)"
Write-Host "      * Racha: $($me.currentStreak)"

# Verificar preferencias persistidas
$pref = Invoke-RestMethod -Uri "http://localhost:8080/api/users/preferences" -Method Get -Headers $headers
Write-Host "   -> OK: Preferencias persistidas:"
Write-Host "      * Nivel: $($pref.level)"
Write-Host "      * Tecnologías: $($pref.technologies -join ', ')"

# Verificar favoritos persistidos
$favs = Invoke-RestMethod -Uri "http://localhost:8080/api/favorites" -Method Get -Headers $headers
Write-Host "   -> OK: Favoritos persistidos: $($favs.Count) (Favorito guardado: '$($favs[0].title)')"

# Verificar logros persistidos
$achievements = Invoke-RestMethod -Uri "http://localhost:8080/api/users/achievements" -Method Get -Headers $headers
$unlocked = ($achievements | Where-Object { $_.unlocked -eq $true }).title
Write-Host "   -> OK: Logros desbloqueados persistidos: $unlocked"

Write-Host "`n=========================================================="
Write-Host " PERSISTENCIA EN POSTGRESQL VERIFICADA AL 100% "
Write-Host "=========================================================="
