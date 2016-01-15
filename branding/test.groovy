/*
 * Profile for testing release process
 */
ext.RELEASELINE=''

ext.PRODUCTNAME='Jenkins Test'
ext.ARTIFACTNAME='jenkinstest'
ext.CAMELARTIFACTNAME='JenkinsTest'
ext.VENDOR='Jenkins Test project'
ext.SUMMARY='Jenkins Continuous Integration Server (Test)'
ext.PORT='7777'
ext.AUTHOR='Jenkins Butler Test'

ext.MSI_PRODUCTCODE='e76baa9f-2bb2-49e5-b518-8a5b7d1cd084'
ext.OSX_IDPREFIX='org.jenkins-ci.test'
ext.LICENSE='MIT/X License, GPL/CDDL, ASL2'

def BRANDING_DIR=new java.io.File("$BRAND").parentFile.path

ext.DESCRIPTION_FILE="${BRANDING_DIR}/description-file"
ext.LICENSE_FILE="${BRANDING_DIR}/license-mit"
