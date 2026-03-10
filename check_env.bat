@echo off
if exist node_modules (echo node_modules exists) else (echo node_modules missing) > env_check.txt
if exist .env (echo .env exists) else (echo .env missing) >> env_check.txt
