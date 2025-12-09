@echo off
echo.
echo === Deploying PhantomKernel (stable) ===
set SRC="C:\common\Arduino\PhantomDriver\Firmware\PhantomKernel\PhantomKernel.ino.bin"

if not exist %SRC% (
    echo ERROR: PhantomKernel.ino.bin not found!
    echo Please open the PhantomKernel sketch and run "Sketch → Export compiled Binary"
    pause
    exit /b 1
)

copy %SRC% "C:\common\Arduino\PhantomDriver-assets\release\PhantomKernel.ino.bin" /Y
echo Copied → release\PhantomKernel.ino.bin

call "%~dp0update-version-json.bat"
echo.
echo PhantomKernel deployed successfully!
pause