@echo off
echo ==========================================
echo       Kunming Guide - Force Push v1.1.6
echo ==========================================
echo.
echo Starting push process... > push_116.log
echo.
echo 1. Checking git status... >> push_116.log
git status >> push_116.log 2>&1

echo 2. Adding all files... >> push_116.log
git add . >> push_116.log 2>&1

echo 3. Committing changes... >> push_116.log
git commit -m "fix: force update to 1.1.6" >> push_116.log 2>&1

echo 4. Pushing to remote (origin master)... >> push_116.log
git push origin master >> push_116.log 2>&1

echo 5. Verifying remote... >> push_116.log
git ls-remote origin master >> push_116.log 2>&1

echo PUSH PROCESS COMPLETED. >> push_116.log
echo Done.
