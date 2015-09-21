#!/bin/bash -ex

bin=$(dirname $0)
D=./tmp/osx
rm -fr $D
mkdir -p $D/src

cp -R $bin/* $D/src
pushd $D/src
  pushd launchd_conf_daemon
    mv org.jenkins-ci.plist org.jenkins-ci.plis_
    mv org.jenkins-ci.plis_ $OSX_IDPREFIX.plist
  popd
  pushd launchd_conf_jenkins
    mv org.jenkins-ci.plist org.jenkins-ci.plis_
    mv org.jenkins-ci.plis_ $OSX_IDPREFIX.plist
  popd
popd
$BASE/bin/branding.sh $D/src

cp ${KEYCHAIN_FILE} $D/src/jenkins.keychain
cp ${KEYCHAIN_PASSWORD_FILE} $D/src/jenkins.keychain.password

echo /bin/bash -ex build2.sh binary/${ARTIFACTNAME}.war $VERSION $ARTIFACTNAME \"$PRODUCTNAME\" > $D/src/build.sh
chmod +x $D/src/build.sh
