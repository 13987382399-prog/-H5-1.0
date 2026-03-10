@echo off
echo ==========================================
echo       Kunming Guide - Server Fix & Start
echo ==========================================
echo.

echo 1. Checking dependencies...
if not exist node_modules (
    echo    node_modules not found. Installing dependencies...
    call npm install
    if errorlevel 1 (
        echo    Error installing dependencies. Please check your internet connection.
        pause
        exit /b
    )
) else (
    echo    Dependencies found.
)

echo.
echo 2. Checking configuration...
if not exist .env (
    echo    .env file not found. Creating a default one...
    echo PORT=3000 > .env
    echo ALI_API_KEY=your_api_key_here >> .env
    echo    WARNING: Please edit .env file to add your ALI_API_KEY if needed.
) else (
    echo    Configuration found.
)

echo.
echo 3. Cleaning up old processes...
taskkill /F /IM node.exe >nul 2>&1

echo.
echo 4. Starting server...
echo    Server will run at: http://localhost:3000/
echo    PLEASE KEEP THIS WINDOW OPEN!
echo.
node server.js
if errorlevel 1 (
    echo.
    echo    Server crashed with error code %errorlevel%.
    pause
)
pause
