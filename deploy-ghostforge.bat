rem this is deploy-ghostforge.bat
@echo off
echo.
echo === Deploying GhostForge (dev) ===
set "SRC=C:\common\Arduino\PhantomDriver\Labs\GhostForge\build\esp32.esp32.esp32s3\GhostForge.ino.bin"

if not exist "%SRC%" (
    echo ERROR: GhostForge.ino.bin not found!
    echo Please run "Sketch → Export compiled Binary" first.
    echo Expected location: %SRC%
    pause
    exit /b 1
)

copy "%SRC%" "C:\common\Arduino\PhantomDriver-assets\dev\GhostForge.ino.bin" /Y
echo Copied → dev\GhostForge.ino.bin

call "%~dp0update-version-json.bat"
echo.
echo GhostForge deployed successfully!
pause