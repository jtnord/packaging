
// sanitized version number
// TODO get the version number from the WAR.
//def VERSION="$(shell unzip -p "${WAR}" META-INF/MANIFEST.MF | grep Implementation-Version | cut -d ' ' -f2 | tr -d '\r' | sed -e "s/-SNAPSHOT//" | sed -e "s/-alpha-.*//" | sed -e "s/-beta-.*//")"
def getVersion() {
  def manifest = new java.util.jar.JarFile(WAR).manifest
  def attrs = manifest.mainAttributes
  def impl = attrs.getValue('Implementation-Version')
}

ext.VERSION=getVersion()

// directory to place marker files for build artifacts
ext.TARGET="target"

// jenkins-cli.jar
ext.CLI="${TARGET}/jenkins-cli.jar"

// where to generate MSI file?
ext.MSI="${TARGET}/msi/${ARTIFACTNAME}-${VERSION}.zip"

// where to generate OSX PKG file?
ext.OSX="${TARGET}/osx/${ARTIFACTNAME}-${VERSION}.pkg"

// where to generate Debian/Ubuntu DEB file?
ext.DEB="${TARGET}/debian/${ARTIFACTNAME}_${VERSION}_all.deb"

// where to generate RHEL/CentOS RPM file?
ext.RPM="${TARGET}/rpm/${ARTIFACTNAME}-${VERSION}-1.1.noarch.rpm"

// where to generate SUSE RPM file?
ext.SUSE="${TARGET}/suse/${ARTIFACTNAME}-${VERSION}-1.2.noarch.rpm"

// anchored to the root of the repository
//def BASE="$(CURDIR)"

// read license file and do reformatting for proper display
ext.LICENSE_TEXT=new java.io.File(LICENSE_FILE).text

// TODO replace with pure groovy so we don't need extra tools
def wrapLine(text, width) {
  def out = '';
  text.eachLine {
    println "***LINE IS - $it"
    def remaining = it;
    while (true) {
        def next = remaining
        def found = next.lastIndexOf(' ', width-1)
        if ((found == -1) || (next.length() <= width )) {
          remaining = ''
          out += next + '\n'
          break
        }
        else {
            remaining = next.substring(found + 1)
            next = next[0..found]
        }
        out += next + '\n'
    }
    //out += '\n'
  }
  out
}

// TODO replacae with groovy function
ext.LICENSE_TEXT_COLUMN=wrapLine(LICENSE_TEXT, 78) // Format to 78 characters

ext.LICENSE_TEXT_COMMENTED="${LICENSE_TEXT_COLUMN}".replaceAll("(?m)^", "//")

// Put a dot in place of an empty line, and prepend a space
ext.LICENSE_TEXT_DEB="${LICENSE_TEXT_COLUMN}".replaceAll("(?m)^\$", ".").replaceAll("^", " ")
