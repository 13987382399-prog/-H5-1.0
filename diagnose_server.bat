@echo off
echo ==========================================
echo       Kunming Guide - Server Diagnosis
echo ==========================================
echo.
echo Connecting to server (8.137.59.55) to check status...
echo.
echo [LOCAL] Time: %TIME% > server_diag.txt

echo 1. Checking Current User... >> server_diag.txt
ssh root@8.137.59.55 "whoami" >> server_diag.txt 2>&1

echo 2. Checking File System Version... >> server_diag.txt
ssh root@8.137.59.55 "cat /var/www/kunming-guide/package.json | grep version" >> server_diag.txt 2>&1

echo 3. Checking Git Commit on Server... >> server_diag.txt
ssh root@8.137.59.55 "cd /var/www/kunming-guide && git log -1 --oneline" >> server_diag.txt 2>&1

echo 4. Checking PM2 Process List (ROOT)... >> server_diag.txt
ssh root@8.137.59.55 "pm2 list" >> server_diag.txt 2>&1

echo 5. Checking PM2 Process Info... >> server_diag.txt
ssh root@8.137.59.55 "pm2 describe kunming-guide | grep 'pm_cwd'" >> server_diag.txt 2>&1

echo ==========================================
echo Diagnosis complete. Checking results...
type server_diag.txt
echo ==========================================
pause
