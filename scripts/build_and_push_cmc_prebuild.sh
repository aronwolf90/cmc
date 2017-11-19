#!/bin/bash

set -e

PREBUID_IMAGE='registry.gitlab.com/cmc_system/cmc/cmc_prebuild'
MY_PATH="`dirname \"$0\"`"

$MY_PATH/build_prebuild.sh

docker push $PREBUID_IMAGE
