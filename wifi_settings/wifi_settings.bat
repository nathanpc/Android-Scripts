@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

set command=%1
set filename=%~2

if [%command%]==[] goto helpprompt

if [%command%]==[-b] (
echo.
	call :backup
	goto end
) else if [%command%]==[-r] (
echo.
	if [!filename!]==[] (
		echo No configuration file provided!
		goto helpprompt 
	) else if exist !filename! (
		call :restore
	) else (
		echo File does not exist !filename!
	)
	goto end
) else if [%command%]==[/?] (
	goto helpprompt
) else (
	echo Invalid argument %command%
	goto helpprompt
)

:backup
echo Backing up wifi configuration...
if [!filename!]==[] (
	for /f "tokens=1-5 delims=/ " %%d in ("%date%") do  set "filename=wpa_supplicant_%%e-%%f-%%g"
	for /f "tokens=1-5 delims=:" %%d in ("%time%") do set "filename=!filename!_%%d-%%e.conf"
) else (
	if exist !filename! (
		choice /C:YN /M "!filename! already exists. Overwrite?"
		if errorlevel 2 goto end
	)
)
echo Please connect your device now
call :connectdevice
echo Downloading wifi configuration to !filename!...
adb pull /data/misc/wifi/wpa_supplicant.conf "!filename!"
echo Done
goto :EOF

:restore
echo Restoring wifi configuration...
echo Connecting to device...
call :connectdevice
echo Pushing wifi configuration to 
adb get-serialno
adb push !filename! /data/misc/wifi/wpa_supplicant.conf
echo Fixing permissions and ownership...
adb shell chown system.wifi /data/misc/wifi/wpa_supplicant.conf
adb shell chmod 666 /data/misc/wifi/wpa_supplicant.conf
echo Done
goto :EOF

:connectdevice
adb root 2> nul > nul
echo Waiting for device to connect...
adb wait-for-device
goto :EOF

:helpprompt
echo.
echo Usage: %0 [OPTION] [CONFIG FILE LOCATION]
echo 	-b	Backs up the current wifi configuration. Backup location can optionaly be specified.
echo 	-r	Restores the provided wifi configuration file.
echo.
goto :EOF

:end
echo.