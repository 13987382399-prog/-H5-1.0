@echo off
echo ========================================================
echo       NUCLEAR RESET: FORCE UPDATE SERVER CODE
echo ========================================================
echo.
echo This script will:
echo 1. Force push local changes to GitHub (just in case).
echo 2. DELETE the current server folder completely.
echo 3. RE-CLONE the repository from scratch.
echo 4. Re-install dependencies and restart PM2.
echo.
pause

echo.
echo [1/2] Pushing local changes to GitHub...
git add .
git commit -m "Nuclear reset force update"
git push origin master
if %errorlevel% neq 0 (
    echo.
    echo WARNING: Git push might have failed. Checking if we can proceed...
    echo If you are sure the remote repo is up to date, press any key.
    pause
)

echo.
echo [2/2] Connecting to server to perform NUCLEAR RESET...
echo.
echo Executing remote commands...
ssh root@8.137.59.55 "echo '--- BACKING UP ENV ---' && cp /var/www/kunming-guide/.env /tmp/.env.bak 2>/dev/null || echo 'No .env found'; echo '--- STOPPING PM2 ---' && pm2 delete all; echo '--- REMOVING OLD FILES ---' && rm -rf /var/www/kunming-guide && echo '--- CLONING NEW CODE ---' && git clone https://github.com/13987382399-prog/-H5-1.0.git /var/www/kunming-guide && cd /var/www/kunming-guide && echo '--- RESTORING ENV ---' && cp /tmp/.env.bak .env 2>/dev/null || echo 'No backup to restore'; echo '--- INSTALLING DEPS ---' && npm install && echo '--- STARTING PM2 ---' && pm2 start server.js --name kunming-guide && pm2 save && echo '--- VERIFYING VERSION ---' && cat package.json"

echo.
echo ========================================================
echo If you see version 1.1.6 above, the update was SUCCESSFUL.
echo ========================================================
pause
