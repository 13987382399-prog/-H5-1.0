@echo off
echo ==========================================
echo       Kunming Guide - Manual Push v1.1.4
echo ==========================================
echo.
echo 1. Checking git status...
git status
echo.
echo 2. Adding all changes...
git add .
echo.
echo 3. Committing changes...
git commit -m "feat: expand nearby recommendations on button click v1.1.4"
echo.
echo 4. Pushing to remote (origin master)...
git push origin master
echo.
echo ==========================================
echo Done! Please check the output above for any errors.
echo If push failed, you might need to pull first or check your network.
echo ==========================================
pause
