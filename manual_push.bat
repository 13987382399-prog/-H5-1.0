@echo off
echo ==========================================
echo       Kunming Guide - Manual Push
echo ==========================================
echo.
echo 1. Checking git status...
git status
echo.
echo 2. Adding all changes...
git add .
echo.
echo 3. Committing changes...
git commit -m "feat: update button interaction styles and fix server scripts v1.1.3"
echo.
echo 4. Pushing to remote (origin master)...
git push origin master
echo.
echo ==========================================
echo Done! Please check the output above for any errors.
echo If push failed, you might need to pull first or check your network.
echo ==========================================
pause
