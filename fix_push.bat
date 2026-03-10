@echo off
echo ==========================================
echo       Kunming Guide - Fix Push v1.1.5
echo ==========================================
echo.
echo Starting push process... > push_debug.log
echo.

echo 1. Checking git status...
echo 1. Checking git status... >> push_debug.log
git status >> push_debug.log 2>&1

echo.
echo 2. Adding all changes...
echo 2. Adding all changes... >> push_debug.log
git add . >> push_debug.log 2>&1

echo.
echo 3. Committing changes...
echo 3. Committing changes... >> push_debug.log
git commit -m "feat: bump version to 1.1.5 and re-push" >> push_debug.log 2>&1

echo.
echo 4. Pushing to remote (origin master)...
echo 4. Pushing to remote (origin master)... >> push_debug.log
git push origin master >> push_debug.log 2>&1

if %errorlevel% neq 0 (
    echo.
    echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    echo PUSH FAILED! Error code: %errorlevel%
    echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    echo.
    echo PUSH FAILED! Error code: %errorlevel% >> push_debug.log
    echo.
    echo Please check push_debug.log for details.
    echo You might need to check your network connection or proxy settings.
) else (
    echo.
    echo ==========================================
    echo PUSH SUCCESSFUL!
    echo ==========================================
    echo.
    echo PUSH SUCCESSFUL! >> push_debug.log
)

echo.
echo Log saved to push_debug.log
echo.
pause
