@echo off
git add .
git commit -m "feat: update button interaction styles and fix server scripts v1.1.3"
git push origin master > push_log.txt 2>&1
echo Done >> push_log.txt