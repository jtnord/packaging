REM the tooling needs to add the following to the path on windows
REM WIX toolset
setlocal

REM - better to use cscript here....

set war=${ARTIFACTNAME}.war
set VERSION=${VERSION}
set ARTIFACTNAME=${ARTIFACTNAME}
set PRODUCTNAME=${PRODUCTNAME}
set PORT=${PORT}

if "%PORT%" NEQ "" GOTO :OK
echo "build.bat need pre-procesing before being called."
exit /B 1

:OK

REM Set by Jenkins or tooling to point to the JDK
set JREDIR=%JAVA_HOME%\jre
echo "JRE=%JREDIR%"
REM this seems a little strange - using the JDK configured here to re-package...
heat dir "%JREDIR%" -o jre.wxs -t jre.xslt -sfrag -sreg -nologo -srd -gg -cg JreComponents -dr JreDir -var var.JreDir  || exit /b 1

REM  pick up java.exe File ID
REM set JavaExeId=$(grep java.exe jre.wxs | grep -o "fil[0-9A-F]*")
REM it's now 100% stable... using the XSLT...

candle -dJreDir="%JREDIR%" -dWAR="%war%" -nologo -ext WixUIExtension -ext WixUtilExtension -ext WixFirewallExtension jenkins.wxs jre.wxs  || exit /b 1
REM  '-sval' skips validation. without this, light somehow doesn't work on automated build environment
REM  set to -dcl:low during debug and -dcl:high for release
light -o %ARTIFACTNAME%-%VERSION%.msi -sval -nologo -dcl:high -ext WixUIExtension -ext WixUtilExtension -ext WixFirewallExtension jenkins.wixobj jre.wixobj  || exit /b 1

REM use wix bundle if really needed....
REM msbuild.exe /property:src=%ARTIFACTNAME%.msi "/property:ProductName=%PRODUCTNAME%" bootstrapper2.xml || exit /b 1

copy %ARTIFACTNAME%-%VERSION%.msi %ARTIFACTNAME%_presign.msi
signtool sign /debug /v /f key.pkcs12 /p "%PASSWORD%" /t http://timestamp.verisign.com/scripts/timestamp.dll %ARTIFACTNAME%-%VERSION%.msi || exit /b 1

REM - the files we need to bring back are ${ARTIFACTNAME}.msi setup.exe
REM zip ${ARTIFACTNAME}-windows.zip ${ARTIFACTNAME}.msi setup.exe

REM avoid bringing back files that we don't care
rmdir /s tmp 
del *.class *.wixpdb *.wixobj
