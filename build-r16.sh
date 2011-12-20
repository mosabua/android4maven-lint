#!/bin/bash
set -e
source ./prepare-source.sh r16
source ./assemble.sh common common
source ./assemble.sh androidprefs androidprefs
source ./assemble.sh lint_api lint/libs/lint_api
source ./assemble.sh lint_checks lint/libs/lint_checks
source ./assemble.sh lint lint/cli
source ./assemble.sh ddms ddms/libs/ddmlib
