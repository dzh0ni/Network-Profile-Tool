@echo off
chcp 65001 >nul
echo.
echo ================================================
echo      Network ProfileTool Launcher
echo ================================================
echo.

cd /d %~dp0
powershell -ExecutionPolicy Bypass -File NetworkProfileTool.ps1
pause