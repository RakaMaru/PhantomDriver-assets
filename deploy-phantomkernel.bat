@echo off
echo.
echo === Deploying PhantomKernel (stable) ===
set "SRC=C:\common\Arduino\PhantomDriver\Firmware\PhantomKernel\build\esp32.esp32.esp32s3\PhantomKernel.ino.bin"
set "ELF=C:\common\Arduino\PhantomDriver\Firmware\PhantomKernel\build\esp32.esp32.esp32s3\PhantomKernel.ino.elf"

if not exist "%ELF%" (
    echo.
    echo ERROR: PhantomKernel.ino.elf not found!
    echo You must COMPILE the sketch first (Verify or Upload).
    echo Export Compiled Binary alone is not enough.
    echo.
    pause
    exit /b 1
)

if not exist "%SRC%" (
    echo ERROR: PhantomKernel.ino.bin not found!
    echo Please run "Sketch → Export compiled Binary" after compiling.
    echo Expected: %SRC%
    pause
    exit /b 1
)

rem Use ELF timestamp = true compile time (never drifts)
for %%F in ("%ELF%") do set "PK_TIME=%%~tF"
set "PK_VER=%PK_TIME:~6,4%.%PK_TIME:~0,2%.%PK_TIME:~3,2%.%PK_TIME:~11,2%%PK_TIME:~14,2%"

copy "%SRC%" "C:\common\Arduino\PhantomDriver-assets\release\PhantomKernel.ino.bin" /Y
echo Copied → release\PhantomKernel.ino.bin

call "%~dp0update-version-json.bat"
echo.
echo PhantomKernel deployed successfully!
pause