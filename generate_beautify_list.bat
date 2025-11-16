@echo off
setlocal enabledelayedexpansion

:: Set the root directory (default to current if not provided)
set ROOT_DIR=%~1
if "%ROOT_DIR%"=="" set ROOT_DIR=%cd%

:: Set output file for the list of PL/SQL files
set FILE_LIST=%ROOT_DIR%\beautify_list.sql

:: Clear previous list
if exist "%FILE_LIST%" del "%FILE_LIST%"

:: File extensions to include
set EXTENSIONS=spc bdy fnc prc trg tps tpb

:: Collect all matching files recursively
for %%E in (%EXTENSIONS%) do (
    for /R "%ROOT_DIR%" %%F in (*.%%E) do (
        echo beautify %%F>>"%FILE_LIST%"
    )
)

echo exit application>>"%FILE_LIST%"

echo File list created at: %FILE_LIST%
echo You can now run the Beautifier in PL/SQL Developer using this file.
pause