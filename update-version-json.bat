@echo off
setlocal enabledelayedexpansion
echo.
echo === Updating version.json from .elf timestamps ===
echo.

set "ASSETS=C:\common\Arduino\PhantomDriver-assets"

rem Default fallbacks
set "PK_VER=1970.01.01.0000"
set "GF_VER=1970.01.01.0000-dev"

rem ——— PhantomKernel (stable) ———
set "ELF=C:\common\Arduino\PhantomDriver\Firmware\PhantomKernel\build\esp32.esp32.esp32s3\PhantomKernel.ino.elf"
if exist "%ELF%" (
    for %%F in ("%ELF%") do set "T=%%~tF"
    set "PK_VER=!T:~6,4!.!T:~0,2!.!T:~3,2!.!T:~11,2!!T:~14,2!"
)

rem ——— GhostForge (dev) ———
set "ELF=C:\common\Arduino\PhantomDriver\Labs\GhostForge\build\esp32.esp32.esp32s3\GhostForge.ino.elf"
if exist "%ELF%" (
    for %%F in ("%ELF%") do set "T=%%~tF"
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
echo.

endlocal