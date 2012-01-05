#!/bin/bash

UNAME=`uname -s`
readlink=readlink
if [ "$UNAME" == "Darwin" ]; then
   readlink=greadlink
fi
  
workDir=`$readlink -f $(dirname $0)`

name=$1
folder=$2

echo
echo "------------------------------------------------------------------"
echo "Working on comparison for $folder$name in $workDir"

originalJar=$ANDROID_SDK_BUILD_OUTPUT$folder/$name.jar
originalJarExtracted=$workDir/target/original-$name-extracted
assembledJar=$workDir/target/project-$name-$ANDROID_SDK_VERSION/target/$name-$ANDROID_SDK_VERSION.jar
assembledJarExtracted=$workDir/target/assembled-$name-extracted

diffList=$name-$ANDROID_SDK_VERSION-diff.list

# REAL WORK
echo "Preparing location for original artifact: $originalJarExtracted"
rm -rf $originalJarExtracted
mkdir -p $originalJarExtracted
cd $originalJarExtracted
echo "Extracting $originalJar"
jar -xf $originalJar

cd $workDir

echo "Preparing location for assembled artifact: $assembledJarExtracted"
rm -rf $assembledJarExtracted
mkdir -p $assembledJarExtracted
cd $assembledJarExtracted
echo "Extracting $assembledJar"
jar -xf $assembledJar
cd $workDir

echo "Writing diff to target/$diffList"
diff -r "$originalJarExtracted" "$assembledJarExtracted" > "target/$diffList" || [ $? -eq 1 ]
#TODO somehow script does not continue after diff command when set -e is done" 

echo "Done with $name"

rm -rf $originalJarExtracted
rm -rf $assembledJarExtracted

echo "------------------------------------------------------------------"
echo 