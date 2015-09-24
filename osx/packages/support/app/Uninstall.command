#!/bin/bash
echo
echo
echo "@@PRODUCTNAME@@ uninstallation script"
echo
echo "The following commands are executed using sudo, so you need to be logged"
echo "in as an administrator. Please provide your password when prompted."
echo
set -x
sudo launchctl unload /Library/LaunchDaemons/@@OSX_IDPREFIX@@.plist
sudo rm /Library/LaunchDaemons/@@OSX_IDPREFIX@@.plist
sudo rm -rf /Applications/@@CAMELARTIFACTNAME@@ "/Library/Application Support/@@CAMELARTIFACTNAME@@" /Library/Documentation/@@CAMELARTIFACTNAME@@
sudo rm -rf /Users/Shared/@@CAMELARTIFACTNAME@@
sudo rm -rf /var/log/@@ARTIFACTNAME@@
sudo rm -f /etc/newsyslog.d/@@ARTIFACTNAME@@.conf
sudo dscl . -delete /Users/@@ARTIFACTNAME@@
sudo dscl . -delete /Groups/@@ARTIFACTNAME@@
# the following is not quite correct as the '.'s in the "@@OSX_IDPREFIX@@" will match any character but 
# if everyone is following the reverse dns then it will not clover any other packages.
pkgutil --pkgs | grep '@@OSX_IDPREFIX@@\.' | xargs -n 1 sudo pkgutil --forget
set +x
echo
echo "@@PRODUCTNAME@@ has been uninstalled."
