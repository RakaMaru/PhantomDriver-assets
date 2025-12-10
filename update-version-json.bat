@echo off
setlocal enabledelayedexpansion
echo.
echo === Updating version.json ===

set ASSETS=C:\common\Arduino\PhantomDriver-assets

rem Version numbers now come from deploy scripts using .elf timestamp
if not defined PK_VER set "PK_VER=1970.01.01.0000
if not defined GF_VER set "GF_VER=1970.01.01.0000-dev"

rem Extract YYYY.MM.DD.HHMM from each file's own timestamp
set "PK_VER=%PK_TIME:~6,4%.%PK_TIME:~0,2%.%PK_TIME:~3,2%.%PK_TIME:~11,2%%PK_TIME:~14,2%"
set "GF_VER=%GF_TIME:~6,4%.%GF_TIME:~0,2%.%GF_TIME:~3,2%.%GF_TIME:~11,2%%GF_TIME:~14,2%-dev"

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