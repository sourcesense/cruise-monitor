@echo off
set CURRENT_FOLDER=%~dp0

cd %CURRENT_FOLDER%
rake monitor
