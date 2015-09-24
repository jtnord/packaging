#!/bin/bash -ex

bin=$(dirname $0)
D=./tmp/osx
rm -fr $D
mkdir -p $D/src

cp -R $bin/* $D/src
pushd $D/src/packages
  pushd launchd_daemon/app
    mv default.plist $OSX_IDPREFIX.plist
  popd
  pushd launchd_jenkins/app
    mv default.plist $OSX_IDPREFIX.plist
  popd
popd
$BASE/bin/branding.sh $D/src

cp ${KEYCHAIN_FILE} $D/src/jenkins.keychain
cp ${KEYCHAIN_PASSWORD_FILE} $D/src/jenkins.keychain.password
cp ${WAR} $D/src/war/app/${@@ARTIFACTNAME@@}.war
