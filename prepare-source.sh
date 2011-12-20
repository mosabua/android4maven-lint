#!/bin/bash

if [ -z "$ANDROID_SOURCE" ]; then
    echo "Need to set ANDROID_SOURCE to point to your folder that contains the android source code repository"
    exit 1
fi 

UNAME=`uname -s`
readlink=readlink
if [ "$UNAME" == "Darwin" ]; then
   readlink=greadlink
fi
 
currentDir=`$readlink -f $(dirname $0)`

export ANDROID_SDK_VERSION=$1
echo "Building Android SDK Version $ANDROID_SDK_VERSION"
export ANDROID_SOURCE_SDK=$ANDROID_SOURCE/sdk
echo "Using SDK source in $ANDROID_SOURCE_SDK"

export GIT_BRANCH="tools_$ANDROID_SDK_VERSION"

echo "Checking out $GIT_BRANCH in $ANDROID_SOURCE_SDK"
cd $ANDROID_SOURCE
#git checkout --quiet korg/$gitBranch

#export GIT_REV=`git --git-dir=$sdkLocation/.git rev-parse HEAD`
#echo "Git rev: $GIT_REV"

echo "Starting to build Android SDK"
#lunch sdk-eng
#make sdk

cd $currentDir