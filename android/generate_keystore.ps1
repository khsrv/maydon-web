# Скрипт для генерации нового keystore для подписи Android приложения (Windows PowerShell)

$KEYSTORE_NAME = "maydon-release-key.jks"
$KEYSTORE_PATH = $KEYSTORE_NAME
$ALIAS = "maydon"
$STORE_PASSWORD = "maydon2025release"
$KEY_PASSWORD = "maydon2025release"

Write-Host "Генерация нового keystore для Maydon..." -ForegroundColor Cyan
Write-Host ""

# Проверяем наличие Java keytool
$keytoolPath = $null
$javaHome = $env:JAVA_HOME
if ($javaHome) {
    $keytoolPath = Join-Path $javaHome "bin\keytool.exe"
    if (-not (Test-Path $keytoolPath)) {
        $keytoolPath = $null
    }
}

if (-not $keytoolPath) {
    # Пробуем найти keytool в PATH
    $keytoolPath = Get-Command keytool -ErrorAction SilentlyContinue
    if ($keytoolPath) {
        $keytoolPath = $keytoolPath.Source
    }
}

if (-not $keytoolPath -or -not (Test-Path $keytoolPath)) {
    Write-Host "Ошибка: keytool не найден." -ForegroundColor Red
    Write-Host "Убедитесь, что Java установлена и добавлена в PATH." -ForegroundColor Yellow
    Write-Host "Или установите Android Studio, который включает JDK." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Попробуйте найти keytool в:" -ForegroundColor Yellow
    Write-Host "  - C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -ForegroundColor Gray
    Write-Host "  - C:\Program Files\Java\jdk-*\bin\keytool.exe" -ForegroundColor Gray
    exit 1
}

# Проверяем, существует ли уже keystore
if (Test-Path $KEYSTORE_PATH) {
    Write-Host "Внимание: Файл $KEYSTORE_NAME уже существует!" -ForegroundColor Yellow
    $response = Read-Host "Перезаписать? (y/n)"
    if ($response -ne "y" -and $response -ne "Y") {
        Write-Host "Отменено." -ForegroundColor Yellow
        exit 1
    }
    Remove-Item $KEYSTORE_PATH -Force
}

Write-Host "Создание keystore..." -ForegroundColor Green

# Генерируем новый keystore
& $keytoolPath -genkey -v `
    -keystore $KEYSTORE_PATH `
    -keyalg RSA `
    -keysize 2048 `
    -validity 10000 `
    -alias $ALIAS `
    -storepass $STORE_PASSWORD `
    -keypass $KEY_PASSWORD `
    -dname "CN=Maydon, OU=Development, O=Maydon, L=Dushanbe, ST=Dushanbe, C=TJ"

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ Keystore успешно создан: $KEYSTORE_PATH" -ForegroundColor Green
    Write-Host ""
    Write-Host "Информация о keystore:" -ForegroundColor Cyan
    Write-Host "  Имя файла: $KEYSTORE_NAME" -ForegroundColor Gray
    Write-Host "  Алиас: $ALIAS" -ForegroundColor Gray
    Write-Host "  Пароль хранилища: $STORE_PASSWORD" -ForegroundColor Gray
    Write-Host "  Пароль ключа: $KEY_PASSWORD" -ForegroundColor Gray
    Write-Host ""
    Write-Host "⚠️  ВАЖНО: Сохраните эти данные в безопасном месте!" -ForegroundColor Yellow
    Write-Host "   Без этого keystore вы не сможете обновлять приложение в Google Play!" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host "Ошибка при создании keystore." -ForegroundColor Red
    exit 1
}

