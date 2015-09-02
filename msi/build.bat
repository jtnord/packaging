REM the tooling needs to add the following to the path on windows
REM WIX toolset

war="%1"
ENCODEDVERSION="%2"
ARTIFACTNAME="%3"
PRODUCTNAME="%4"
PORT="%5"
if "%PORT%" NEQ "" GOTO :OK
echo "build.bat path/to/jenkins.war version artifactName port"
exit /B 1

:OK

REM MOVE THIS TO build-prep.  we only need to do the actual windows bits here...
rmdir /s tmp
mkdir tmp

unzip -p "$war" 'WEB-INF/lib/jenkins-core-*.jar' > tmp/core.jar
unzip -p tmp/core.jar windows-service/jenkins.exe > tmp/jenkins.exe
unzip -p tmp/core.jar windows-service/jenkins.xml | sed -e "s|\bjenkins\b|${ARTIFACTNAME}|" | sed -e "s|8080|${PORT}|" > tmp/jenkins.xm_
# replace executable name to the bundled JRE
sed -e 's|executable.*|executable>%BASE%\\jre\\bin\\java</executable>|' < tmp/jenkins.xm_ > tmp/jenkins.xml

REM capture JRE
javac FindJava.java
JREDIR=$(java -cp . FindJava)
echo "JRE=$JREDIR"
heat dir "$JREDIR" -o jre.wxs -sfrag -sreg -nologo -srd -gg -cg JreComponents -dr JreDir -var var.JreDir

REM  pick up java.exe File ID
JavaExeId=$(grep java.exe jre.wxs | grep -o "fil[0-9A-F]*")

candle -dJreDir="$JREDIR" -dWAR="$war" -dJavaExeId=$JavaExeId -nologo -ext WixUIExtension -ext WixUtilExtension -ext WixFirewallExtension jenkins.wxs jre.wxs
REM  '-sval' skips validation. without this, light somehow doesn't work on automated build environment
REM  set to -dcl:low during debug and -dcl:high for release
light -o ${ARTIFACTNAME}.msi -sval -nologo -dcl:high -ext WixUIExtension -ext WixUtilExtension -ext WixFirewallExtension jenkins.wixobj jre.wixobj

msbuild.exe /property:src=${ARTIFACTNAME}.msi "/property:ProductName=${PRODUCTNAME}" bootstrapper.xml

signtool sign /v /f key.pkcs12 /p $(cat key.password) /t http://timestamp.verisign.com/scripts/timestamp.dll ${ARTIFACTNAME}.msi setup.exe

REM - the files we need to bring back are ${ARTIFACTNAME}.msi setup.exe
REM zip ${ARTIFACTNAME}-windows.zip ${ARTIFACTNAME}.msi setup.exe

REM avoid bringing back files that we don't care
rmdir /s tmp 
del *.class *.wixpdb *.wixobj
