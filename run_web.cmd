@echo off
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0tools\run_web.ps1"
exit /b %ERRORLEVEL%
