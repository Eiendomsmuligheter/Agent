@echo off
echo Starting AI Agent Installation and Setup...

:: Set project directory
set PROJECT_DIR="C:\Users\Ahmad\OneDrive\Ai agent"
cd %PROJECT_DIR%

:: Check if Python is installed
python --version > nul 2>&1
if errorlevel 1 (
    echo Python is not installed. Please download and install Python from:
    echo https://www.python.org/downloads/
    echo Make sure to check "Add Python to PATH" during installation.
    echo After installing Python, run this script again.
    pause
    exit /b 1
)

:: Remove existing virtual environment if it exists
if exist "venv" (
    echo Removing old virtual environment...
    rmdir /s /q "venv"
)

:: Create new virtual environment
echo Creating fresh virtual environment...
python -m venv venv

:: Activate virtual environment
call venv\Scripts\activate.bat

:: Clean pip and upgrade
echo Upgrading pip...
python -m pip install --upgrade pip --no-cache-dir

:: Install core requirements one by one
echo Installing required packages...
pip install torch --index-url https://download.pytorch.org/whl/cpu
pip install transformers --no-deps
pip install numpy
pip install scipy
pip install qiskit
pip install fastapi
pip install uvicorn
pip install python-multipart
pip install websockets
pip install redis
pip install pyyaml
pip install python-dotenv
pip install aiohttp
pip install zmq
pip install loguru

:: Create necessary directories if they don't exist
if not exist "data" mkdir data
if not exist "models" mkdir models
if not exist "logs" mkdir logs

echo.
echo Installation complete!
echo.
echo Starting AI Agent...
echo.

:: Start the AI agent
python run.py

:: Keep the window open if there's an error
if errorlevel 1 (
    echo.
    echo An error occurred while running the AI agent.
    echo Please check the logs in the logs directory for more information.
    pause
)