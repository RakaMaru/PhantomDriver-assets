@echo off
setlocal enabledelayedexpansion
echo.
echo === Updating version.json ===

set ASSETS=C:\common\Arduino\PhantomDriver-assets

rem --- PhantomKernel ---
if exist "%ASSETS%\release\PhantomKernel.ino.bin" (
    for %%F in ("%ASSETS%\release\PhantomKernel.ino.bin") do (
        set "date=%%~tF"
        set "PK_VER=!date:~6,4!.!date:~0,2!.!date:~3,2!"
    )
) else set "PK_VER=1970.01.01"

rem --- GhostForge ---
if exist "%ASSETS%\dev\GhostForge.ino.bin" (
    for %%F in ("%ASSETS%\dev\GhostForge.ino.bin") do (
        set "date=%%~tF"
        set "GF_VER=!date:~6,4!.!date:~0,2!.!date:~3,2!-dev"
    )
) else set "GF_VER=1970.01.01-dev"

(
echo {
echo   "PhantomKernel": { "version": "%PK_VER%", "url": "https://raw.githubusercontent.com/RakaMaru/PhantomDriver-assets/main/release/PhantomKernel.ino.bin" },
echo   "GhostForge":    { "version": "%GF_VER%", "url": "https://raw.githubusercontent.com/RakaMaru/PhantomDriver-assets/main/dev/GhostForge.ino.bin" }
echo }
) > "%ASSETS%\version.json"

echo version.json updated
echo   PhantomKernel → %PK_VER%
echo   GhostForge    → %GF_VER%
echo.