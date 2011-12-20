#!/bin/bash

name=$1
location=$2

UNAME=`uname -s`
readlink=readlink
if [ "$UNAME" == "Darwin" ]; then
   readlink=greadlink
fi
  
currentDir=`$readlink -f $(dirname $0)`
echo "Working in $currentDir"

codeLocation=$ANDROID_SOURCE_SDK/$location/
echo "Building code in $codeLocation"

pomLocation=$currentDir/$name-pom.xml
projectRoot=$currentDir/project-$name-$ANDROID_SDK_VERSION
projectSrc=$projectRoot/src/main/java
projectTest=$projectRoot/src/test/java

echo "Removing $projectRoot"
rm -rf $projectRoot

echo "Setting up Maven project structure"
mkdir -p $projectSrc
mkdir -p $projectTest

echo "Copying source files to $projectSrc"
cp -r $codeLocation/src/com $projectSrc

echo "Copying test files to $projectTest"
cp -r $codeLocation/tests/src/com $projectTest

echo "Copying in pom file ($pomLocation)"
cp $pomLocation $projectRoot/pom.xml
perl -pi -e "s/\@VERSION\@/$ANDROID_SDK_VERSION/" $projectRoot/pom.xml
perl -pi -e "s/\@GIT_BRANCH\@/$GIT_BRANCH/" $projectRoot/pom.xml
perl -pi -e "s/\@GIT_COMMIT\@/$GIT_REV/" $projectRoot/pom.xml

cd $projectRoot
mvn clean install
#mvn clean source:jar javadoc:jar package gpg:sign repository:bundle-create

cd $currentDir
