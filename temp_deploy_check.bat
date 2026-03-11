@echo off
echo Checking SSH...
ssh -o BatchMode=yes -o ConnectTimeout=5 root@8.137.59.55 "echo SSH_OK" > ssh_check.log 2>&1
if %errorlevel% neq 0 (
    echo SSH_FAIL > ssh_status.txt
) else (
    echo SSH_OK > ssh_status.txt
)

echo Git Pushing...
git add .
git commit -m "Auto-deploy"
git push origin master > git_push.log 2>&1
if %errorlevel% neq 0 (
    echo GIT_FAIL > git_status.txt
) else (
    echo GIT_OK > git_status.txt
)
