@echo off 
title System repair
net session >nul 2>&1
if %errorLevel% == 0 (
   color 2F
   echo Running system repair
) else (
   COLOR 0f
   set dir=%cd%
   goto :admin_get
   exit
)
sfc /scannow
Dism /Online /Cleanup-Image /CheckHealth
Dism /Online /Cleanup-Image /ScanHealth
Dism /Online /Cleanup-Image /RestoreHealth
sfc /scannow
echo Done system repair
echo Press any key to exit.
pause >nul

:admin_get
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"="
    echo UAC.ShellExecute "%dir%\System repair.bat", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B