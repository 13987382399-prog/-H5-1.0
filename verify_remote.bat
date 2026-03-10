@echo off
echo ==========================================
echo       Kunming Guide - Check Remote URL
echo ==========================================
echo.
echo Connecting to server...
ssh root@8.137.59.55 "cd /var/www/kunming-guide && echo '--- REMOTE URL ---' && git remote -v && echo '--- BRANCH STATUS ---' && git status"
echo.
echo ==========================================
echo Please tell me what URL you see above.
echo ==========================================
pause
