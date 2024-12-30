@echo off

REM Ensure the Windows Time service is running
sc query w32time | find "RUNNING" >nul
if %errorlevel% neq 0 (
    echo Starting Windows Time service...
    net start w32time
)

REM Stop the Windows Time service to reconfigure
net stop w32time

REM Configure the time server to fi.pool.ntp.org
w32tm /config /manualpeerlist:"fi.pool.ntp.org" /syncfromflags:manual /reliable:YES /update

REM Start the Windows Time service
net start w32time

REM Force synchronization
w32tm /resync

echo Time server has been changed to fi.pool.ntp.org and synchronized.
pause
