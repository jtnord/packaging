/*
 * this isn't a release line by itself but instead defines the commonality of the all OSS release lines.
 */

ext.PRODUCTNAME='Jenkins'
ext.ARTIFACTNAME='jenkins'
ext.CAMELARTIFACTNAME='Jenkins'
ext.VENDOR='Jenkins project'
ext.SUMMARY='Jenkins Continuous Integration Server'
ext.PORT=8080

ext.MSI_PRODUCTCODE='415933d8-4104-47c3-aee9-66b31de07a57'
ext.OSX_IDPREFIX='org.jenkins-ci'
ext.AUTHOR='Kohsuke Kawaguchi <kk@kohsuke.org>'
ext.LICENSE='MIT/X License, GPL/CDDL, ASL2'
ext.HOMEPAGE='http://jenkins-ci.org/'
ext.CHANGELOG_PAGE='http://jenkins-ci.org/changelog'

// we actually know this directory and could hard code it,
// however as this will be the base for other files make it easy for those that copy it!
def BRANDING_DIR=new java.io.File("$BRAND").parentFile.path

ext.DESCRIPTION_FILE="${BRANDING_DIR}/description-file"
ext.LICENSE_FILE="${BRANDING_DIR}/license-mit"
