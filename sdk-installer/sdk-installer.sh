#!/bin/bash
#
# Android SDK Installer Script: A script used to install the Android SDK, Eclipse, and Open JDK/JRE
#
# Copyright (C) 2012  Ryan Esteves
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Alot of this script was referenced from https://gist.github.com/1026610

androidurl="http://developer.android.com/sdk/index.html"

function error_exit()
{
    echo "ERROR: $1" 1>&2
    exit 1
}

if [[ $UID != 0 ]]; then
    echo "* Please type sudo $0 $*to use this. *"
    exit 1
fi

echo "Updating apt-get..."
apt-get > /dev/null
echo 

echo "Welcome to the Android SDK installer!"
echo "This installer will download and install the Android SDK, Eclipse Classic, and Open JDK."
echo 
echo 

echo "Please enter the folder where you would like the Android SDK to be installed "
read -e -i "/usr/local/android-sdk" androiddir

if [ -d $androiddir ]; then
echo "Directory exists skipping creation."
else
echo "Creating directory '"$androiddir"'."
mkdir -p $androiddir
fi

echo "Downloading the SDK..."
for a in $( wget -qO- $androidurl | egrep -o "http://dl.google.com[^\"']*linux.tgz" ); do
	echo "Downloading from:" $a
	echo -n "    "
    wget --progress=dot $a 2>&1 | grep --line-buffered "%" | \
        sed -u -e "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
    echo -ne "\b\b\b\b"
    echo "Performing Installation..."
    echo "  Extracting..."
    tar --wildcards --no-anchored -xvzf android-sdk_*-linux.tgz 1>/dev/null || error_exit "Extracting archive failed."
    echo "  Moving stuff into place..."
    cp -r android-sdk-linux $androiddir || error_exit "Moving extracted files failed."
    echo "  Setting permmissions..."
    chmod 777 -R $androiddir || error_exit "Setting permissions failed."
    echo "  Removing temporary files..."
    rm -rf android-sdk-linux || echo "Removing temporary files failed."
    rm android-sdk_*-linux.tgz || echo "Removing downloaded archive failed."
    if grep -q /usr/local/android-sdk/platform-tools /etc/bash.bashrc; 
    then
        echo "ADB environment variable already set up"
    else
        echo "  Setting ADB environment variable..."
        echo "export PATH=$PATH:/usr/local/android-sdk/platform-tools" >> /etc/bash.bashrc
    fi
    echo "  DONE"
	break;
done

echo ""
echo "Checking if Open JDK is installed"
c=openjdk-7-jdk
d=openjdk-7-jre

if [[ $(dpkg-query -f'${Status}' --show $c 2>/dev/null) = *\ installed ]]; then
    echo $c" is already installed, skipping."
    c=
fi
if [[ $(dpkg-query -f'${Status}' --show $d 2>/dev/null) = *\ installed ]]; then
    echo $d" is already installed, skipping."
    d=
fi
if [[ $c || $d ]]; then
    echo
    read -p "This will install Open JDK 7 on your system. Continue? [Y,n]: " -n 1 javachoice
    javachoice=${javachoice:-Y}
    case $javachoice in
        [Yy]) echo "Installing..." && apt-get install $c $d && echo "Success!" || "Open JDK or Open JRE install failed.";;
        [Nn]) ;;
        *) error_exit "Invalid choice. Aborting."
    esac
fi

c=eclipse
echo "Checking if Eclipse is installed"
if [[ $(dpkg-query -f'${Status}' --show $c 2>/dev/null) = *\ installed ]]; then
    echo "Eclipse is already installed, skipping."
    echo ""
else
    read -p "This will install Eclipse on your system. Continue? [Y,n]: " -n 1 eclipsechoice
    eclipsechoice=${eclipsechoice:-Y}
    case $eclipsechoice in
        [Yy]) echo "Installing..." && apt-get install $c 2>&1 > /dev/null && echo "Success!" || "Eclipse install failed.";;
        [Nn]) ;;
        *) error_exit "Invalid choice. Aborting."
    esac
fi

echo 
exit
