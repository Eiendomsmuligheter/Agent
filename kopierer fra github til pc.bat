@echo off
echo Setter opp AI Agent...

REM Definere målmappen
set TARGET_DIR=C:\Users\Ahmad\OneDrive\Ai agent

REM Sjekk om Git er installert
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Git er ikke installert. Vennligst installer Git fra https://git-scm.com/downloads
    pause
    exit /b
)

REM Opprett en midlertidig mappe for kloning
set TEMP_DIR=%TEMP%\ai_agent_temp
if exist "%TEMP_DIR%" rmdir /s /q "%TEMP_DIR%"
mkdir "%TEMP_DIR%"
cd /d "%TEMP_DIR%"

REM Klon GitHub repo til temp mappe
echo Kloner siste versjon fra GitHub...
git clone https://github.com/Eiendomsmuligheter/Agent.git .

REM Sjekk om kloning var vellykket
if %ERRORLEVEL% NEQ 0 (
    echo Feil ved kloning av repository
    pause
    exit /b
)

REM Opprett målmappen hvis den ikke eksisterer
if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"

REM Kopier alle filer fra temp til målmappen, og erstatt eksisterende
echo.
echo Kopierer filer til %TARGET_DIR%...
xcopy /E /Y /I "%TEMP_DIR%" "%TARGET_DIR%"

REM Opprett nødvendige mapper i målmappen hvis de ikke eksisterer
if not exist "%TARGET_DIR%\data" mkdir "%TARGET_DIR%\data"
if not exist "%TARGET_DIR%\models" mkdir "%TARGET_DIR%\models"
if not exist "%TARGET_DIR%\logs" mkdir "%TARGET_DIR%\logs"

REM Rydd opp temp mappe
rmdir /s /q "%TEMP_DIR%"

echo.
echo Oppdatering fullført! Filene er nå kopiert til:
echo %TARGET_DIR%
echo.
echo Mapper opprettet:
echo - data
echo - models
echo - logs
echo.
echo For å starte systemet, åpne Command Prompt i mappen og kjør:
echo docker-compose up --build
echo.
pause