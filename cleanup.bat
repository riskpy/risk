@echo off
setlocal enabledelayedexpansion

:: Set the root directory (default to current if not provided)
set ROOT_DIR=%~1
if "%ROOT_DIR%"=="" set ROOT_DIR=%cd%

echo Deleting all *.~* and *.log files recursively...
for /R "%ROOT_DIR%" %%F in (*.~*) do (
    echo Deleting "%%F"
    del "%%F"
)
for /R "%ROOT_DIR%" %%F in (*.log) do (
    echo Deleting "%%F"
    del "%%F"
)

echo Done.
pause
