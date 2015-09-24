#!/bin/bash -eux

rm -fr build

# the individual packages
mkdir -p build/component
pkgbuild --root packages/war/app             --identifier @@OSX_IDPREFIX@@.war              --version @@VERSION@@ --install-location /Applications/Jenkins   --scripts packages/war/scripts             build/component/war.pkg
pkgbuild --root packages/launchd_daemon/app  --identifier @@OSX_IDPREFIX@@.launchd_daemon   --version @@VERSION@@ --install-location /Library/LaunchDaemons/ --scripts packages/launchd_daemon/scripts  build/component/launchd_daemon.pkg
pkgbuild --root packages/launchd_jenkins/app --identifier @@OSX_IDPREFIX@@.launchd_jenkins  --version @@VERSION@@ --install-location /Library/LaunchDaemons/ --scripts packages/launchd_jenkins/scripts build/component/launchd_jenkins.pkg
pkgbuild --root packages/launchd_jenkins/app --identifier @@OSX_IDPREFIX@@.support          --version @@VERSION@@ --install-location /Library/LaunchDaemons/ --scripts packages/support/scripts         build/component/support.pkg
pkgbuild --root packages/launchd_jenkins/app --identifier @@OSX_IDPREFIX@@.documentation    --version @@VERSION@@ --install-location /Library/LaunchDaemons/ --scripts packages/documentation/scripts   build/component/documentation.pkg

# the main installer.
mkdir -p build/installer
productbuild --distribution packages/bundle/distribution.xml --resources packages/bundle/resources/ --version @@VERSION@@ build/installer/@@ARTIFACTNAME@@.pkg
