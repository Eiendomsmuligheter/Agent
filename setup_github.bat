@echo off
setlocal EnableDelayedExpansion
color 0A

:: =======================================
:: AI Agent GitHub Setup
:: Version: 2.0
:: =======================================

echo ================================================
echo      AI Agent GitHub Setup
echo ================================================
echo Dette scriptet vil:
echo 1. Installere Git (uten omstart)
echo 2. Sette opp GitHub repository
echo 3. Laste opp koden
echo ================================================
echo.

:: Installer Git hvis det ikke finnes
where git >nul 2>nul
if errorlevel 1 (
    echo Git er ikke installert. Installerer...
    echo Dette kan ta noen minutter...

    :: Last ned Git
    set "TEMP_DIR=%TEMP%\GitInstall"
    mkdir "%TEMP_DIR%" 2>nul
    powershell -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://github.com/git-for-windows/git/releases/download/v2.42.0.windows.2/Git-2.42.0.2-64-bit.exe' -OutFile '%TEMP_DIR%\GitSetup.exe' }"

    :: Installer Git stille
    start /wait "" "%TEMP_DIR%\GitSetup.exe" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /COMPONENTS="icons,ext\reg\shellhere,assoc,assoc_sh"

    :: Oppdater PATH
    set "PATH=%PATH%;C:\Program Files\Git\cmd"

    :: Rydd opp
    rmdir /s /q "%TEMP_DIR%" 2>nul
)

:: Verifiser Git-installasjon
git --version
if errorlevel 1 (
    echo Feil: Git installation failed.
    pause
    exit /b 1
)

:: Sett prosjektmappen
set "PROJECT_ROOT=C:\Users\Ahmad\OneDrive\Ai agent"

:: Verifiser prosjektmappe
if not exist "%PROJECT_ROOT%" (
    echo Feil: Prosjektmappen finnes ikke: %PROJECT_ROOT%
    echo Opprett mappen eller endre PROJECT_ROOT i scriptet.
    pause
    exit /b 1
)

:: Gå til prosjektmappen
cd /d "%PROJECT_ROOT%"

:: Konfigurer git
echo.
echo Konfigurerer git...
git config --global user.name "Eiendomsmuligheter"
git config --global user.email "Ahmad_rezae@hotmail.com"

:: Initialiser git repository
if not exist ".git" (
    echo Initialiserer git repository...
    git init
)

:: Opprett .gitignore
echo Oppretter .gitignore...
(
echo # Dependencies
echo node_modules/
echo .env
echo .env.local
echo .next/
echo build/
echo dist/
echo .DS_Store
echo # IDE files
echo .idea/
echo .vscode/
) > .gitignore

:: Legg til filer
echo.
echo Legger til filer...
git add .

:: Commit
echo.
echo Committer endringer...
git commit -m "Initial commit: AI Agent"

:: Repository navn
set "REPO_NAME=Agent"

echo.
echo ================================================
echo Nå må du gjøre følgende på GitHub:
echo 1. Gå til https://github.com/new
echo 2. Skriv inn: %REPO_NAME% som repository navn
echo 3. Velg "Public"
echo 4. Klikk "Create repository"
echo.
echo Trykk ENTER når du har gjort dette...
echo ================================================
pause > nul

:: Push til GitHub
echo.
echo Laster opp til GitHub...
git remote add origin https://github.com/Eiendomsmuligheter/%REPO_NAME%.git
git branch -M main
git push -u origin main

echo.
echo ================================================
echo               Setup fullført!
echo ================================================
echo.
echo Din kode er nå tilgjengelig på:
echo https://github.com/Eiendomsmuligheter/%REPO_NAME%
echo.
echo For å få hjelp med koden:
echo 1. Start en ny chat med AI-assistenten
echo 2. Del GitHub-lenken over
echo 3. Forklar hva du vil ha hjelp med
echo.
echo AI-assistenten vil da kunne:
echo - Se all koden
echo - Foreslå forbedringer
echo - Hjelpe med spesifikke filer
echo ================================================
echo.
pause