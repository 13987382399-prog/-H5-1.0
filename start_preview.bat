@echo off
echo ==========================================
echo       Kunming Guide - Local Preview
echo ==========================================
echo.
echo 1. Stopping any existing node processes (cleanup)...
taskkill /F /IM node.exe >nul 2>&1
echo.
echo 2. Starting local server...
echo.
echo    Server will run at: http://localhost:3000/
echo    PLEASE KEEP THIS WINDOW OPEN!
echo.
node server.js
echo.
echo Server stopped.
pause
