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

:: Check if pip is installed
pip --version > nul 2>&1
if errorlevel 1 (
    echo Installing pip...
    python -m ensurepip --default-pip
)

:: Check if virtualenv is installed
pip show virtualenv > nul 2>&1
if errorlevel 1 (
    echo Installing virtualenv...
    pip install virtualenv
)

:: Create and activate virtual environment
echo Setting up virtual environment...
if not exist "venv" (
    python -m venv venv
)
call venv\Scripts\activate.bat

:: Upgrade pip in virtual environment
python -m pip install --upgrade pip

:: Install requirements
echo Installing required packages...
pip install -r requirements.txt

:: Install additional system dependencies
echo Installing additional dependencies...
pip install jupyter notebook ipykernel

:: Register virtual environment with Jupyter
python -m ipykernel install --user --name=ai_agent_venv --display-name="AI Agent Environment"

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

deactivate