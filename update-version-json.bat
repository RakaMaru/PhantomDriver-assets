rem this is update-version-json.bat - ROBUST VERSION USING POWERSHELL (locale-independent 24-hour)
@echo off
setlocal enabledelayedexpansion
echo.
echo === Updating version.json (locale-independent 24-hour timestamps via PowerShell) ===
echo.

set "ASSETS=C:\common\Arduino\PhantomDriver-assets"

rem Default fallbacks
set "PK_VER=1970.01.01.0000"
set "GF_VER=1970.01.01.0000-dev"

rem PhantomKernel (stable)
if exist "%ASSETS%\release\PhantomKernel.ino.bin" (
    for /f "delims=" %%T in ('powershell -NoProfile -Command "(Get-Item '%ASSETS%\release\PhantomKernel.ino.bin').CreationTime.ToString('yyyyMMddHHmm')"' ) do set "TS=%%T"
    if "!TS!" neq "" (
        set "PK_VER=!TS:~0,4!.!TS:~4,2!.!TS:~6,2!.!TS:~8,4!"
    ) else (
        echo WARNING: Could not read timestamp for PhantomKernel.ino.bin - using fallback
    )
)

rem GhostForge (dev)
if exist "%ASSETS%\dev\GhostForge.ino.bin" (
    for /f "delims=" %%T in ('powershell -NoProfile -Command "(Get-Item '%ASSETS%\dev\GhostForge.ino.bin').CreationTime.ToString('yyyyMMddHHmm')"' ) do set "TS=%%T"
    if "!TS!" neq "" (
        set "GF_VER=!TS:~0,4!.!TS:~4,2!.!TS:~6,2!.!TS:~8,4!-dev"
    ) else (
        echo WARNING: Could not read timestamp for GhostForge.ino.bin - using fallback
    )
)

(
echo {
echo   "PhantomKernel": { "version": "%PK_VER%", "url": "https://raw.githubusercontent.com/RakaMaru/PhantomDriver-assets/main/release/PhantomKernel.ino.bin" },
echo   "GhostForge":    { "version": "%GF_VER%", "url": "https://raw.githubusercontent.com/RakaMaru/PhantomDriver-assets/main/dev/GhostForge.ino.bin" }
echo }
) > "%ASSETS%\version.json"

echo version.json updated successfully
echo   PhantomKernel: %PK_VER%
echo   GhostForge:    %GF_VER%

echo.
echo All done - now uses true 24-hour timestamps via PowerShell (no regional issues)!
echo.
rem pause