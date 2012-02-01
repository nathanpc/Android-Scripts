Requirements:
	- Android SDK (for adb) http://developer.android.com/sdk/index.html
	
Syntax:

	wifi_settings [command] <filename>
	
	Commands -
		
		-b	Backs up the current wifi configuration. Backup location can optionaly be specified.
		-r	Restores the provided wifi configuration file.
	
How To:

	Windows - 
		1. Put the .bat file in the same folder as the adb executable (Almost always in the 'platform-tools' folder) 
			(NOTE: This is not necessary if you have set a global path variable for adb)
		2. Open a command prompt and navigate to the folder where you just put the .bat file. (ex. cd C:\android-sdk\platform-tools\)
		3a. To perform a back-up, issue the following command 'wpa_supplicant_utility -b <filename>' where <filename> is the optional file name you would like the backup to have. (ex. wpa_supplicant_utility -b C:\wifi_settings.bak)
		3b. To restore a previous backup, issue the following command 'wpa_supplicant_utility -r <filename>' where <filename> is the path the the previous backup file. (ex. wpa_supplicant_utility -r C:\wifi_settings.bak)