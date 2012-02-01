About:
-
The scripts in this folder are for managing the wifi configuration data on android powered devices.

Files:
-
####wifi_settings
 * Linux shell script for backing up and restoring wifi settings
####wifi_settings.bat
 * Windows batch script for backing up and restoring wifi settings
####README.md
 * This read me

Requirements:
-
- Android SDK http://developer.android.com/sdk/index.html
	
Syntax:
-
- wifi_settings [command] filename
####Commands
_-b_ Backs up the current wifi configuration. Backup location can optionaly be specified.
_-r_ Restores the provided wifi configuration file.
	
How To:
-
####Windows
1\. Put the .bat file in the same folder as the adb executable _(Almost always in the 'platform-tools' folder)._ `(NOTE: This is not necessary if you have set a global path variable for adb)`

2\. Open a command prompt and navigate to the folder where you just put the .bat file. 
(ex. `cd C:\android-sdk\platform-tools\`)

3a. To perform a back-up, issue the command `wifi_settings -b <filename>` where `<filename>` is the optional file name you would like the backup to have. 
(ex. `wifi_settings -b C:\wifi_settings.bak`)

3b. To restore a previous backup, issue the command `wifi_settings -r <filename>` where `<filename>` is the path the the previous backup file. 
(ex. `wifi_settings -r C:\wifi_settings.bak`)

####Linux
1\. Put the script file in the same folder as adb _(Almost always in the 'platform-tools' folder)._ `(NOTE: This is not necessary if you can access adb globaly)`

2\. Open a terminal and navigate to the folder where you just put the script file. 
(ex. `cd ~/android-sdk/platform-tools/`)

3a. To perform a back-up, issue the command `./wifi_settings -b <filename>` where `<filename>` is the optional file name you would like the backup to have. 
(ex. `./wifi_settings -b C:\wifi_settings.bak`)

3b. To restore a previous backup, issue the command `./wifi_settings -r <filename>` where `<filename>` is the path the the previous backup file. 
(ex. `./wifi_settings -r C:\wifi_settings.bak`)
