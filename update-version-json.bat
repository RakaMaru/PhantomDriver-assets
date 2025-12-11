@echo off
setlocal enabledelayedexpansion
echo.
echo === Updating version.json (using .ino.bin timestamp===
echo.

set "ASSETS=C:\common\Arduino\PhantomDriver-assets"

rem Default fallbacks (never written to disk)
set "PK_VER=1970.01.01.0000"
set "GF_VER=1970.01.01.0000-dev"

rem PhantomKernel (stable)
if exist "%ASSETS%\release\PhantomKernel.ino.bin" (
    for %%F in ("%ASSETS%\release\PhantomKernel.ino.bin") do set "T=%%~tF"
    set "PK_VER=!T:~6,4!.!T:~0,2!.!T:~3,2!.!T:~11,2!!T:~14,2!"
)

rem GhostForge (dev)
if exist "%ASSETS%\dev\GhostForge.ino.bin" (
    for %%F in ("%ASSETS%\dev\GhostForge.ino.bin") do set "T=%%~tF"
    set "GF_VER=!T:~6,4!.!T:~0,2!.!T:~3,2!.!T:~11,2!!T:~14,2!-dev"
)

(
echo {
echo   "PhantomKernel": { "version": "%PK_VER%", "url": "https://raw.githubusercontent.com/RakaMaru/PhantomDriver-assets/main/release/PhantomKernel.ino.bin" },
echo   "GhostForge":    { "version": "%GF_VER%", "url": "https://raw.githubusercontent.com/RakaMaru/PhantomDriver-assets/main/dev/GhostForge.ino.bin" }
echo }
) > "%ASSETS%\version.json"

echo version.json updated
echo   PhantomKernel -> %PK_VER%
echo   GhostForge    -> %GF_VER%

rem Clean up any leftover placeholder files
for %%X in (
    "1970.01.01.0000"
    "1970.01.01.0000-dev"
    "2025.12.10.*"
) do (
    if exist "%ASSETS%\%%~X" (
        del "%ASSETS%\%%~X" >nul 2>&1
        echo Cleaned up old file: %%~X
    )
)

echo.
echo All done - repo stays clean!
echo.