#!/bin/bash -ex
# this script runs on the release machine to prepare the files for submission to a Windows machine

bin=$(dirname $0)
encodedv=$($bin/encode-version.rb $VERSION)

D=./tempBuild   # temporary directory (in workspace so we can stash it)
mkdir -p $D

# replace variables in the various files
eval "cat > $D/jenkins.wxs <<EOF
$(<$bin/jenkins.wxs)
EOF
" 2> /dev/null

# replace variables in the various files
eval "cat > $D/build.bat <<EOF
$(<$bin/build.bat)
EOF
" 2> /dev/null


cp -t $D/ $bin/jre.xslt $bin/FindJava.java $bin/jenkins.exe.config $bin/bootstrapper.xml
cp "$WAR" $D/${ARTIFACTNAME}.war

# perform transalations of the files
mkdir $D/tmp

unzip -p "$WAR" 'WEB-INF/lib/jenkins-core-*.jar' > $D/tmp/core.jar
unzip -p $D/tmp/core.jar windows-service/jenkins.exe > $D/tmp/jenkins.exe
unzip -p $D/tmp/core.jar windows-service/jenkins.xml | sed -e "s|\bjenkins\b|${ARTIFACTNAME}|" | sed -e "s|8080|${PORT}|" > $D/tmp/jenkins.xm_
# replace executable name to the bundled JRE
sed -e 's|executable.*|executable>%BASE%\\jre\\bin\\java</executable>|' < $D/tmp/jenkins.xm_ > $D/tmp/jenkins.xml
rm $D/tmp/core.jar $D/tmp/jenkins.xm_ 

cp ${PKCS12_FILE} $D/key.pkcs12
cp ${PKCS12_PASSWORD_FILE} $D/key.password
