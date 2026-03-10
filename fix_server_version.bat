@echo off
echo ==========================================
echo       Kunming Guide - Ultimate Fix (v1.1.6)
echo ==========================================
echo.
echo This script will:
echo 1. Check current directory on server.
echo 2. Force pull latest code (v1.1.6).
echo 3. Completely remove and restart the server process.
echo 4. Show the actual file version on disk.
echo.
pause
echo.
echo Executing on server...
ssh root@8.137.59.55 "cd /var/www/kunming-guide && echo '--- CWD ---' && pwd && echo '--- FETCHING ---' && git fetch --all && echo '--- RESETTING ---' && git reset --hard origin/master && echo '--- VERSION ON DISK ---' && cat package.json | grep version && echo '--- PM2 RELOAD ---' && pm2 delete kunming-guide; pm2 start server.js --name kunming-guide && pm2 save"
echo.
echo ==========================================
echo Check the output above.
echo 1. Did 'VERSION ON DISK' show "1.1.6"?
echo 2. Did PM2 start successfully?
echo.
echo If yes, refresh your browser (Ctrl+F5).
echo ==========================================
pause
