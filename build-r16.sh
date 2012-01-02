#!/bin/bash
set -e
# branch for r16 tools release is ics_mr0 as discussed in http://groups.google.com/group/adt-dev/browse_thread/thread/67fbae0b0a4110ef
source ./prepare-source.sh r16 ics-mr0
source ./assemble.sh common common
source ./assemble.sh androidprefs androidprefs
source ./assemble.sh lint_api lint/libs/lint_api
source ./assemble.sh lint_checks lint/libs/lint_checks
source ./assemble.sh lint lint/cli
source ./assemble.sh ddmlib ddms/libs/ddmlib

export ANDROID_SDK_BUILD_OUTPUT=$ANDROID_SOURCE/out/host/darwin-x86/sdk/android-sdk_eng.manfred_mac-x86/

source ./compare.sh common tools/lib/

#source ./compare.sh androidprefs tools/lib/
#source ./compare.sh lint_api tools/lib/
#source ./compare.sh lint_checks tools/lib/
#source ./compare.sh lint tools/lib/
#source ./compare.sh ddmlib tools/lib/


