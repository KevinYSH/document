@echo off
mode con:cols=128

echo This script comes from:
echo.
echo By kevin Yen  
echo Date. 2017-09-07
echo.

set str="%~n0"   
rem echo %str%

rem set teraterm_path=ttermpro.exe
rem echo %teraterm_path%

if exist "%ProgramFiles(x86)%\teraterm\ttermpro.exe" set teraterm_path=%ProgramFiles(x86)%\teraterm
echo "%teraterm_path%"

if exist "%ProgramFiles%\teraterm\ttermpro.exe" set teraterm_path=%ProgramFiles(x86)%\teraterm
echo "%teraterm_path%"

for /f "delims=_ tokens=1" %%a in (%str%) do (  
    set COM_MODE=%%a
)
echo command mode = %COM_MODE%

if [%COM_MODE%] == [COM] goto _COM
if [%COM_MODE%] == [ssh] goto _SSH


:_COM
for /f "delims=_ tokens=2" %%b in (%str%) do (  
    set COM_PORT=%%b
    )
for /f "delims=_ tokens=3" %%b in (%str%) do (  
    set BAUD=%%b
    )
START /D "%teraterm_path%" ttermpro.exe /C=%COM_PORT% /BAUD=%BAUD%
exit

:_SSH
for /f "delims=_ tokens=2" %%b in (%str%) do (  
    set server_IP=%%b
    )
rem echo %server_IP% 
START /D "%teraterm_path%" ttermpro.exe %server_IP%:22 /ssh /auth=password /user=kevin /passwd="000000"
exit

:end

rem PAUSE