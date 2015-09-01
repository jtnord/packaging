#!/bin/bash -ex
# this script runs on the release machine to submit the actual msi build to a Windows machine

bin=$(dirname $0)
encodedv=$($bin/encode-version.rb $VERSION)

D=./.tmp$$   # temporary directory (in workspace so we can stash it)
mkdir -p $D

# replace variables in the wxs file
eval "cat > $D/jenkins.wxs <<EOF
$(<$bin/jenkins.wxs)
EOF
" 2> /dev/null

cp ${PKCS12_FILE} $D/key.pkcs12
cp ${PKCS12_PASSWORD_FILE} $D/key.password

cp FindJava.java build.sh jenkins.exe.config bootstrapper.xml $D/
