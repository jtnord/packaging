#!/bin/bash -eux

rm -fr build

# the individual packages
mkdir -p build/components
pkgbuild --root packages/war/app             --identifier @@OSX_IDPREFIX@@.war              --version @@VERSION@@ --install-location /Applications/Jenkins   --scripts packages/war/scripts                   build/components/war.pkg
pkgbuild --root packages/launchd_daemon/app  --identifier @@OSX_IDPREFIX@@.launchd_daemon   --version @@VERSION@@ --install-location /Library/LaunchDaemons/ --scripts packages/launchd_daemon/scripts        build/components/launchd_daemon.pkg
pkgbuild --root packages/launchd_jenkins/app --identifier @@OSX_IDPREFIX@@.launchd_@@ARTIFACTNAME@@  --version @@VERSION@@ --install-location /Library/LaunchDaemons/ --scripts packages/launchd_user/scripts build/components/launchd_@@ARTIFACTNAME@@.pkg
pkgbuild --root packages/launchd_jenkins/app --identifier @@OSX_IDPREFIX@@.support          --version @@VERSION@@ --install-location /Library/LaunchDaemons/ --scripts packages/support/scripts               build/components/support.pkg
pkgbuild --root packages/launchd_jenkins/app --identifier @@OSX_IDPREFIX@@.documentation    --version @@VERSION@@ --install-location /Library/LaunchDaemons/ --scripts packages/documentation/scripts         build/components/documentation.pkg

# the main installer.
mkdir -p build/installer
productbuild --distribution packages/bundle/distribution.xml --package-path build/components/ --resources packages/bundle/resources/ --version @@VERSION@@ build/installer/@@ARTIFACTNAME@@.pkg
