@echo off 
title cleanup 
net session >nul 2>&1
if %errorLevel% == 0 (
   color 10
   echo Running System Cleanup
) else (
   COLOR 0f
   set dir=%cd%
   goto :admin_get
   exit
)
cd "%tmp%"
del /s /f /q "%tmp%\*"
rd /s /q "%tmp%\*.*"
cd "%windir%\Temp\"
del /s /f /q "C:\Windows\Temp\*"
rd /s /q "C:\Windows\Temp\*.*"
CLEANMGR /verylowdisk /d C:\
echo Finished System Cleanup
pause >nul
goto :System_Repair
:admin_get
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params = %*:"="
echo UAC.ShellExecute "%dir%\cleanup.bat", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /B

:System_Repair
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
