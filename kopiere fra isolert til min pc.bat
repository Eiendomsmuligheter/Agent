Here's the result of running `cat -n` on /home/computeruse/Agent/kopierer fra github til pc.bat:
     1	@echo off
     2	echo Setter opp AI Agent...
     3	
     4	REM Definere målmappen
     5	set TARGET_DIR=C:\Users\Ahmad\OneDrive\Ai agent
     6	
     7	REM Sjekk om Git er installert
     8	where git >nul 2>nul
     9	if %ERRORLEVEL% NEQ 0 (
    10	    echo Git er ikke installert. Vennligst installer Git fra https://git-scm.com/downloads
    11	    pause
    12	    exit /b
    13	)
    14	
    15	REM Opprett en midlertidig mappe for kloning
    16	set TEMP_DIR=%TEMP%\ai_agent_temp
    17	if exist "%TEMP_DIR%" rmdir /s /q "%TEMP_DIR%"
    18	mkdir "%TEMP_DIR%"
    19	cd /d "%TEMP_DIR%"
    20	
    21	REM Klon GitHub repo til temp mappe
    22	echo Kloner siste versjon fra GitHub...
    23	git clone https://github.com/Eiendomsmuligheter/Agent.git .
    24	
    25	REM Sjekk om kloning var vellykket
    26	if %ERRORLEVEL% NEQ 0 (
    27	    echo Feil ved kloning av repository
    28	    pause
    29	    exit /b
    30	)
    31	
    32	REM Opprett målmappen hvis den ikke eksisterer
    33	if not exist "%TARGET_DIR%" mkdir "%TARGET_DIR%"
    34	
    35	REM Kopier alle filer fra temp til målmappen, og erstatt eksisterende
    36	echo.
    37	echo Kopierer filer til %TARGET_DIR%...
    38	xcopy /E /Y /I "%TEMP_DIR%" "%TARGET_DIR%"
    39	
    40	REM Opprett nødvendige mapper i målmappen hvis de ikke eksisterer
    41	if not exist "%TARGET_DIR%\data" mkdir "%TARGET_DIR%\data"
    42	if not exist "%TARGET_DIR%\models" mkdir "%TARGET_DIR%\models"
    43	if not exist "%TARGET_DIR%\logs" mkdir "%TARGET_DIR%\logs"
    44	
    45	REM Rydd opp temp mappe
    46	rmdir /s /q "%TEMP_DIR%"
    47	
    48	echo.
    49	echo Oppdatering fullført! Filene er nå kopiert til:
    50	echo %TARGET_DIR%
    51	echo.
    52	echo Mapper opprettet:
    53	echo - data
    54	echo - models
    55	echo - logs
    56	echo.
    57	echo For å starte systemet, åpne Command Prompt i mappen og kjør:
    58	echo docker-compose up --build
    59	echo.
    60	pause