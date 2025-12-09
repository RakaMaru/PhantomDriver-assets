@echo off
setlocal enabledelayedexpansion
echo.
echo === Updating version.json ===

set ASSETS=C:\common\Arduino\PhantomDriver-assets

rem --- PhantomKernel ---
if exist "%ASSETS%\release\PhantomKernel.ino.bin" (
    for %%F in ("%ASSETS%\release\PhantomKernel.ino.bin") do (
        set "date=%%~tF"
        rem Extract YYYY MM DD HH MM from current time
        for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
        set "yyyy=!dt:~0,4!"
        set "mm=!dt:~4,2!"
        set "dd=!dt:~6,2!"
        set "hh=!dt:~8,2!"
        set "min=!dt:~10,2!"
        set "PK_VER=!yyyy!.!mm!.!dd!.!hh!!min!"
        set "GF_VER=!yyyy!.!mm!.!dd!.!hh!!min!-dev"
    )
) else set "PK_VER=1970.01.01"

rem --- GhostForge ---
if exist "%ASSETS%\dev\GhostForge.ino.bin" (
    for %%F in ("%ASSETS%\dev\GhostForge.ino.bin") do (
        set "date=%%~tF"
        rem Extract YYYY MM DD HH MM from current time
        for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
        set "yyyy=!dt:~0,4!"
        set "mm=!dt:~4,2!"
        set "dd=!dt:~6,2!"
        set "hh=!dt:~8,2!"
        set "min=!dt:~10,2!"
        set "PK_VER=!yyyy!.!mm!.!dd!.!hh!!min!"
        set "GF_VER=!yyyy!.!mm!.!dd!.!hh!!min!-dev"
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