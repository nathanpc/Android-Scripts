## andpack
**Developed by Nathan Campos**

A script to automate the Android reverse engineering. With one single command you can easily decompile or compile any APK. The application while in the compile mode, will sign the APK, uninstall the original version from your phone (if there is any version installed) and will also install the edited one. All with one single command.

### Requirements

 * apktool
 * adb (Android SDK)
 * Bash (Shell Script)

### Usage

Here is how to use the application to decompile an APK:

    $ andpack -d your.app.class.here

*Where the `your.app.class.here` is the name of the APK with or without it's extension (.apk)*

And here is the way of using my script to compile an apk:

    $ andpack -b your.app.class.here

*Where the `your.app.class.here` is the folder name, where all your decompiled files are*

Don't forget to edit the variables `$pass`, `$kalias` and `$keyst` before using the application. What you need to add on each part is commented on the same line of the variables.

### Arguments

* -d [PATH TO APK] Decompiles an apk

* -b [PATH TO DECOMPILED CONTENTS] Compiles an apk

* -k [PATH TO KEYSTORE] Overrides the keystore location set in the script

* -p [KEYSTORE PASSWORD] Overrides the keystore password set in the script

* -a [KEYSTORE ALIAS] Overrides the keystore alias set in the script

* -i Used with '-b' installs the compiled apk to a connected device

**For educational purposes only**
