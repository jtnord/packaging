#!/bin/bash -eux

rm -fr build

# the individual packages
mkdir -p build/components

pkgbuild --root packages/war/app \
         --identifier @@OSX_IDPREFIX@@.@@ARTIFACTNAME@@.war.pkg \
         --version @@VERSION@@ \
         --install-location /Applications/@@CAMELARTIFACTNAME@@ \
         --scripts packages/war/scripts \
         build/components/war.pkg
         
pkgbuild --root packages/launchd_daemon/app \
         --identifier @@OSX_IDPREFIX@@.@@ARTIFACTNAME@@.launchd_daemon.pkg \
         --version @@VERSION@@ \
         --install-location /Library/LaunchDaemons/ \
         --scripts packages/launchd_daemon/scripts \
         build/components/launchd_daemon.pkg

pkgbuild --root packages/launchd_user/app \
         --identifier @@OSX_IDPREFIX@@.@@ARTIFACTNAME@@.launchd_@@ARTIFACTNAME@@.pkg \
         --version @@VERSION@@ \
         --install-location /Library/LaunchDaemons/ \
         --scripts packages/launchd_user/scripts \
         build/components/launchd_@@ARTIFACTNAME@@.pkg

pkgbuild --root packages/support/app \
         --identifier @@OSX_IDPREFIX@@.@@ARTIFACTNAME@@.support.pkg \
         --version @@VERSION@@ \
         --install-location "/Library/Application Support/@@CAMELARTIFACTNAME@@" \
         build/components/support.pkg

pkgbuild --root packages/documentation/app \
         --identifier @@OSX_IDPREFIX@@.@@ARTIFACTNAME@@.documentation.pkg \
         --version @@VERSION@@ \
         --install-location /Library/Documentation/@@CAMELARTIFACTNAME@@ \
         build/components/documentation.pkg

## Prep the Signing


# Create a temporary keychain
security create-keychain -p $PASSWORD `pwd`/installer.keychain
# import the certificates into the keychain
security import key.pkcs12 -k `pwd`/installer.keychain -t agg -f pkcs12 -A -P $PASSWORD
# unluck the keychain so we can use it
security unlock-keychain -p $PASSED `pwd`/installer.keychain
# We need to know the identity of the certificate to use
SIGN_IDENTITY="$(security find-identity $PWD/installer.keychain | grep "1)" | head -n1 | cut -f4 -d' ')"


# the main installer.
mkdir -p build/installer
# we always want to delete the keychain
set +e
productbuild --distribution packages/bundle/distribution.xml \
             --package-path build/components/ \
             --resources packages/bundle/resources/ \
             --version @@VERSION@@ \
             --sign ${SIGN_IDENTITY} \
             --keychain `pwd`/installer.keychain \
             --timestamp \
             build/installer/@@ARTIFACTNAME@@.pkg
EXIT_CODE=$?
set -e
security delete-keychain `pwd`/installer.keychain
exit ${EXIT_CODE}

