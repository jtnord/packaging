# Jenkins OS X Installer Project

To create the Jenkins Installer for OS X you need an OS X machine with Developer Tools installed. 
You can download the Developer Tools from [Apple's Developer Connection website](http://developer.apple.com)

## Build the Installer

To build the installer package you will need a copy of the jenkins.war file. You can download it from the
[Jenkins home page](http://mirrors.jenkins-ci.org/war/latest/). Then open a terminal, navigate to this
directory, and run the build script

    ./build.sh /path/to/jenkins.war

## Some Links

* [@@PRODUCTNAME@@](@@HOMEPAGE@@)
* [Great overview of OS X installers](http://vincent.bernat.im/en/blog/2013-autoconf-osx-packaging.html)
* [Creating Packages from the Command Line - Tutorial](http://thegreyblog.blogspot.co.uk/2014/06/os-x-creating-packages-from-command_2.html)
* [Apple Developer Center](http://www.developer.apple.com)
* [Distribution XML Reference](https://developer.apple.com/library/mac/documentation/DeveloperTools/Reference/DistributionDefinitionRef/Chapters/Distribution_XML_Ref.html#//apple_ref/doc/uid/TP40005370-CH100-SW11)

