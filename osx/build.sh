#!/bin/bash -eux

rm -fr build

# just to enable quicker testing..
mkdir packages/war/app
cp ~/jenkins.war packages/war/app/@@ARTIFACTNAME@@.war
## end quick testing hack


# the individual packages
mkdir -p build/components

pkgbuild --root packages/war/app \
         --identifier @@OSX_IDPREFIX@@.war \
         --version @@VERSION@@ \
         --install-location /Applications/@@CAMELARTIFACTNAME@@ \
         --scripts packages/war/scripts \
         build/components/war.pkg
         
pkgbuild --root packages/launchd_daemon/app \
         --identifier @@OSX_IDPREFIX@@.launchd_daemon \
         --version @@VERSION@@ \
         --install-location /Library/LaunchDaemons/ \
         --scripts packages/launchd_daemon/scripts \
         build/components/launchd_daemon.pkg

pkgbuild --root packages/launchd_user/app \
         --identifier @@OSX_IDPREFIX@@.launchd_@@ARTIFACTNAME@@ \
         --version @@VERSION@@ \
         --install-location /Library/LaunchDaemons/ \
         --scripts packages/launchd_user/scripts \
         build/components/launchd_@@ARTIFACTNAME@@.pkg

pkgbuild --root packages/support/app \
         --identifier @@OSX_IDPREFIX@@.support \
         --version @@VERSION@@ \
         --install-location "/Library/Application Support/@@CAMELARTIFACTNAME@@" \
         build/components/support.pkg

pkgbuild --root packages/documentation/app \
         --identifier @@OSX_IDPREFIX@@.documentation \
         --version @@VERSION@@ \
         --install-location /Library/Documentation/@@CAMELARTIFACTNAME@@ \
         build/components/documentation.pkg

# the main installer.
mkdir -p build/installer
productbuild --distribution packages/bundle/distribution.xml \
             --package-path build/components/ \
             --resources packages/bundle/resources/ \
             --version @@VERSION@@ \
             build/installer/@@ARTIFACTNAME@@.pkg
