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

tempdir="$HOME/android-sdk-installer-temp/"
eclipseurl="http://www.eclipse.org/downloads/download.php?file=/eclipse/downloads/drops/R-3.7.1-201109091335/eclipse-SDK-3.7.1-linux-gtk.tar.gz&protocol=http&format=xml"
eclipsefile="eclipse-SDK*-linux-gtk.tar.gz"
androidurl="http://developer.android.com/sdk/index.html"
androidfile="android-sdk*-linux.tgz"

# Exit execution on error (Disable for debugging)
set -e

if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Updating apt-get..."
apt-get -q --quiet update
echo 

echo "Welcome to the Android SDK installer!"
echo "This installer will download and install the Android SDK, Eclipse Classic, and Open JDK."
echo 
echo 
echo "Please enter the folder where you would like the Android SDK to be installed "
read -e -i "$HOME/android-sdk/" androiddir
echo 
read -p "Would you like to install Eclipse to a custom directory or use apt-get to install? ([C]ustom, [A]pt-get [Default]): " -n 1 eclipsechoice
eclipsechoice=${eclipsechoice:-A}
echo
if [ $eclipsechoice == "C" ] || [ $eclipsechoice == "c" ]; then
echo
echo "Please enter the folder where you would like Eclipse to be installed "
read -e -i "$HOME/eclipse/" eclipsedir
else 
if [ $eclipsechoice != "A" ] && [ $eclipsechoice != "a" ]; then
echo "Invalid choice aborting"
exit 1
fi
fi

echo 
echo "Creating directorys..."
if [ -d $tempdir ]; then
echo "Temp folder exists skipping"
else
echo "Creating temp folder '"$tempdir"'..."
mkdir $tempdir
fi

cd $tempdir

if [ -d $androiddir ]; then
echo "Android SDK directory exists skipping"
else
echo "Creating Android SDK directory '"$androiddir"'"
mkdir $androiddir
fi

if [ $eclipsechoice == "C" ] || [ $eclipsechoice == "c" ]; then
if [ -d $eclipsedir ]; then
echo "Eclipse directory exists skipping"
else
echo "Creating Eclipse directory '"$eclipsedir"'"
mkdir $eclipsedir
fi
fi


echo ""
echo "Starting download(s)..."
if [ $eclipsechoice == "C" ] || [ $eclipsechoice == "c" ]; then
if [ ! -s $tempdir$eclipsefile ]; then
echo "Downloading Eclipse..."
for a in $( wget -qO- $eclipseurl | egrep -o "http://[^\"']*linux-gtk.tar.gz" ); do
	echo "Downloading from:" $a
	echo -n "    "
    wget --progress=dot $a 2>&1 | grep --line-buffered "%" | \
        sed -u -e "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
    echo -ne "\b\b\b\b"
    echo " DONE"
	break;
done
else
echo "Eclipse download already exists!"
fi
fi

if [ ! -s $tempdir$androidfile ]; then
echo "Downloading Android SDK..."
for a in $( wget -qO- $androidurl | egrep -o "http://dl.google.com[^\"']*linux.tgz" ); do
	echo "Downloading from:" $a
	echo -n "    "
    wget --progress=dot $a 2>&1 | grep --line-buffered "%" | \
        sed -u -e "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
    echo -ne "\b\b\b\b"
    echo " DONE"
	break;
done
else
echo "Android SDK download already exists!"
fi


echo ""
echo "Extracting files..."
if [ $eclipsechoice == "C" ] || [ $eclipsechoice == "c" ]; then
if [ -s $eclipsefile ]; then
echo "Extracting Eclipse files..."
tar --wildcards -xzf $eclipsefile
else
echo "Extracting Eclipse failed: Download does not exist?"
exit 1
fi
fi

if [ -s $androidfile ]; then
echo "Extracting Android SDK Files..."
tar --wildcards -xzf $androidfile
else
echo "Extracting Android SDK failed: Download does not exist?"
exit 1
fi
echo "Success!"


echo ""
echo "Copying Files..."
if [ -d "android-sdk-linux" ]; then
echo "Copying Android SDK..."
cp -R android-sdk-linux/* $androiddir
else
echo "Android SDK download files not found"
exit 1
fi

if [ $eclipsechoice == "C" ] || [ $eclipsechoice == "c" ]; then
if [ -d "eclipse" ]; then
echo "Copying Eclipse..."
cp -R eclipse/* $eclipsedir
else
echo "Eclipse download files not found"
exit 1
fi
fi
echo "Success!"


echo ""
echo "Fixing directory permissions..."
if [ $eclipsechoice == "C" ] || [ $eclipsechoice == "c" ]; then
chmod 777 "$eclipsedir" -R
fi
chmod 777 "$tempdir" -R
chmod 777 "$androiddir" -R
echo "Success!"


echo ""
echo "Cleaning up..."
if [ -d $tempdir ]; then
rm -r $tempdir
fi
echo "Success!"

echo ""
echo "Checking if Open JDK is installed"
c=openjdk-7-jdk
d=openjdk-7-jre
if [[ $(dpkg-query -f'${Status}' --show $c 2>/dev/null) = *\ installed ]]; then
echo $c" is already installed, skipping."
c=0
fi
if [[ $(dpkg-query -f'${Status}' --show $d 2>/dev/null) = *\ installed ]]; then
echo $d" is already installed, skipping."
d=0;
fi
if [ $c != "0" ] || [ $d != "0" ]; then
echo
read -p "This will install Open JDK 7 on your system. Continue? [Y,n]: " -n 1 javachoice
javachoice=${javachoice:-Y}
echo ""
if [ $javachoice == "Y" ] || [ $javachoice == "y" ]; then
apt-get --force-yes -y -q install $c $d 2>/dev/null
echo "Success!"
else
if [ $javachoice != "N" ] && [ $javachoice != "n" ]; then
echo "Invalid choice aborting"
exit 1
fi
fi
fi

if [ $eclipsechoice == "A" ] || [ $eclipsechoice == "a" ]; then
c=eclipse
echo ""
echo "Checking if Eclipse is installed"
if [[ $(dpkg-query -f'${Status}' --show $c 2>/dev/null) = *\ installed ]]; then
echo "Eclipse is already installed, skipping."
echo ""
read -p "This will install Eclipse on your system. Continue? [Y,n]: " -n 1 eclipsechoice
eclipsechoice=${eclipsechoice:-Y}
echo ""
if [ $eclipsechoice == "Y" ] || [ $eclipsechoice == "y" ]; then
apt-get --force-yes -y -q install $c 2>/dev/null
else
if [ $eclipsechoice != "N" ] && [ $eclipsechoice != "n" ]; then
echo "Invalid choice aborting"
exit 1
fi
fi
fi
fi


echo 
read -p "Install Completed! Press any key to exit..." -n 1
echo 
exit 0
