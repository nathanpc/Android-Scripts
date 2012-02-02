About:
-
A collection of scripts for performing special tasks dealing with adb.

Files:
-
####adb_global
 * Linux shell script used to configure adb to be globally accessible _(ie. Can be run from anywhere by typing 'adb')_
 
####README.md
 * This read me

Requirements:
-
- Android SDK http://developer.android.com/sdk/index.html
	
Syntax:
-

###adb_global -
- ./adb_global [ARGUMENTS] PathToAdb

####Arguments

 * _-h -H_ Creates a symbolic link in the users bin folder (~/bin/) rather than using the global PATH variable
	
How To:
-
###Using adb_global

####Linux
1\. Execute the script with the path to adb as the only parameter 
(ex. `./adb-global ~/android-sdk/platform-tools/adb`).
_NOTE: If you want to use a symbolic link in your bin folder (~/bin/) instead of adding adb to the global path variable use the -h argument._

2\. If adb isn't globally accessible immediately after running the script restart your computer and that should fix it.