@echo off
echo ==========================================
echo       Git Diagnostic
echo ==========================================
echo.
echo 1. Local HEAD Commit: > git_diag.txt
git log -1 >> git_diag.txt 2>&1
echo. >> git_diag.txt
echo 2. Git Status: >> git_diag.txt
git status >> git_diag.txt 2>&1
echo. >> git_diag.txt
echo 3. Remote Master Head: >> git_diag.txt
git ls-remote origin master >> git_diag.txt 2>&1
echo. >> git_diag.txt
echo Done.
