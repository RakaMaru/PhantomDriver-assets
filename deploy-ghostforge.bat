@echo off
echo.
echo === Deploying GhostForge (dev) ===
set SRC="C:\common\Arduino\PhantomDriver\Labs\GhostForge\GhostForge.ino.bin"

if not exist %SRC% (
    echo ERROR: GhostForge.ino.bin not found!
    echo Please open the GhostForge sketch and run "Sketch → Export compiled Binary"
    pause
    exit /b 1
)

copy %SRC% "C:\common\Arduino\PhantomDriver-assets\dev\GhostForge.ino.bin" /Y
echo Copied → dev\GhostForge.ino.bin

call "%~dp0update-version-json.bat"
echo.
echo GhostForge deployed successfully!
pause