@echo off
echo.
echo === Deploying GhostForge (dev) ===
set "SRC=C:\common\Arduino\PhantomDriver\Labs\GhostForge\build\esp32.esp32.esp32s3\GhostForge.ino.bin"
set "ELF=C:\common\Arduino\PhantomDriver\Labs\GhostForge\build\esp32.esp32.esp32s3\GhostForge.ino.elf"

if not exist "%ELF%" (
    echo.
    echo ERROR: GhostForge.ino.elf not found!
    echo You must COMPILE the sketch first (Verify or Upload).
    echo Export Compiled Binary alone is not enough.
    echo.
    pause
    exit /b 1
)

if not exist "%SRC%" (
    echo ERROR: GhostForge.ino.bin not found!
    echo Please run "Sketch → Export compiled Binary" after compiling.
    echo Expected: %SRC%
    pause
    exit /b 1
)

rem Use ELF timestamp = true compile time (never drifts)
for %%F in ("%ELF%") do set "GF_TIME=%%~tF"
set "GF_VER=%GF_TIME:~6,4%.%GF_TIME:~0,2%.%GF_TIME:~3,2%.%GF_TIME:~11,2%%GF_TIME:~14,2%-dev"

copy "%SRC%" "C:\common\Arduino\PhantomDriver-assets\dev\GhostForge.ino.bin" /Y
echo Copied → dev\GhostForge.ino.bin

call "%~dp0update-version-json.bat"
echo.
echo GhostForge deployed successfully!
pause