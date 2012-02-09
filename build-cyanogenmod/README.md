About
-
A script for building cyanogen mod for various devices.

Currently Supported Devices
-

* Epic 4g _epicmtd_
* Nexus S 4g _crespo4g_ 

Syntax
-

`build-cm [DEVICES]`

####Arguments

* -i --ignore-errors Ignores all errors and attempts to complete. This does not hide error messages.

* -b [BRANCH] Overides the default branch set inside the script.

* -s --setup Sets up directories, installs MOST required dependancys (See Known Issues/Limitations), installs repo, and fetches prebuilt packages.

Known Issues/Limitations
-
* Setup does not install the Android Sdk (Required for ADB).

* Setup: Repo may not be regularly usable until after a reboot (ie. Typing 'repo' in a terminal will prompt 'command not found').

How To
-

1. Change the two variables "BUILDDIR" and "BRANCH" inside the script to your preference.

2. Run the script setup. `build-cm --setup`

3. Run the script with your device(s) as argument(s) `build-cm epicmtd crespo4g`

####Note. It is also possible to combine steps 2 and 3 ie. 
`build-cm --setup epicmtd`

Disclaimer
-

This is an alpha release and should thus be treated as one!

There will probably be errors, and there is a good chance this will not work in it's current state.

Any builds you create, and anything you flash to your device, is YOUR responsability.

The creator and contributors of this script take no responsability if something happens to your device 
as a result of flashing a rom or anything else that is built or created by this script.

####Building ICS/CM9

Building and flashing ICS/CM9 is not advised as most devices are only at the alpha stage in development.
Any ICS/CM9 builds should be considered **!!!FLASH AT YOUR OWN RISK!!!**

