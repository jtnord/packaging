#
# Environment definition for official OSS Jenkins packaging
# 

# JENKINS used to generate OSX/MSI packages
def JENKINS_URL='https://cloudbees.ci.cloudbees.com/'

# the host to publish bits to
def PKGSERVER='www-data@pkg.jenkins-ci.org'

# where to put binary files
def WARDIR='/srv/releases/jenkins/war${RELEASELINE}'
def MSIDIR='/srv/releases/jenkins/windows${RELEASELINE}'
def OSXDIR='/srv/releases/jenkins/osx${RELEASELINE}'
def DEBDIR='/srv/releases/jenkins/debian${RELEASELINE}'
def RPMDIR='/srv/releases/jenkins/redhat${RELEASELINE}'
def SUSEDIR='/srv/releases/jenkins/opensuse${RELEASELINE}'

# where to put repository index and other web contents
def  RPM_WEBDIR='/var/www/pkg.jenkins-ci.org.staging/redhat${RELEASELINE}'
def SUSE_WEBDIR='/var/www/pkg.jenkins-ci.org.staging/opensuse${RELEASELINE}'
def  DEB_WEBDIR='/var/www/pkg.jenkins-ci.org.staging/debian${RELEASELINE}'

# URL to the aforementioned webdir
def  RPM_URL='http://pkg.jenkins-ci.org/redhat${RELEASELINE}'
def SUSE_URL='http://pkg.jenkins-ci.org/opensuse${RELEASELINE}'
def  DEB_URL='http://pkg.jenkins-ci.org/debian${RELEASELINE}'

# additoinal contents to be overlayed during publishing
def OVERLAY_CONTENTS='${BASE}/env/release'
