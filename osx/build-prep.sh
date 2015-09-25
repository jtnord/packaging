#!/bin/bash -ex

echo "dumping system environment"
env
echo "done"


bin=$(dirname $0)
D=./tmp/osx
rm -fr $D
mkdir -p $D/src

cp -R $bin/* $D/src
pushd $D/src
  pushd packages/launchd_daemon/app
    mv default.plist $OSX_IDPREFIX.plist
  popd
  pushd packages/launchd_user/app
    mv default.plist $OSX_IDPREFIX.plist
  popd
# inline the version so that it is available.
# TODO this should be done by templating (aka branding.)
  mv build.sh build.sh_
  sed s/@@VERSION@@/$VERSION/g < build.sh_ > build.sh
  rm build.sh_
  chmod +x build.sh
popd

$BASE/bin/branding.sh $D/src

cp ${KEYCHAIN_FILE} $D/src/jenkins.keychain
cp ${KEYCHAIN_PASSWORD_FILE} $D/src/jenkins.keychain.password
mkdir -p $D/src/war/app/
# disabled for quicker testing
#cp ${WAR} $D/src/war/app/${ARTIFACTNAME}.war
