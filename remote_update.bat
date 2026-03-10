@echo off
echo ==========================================
echo       Kunming Guide - Remote Update
echo ==========================================
echo.
echo Connecting to server (8.137.59.55) to pull updates...
echo.
ssh root@8.137.59.55 "cd /var/www/kunming-guide && git pull origin master && npm install && pm2 restart kunming-guide && pm2 save"
echo.
echo ==========================================
echo Update command finished.
echo If you saw 'Already up to date' or 'Updating...', it worked.
echo Check the version on the website now.
echo ==========================================
pause
