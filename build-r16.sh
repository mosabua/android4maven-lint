#!/bin/bash
source ./prepare-source.sh r16
source ./assemble.sh common common
source ./assemble.sh lint_api lint/libs/lint_api
#source ./assemble.sh lint_checks lint/libs/lint_checks
#source ./assemble.sh lint lint/cli

# TODO add ddmlib as well