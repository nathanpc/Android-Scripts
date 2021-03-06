About:
-
A collection of scripts for managing the wifi configuration data on android powered devices.

Files:
-
####wifi_settings
 * Linux shell script for backing up and restoring wifi settings
 
####wifi_settings.bat
 * Windows batch script for backing up and restoring wifi settings

Requirements:
-
- Android SDK http://developer.android.com/sdk/index.html
	
Syntax:
-
###wifi_settings
- ./wifi_settings [ARGUMENTS] filename

####Arguments
* -b [BACKUP LOCATION] Backs up the current wifi configuration to the file specified.

* -r [BACKUP LOCATION] Restores the provided wifi configuration backup file.

###wifi_settings.bat
- wifi_settings [ARGUMENT] filename

####Arguments
* -b [BACKUP LOCATION (_OPTIONAL_)] Backs up the current wifi configuration. Backup location can optionally be specified.

* -r [BACKUP LOCATION] Restores the provided wifi configuration file.
	
How To:
-
###Backup and Restore

####Windows
1\. Put the .bat file in the same folder as the adb executable _(Almost always in the 'platform-tools' folder)._ `(NOTE: This is not necessary if you have set a global path variable for adb)`

2\. Open a command prompt and navigate to the folder where you just put the .bat file. 
(ex. `cd C:\android-sdk\platform-tools\`)

3a. To perform a back-up, issue the command `wifi_settings -b <filename>` where `<filename>` is the optional file name you would like the backup to have. 
(ex. `wifi_settings -b C:\wifi_settings.bak`)

3b. To restore a previous backup, issue the command `wifi_settings -r <filename>` where `<filename>` is the path the the previous backup file. 
(ex. `wifi_settings -r C:\wifi_settings.bak`)

####Linux
1\. Put the script file in the same folder as adb _(Almost always in the 'platform-tools' folder)._ `(NOTE: This is not necessary if you can access adb globally)`

2\. Open a terminal and navigate to the folder where you just put the script file. 
(ex. `cd ~/android-sdk/platform-tools/`)

3a. To perform a back-up, issue the command `./wifi_settings -b <filename>` where `<filename>` is the file name you would like the backup to have. 
(ex. `./wifi_settings -b ~/wifi_settings.bak`)

3b. To restore a previous backup, issue the command `./wifi_settings -r <filename>` where `<filename>` is the path the the previous backup file. 
(ex. `./wifi_settings -r ~/wifi_settings.bak`)
