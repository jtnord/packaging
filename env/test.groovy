/*
 * Environment definition for dry-run of the packaging process
 */

//JENKINS used to generate OSX/MSI packages
def JENKINS_URL=project.hasProperty('JENKINS_URL') ? "${JENKINS_URL}" : 'https://cloudbees.ci.cloudbees.com/'

// the host to publish bits to
def PKGSERVER="${System.getProperty('user.name')}@localhost"

// where to put binary files
//TODO FIXME
def TESTDIR="${System.getProperty('user.dir')}/pkg.jenkins-ci.org"
def WARDIR="${TESTDIR}/war${RELEASELINE}"
def MSIDIR="${TESTDIR}/windows${RELEASELINE}"
def OSXDIR="${TESTDIR}/osx${RELEASELINE}"
def DEBDIR="${TESTDIR}/debian${RELEASELINE}/binary"
def RPMDIR="${TESTDIR}/redhat${RELEASELINE}"
def SUSEDIR="${TESTDIR}/opensuse${RELEASELINE}"

// where to put repository index and other web contents
def  RPM_WEBDIR="${TESTDIR}/redhat${RELEASELINE}"
def SUSE_WEBDIR="${TESTDIR}/opensuse${RELEASELINE}"
def  DEB_WEBDIR="${TESTDIR}/debian${RELEASELINE}"

// URL to the aforementioned webdir.
def WEBSERVER='test.pkg.jenkins-ci.org:9200'
ext.RPM_URL="http://${WEBSERVER}/redhat${RELEASELINE}"
ext.SUSE_URL="http://${WEBSERVER}/opensuse${RELEASELINE}"
ext.DEB_URL="http://${WEBSERVER}/debian${RELEASELINE}"

// additoinal contents to be overlayed during publishing
ext.OVERLAY_CONTENTS="${System.getProperty('user.dir')}/env/release"
