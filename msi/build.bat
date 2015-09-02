REM the tooling needs to add the following to the path on windows
REM WIX toolset
setlocal

REM - better to use cscript here....

set war="%1"
set ENCODEDVERSION="%2"
set ARTIFACTNAME="%3"
set PRODUCTNAME="%4"
set PORT="%5"
if "%PORT%" NEQ "" GOTO :OK
echo "build.bat path/to/jenkins.war version artifactName port"
exit /B 1

:OK

REM capture JRE
javac FindJava.java
set JREDIR=$(java -cp . FindJava)
echo "JRE=$JREDIR"
heat dir "$JREDIR" -o jre.wxs -sfrag -sreg -nologo -srd -gg -cg JreComponents -dr JreDir -var var.JreDir

REM  pick up java.exe File ID
JavaExeId=$(grep java.exe jre.wxs | grep -o "fil[0-9A-F]*")

candle -dJreDir="%JREDIR%" -dWAR="%war%" -dJavaExeId=%JavaExeId% -nologo -ext WixUIExtension -ext WixUtilExtension -ext WixFirewallExtension jenkins.wxs jre.wxs
REM  '-sval' skips validation. without this, light somehow doesn't work on automated build environment
REM  set to -dcl:low during debug and -dcl:high for release
light -o %ARTIFACTNAME%.msi -sval -nologo -dcl:high -ext WixUIExtension -ext WixUtilExtension -ext WixFirewallExtension jenkins.wixobj jre.wixobj

msbuild.exe /property:src=%ARTIFACTNAME%.msi "/property:ProductName=%PRODUCTNAME%" bootstrapper.xml

signtool sign /v /f key.pkcs12 /p $(cat key.password) /t http://timestamp.verisign.com/scripts/timestamp.dll %ARTIFACTNAME%.msi setup.exe

REM - the files we need to bring back are ${ARTIFACTNAME}.msi setup.exe
REM zip ${ARTIFACTNAME}-windows.zip ${ARTIFACTNAME}.msi setup.exe

REM avoid bringing back files that we don't care
rmdir /s tmp 
del *.class *.wixpdb *.wixobj
