#!/bin/bash

set -e

PREBUID_IMAGE='registry.gitlab.com/cmc_system/cmc/cmc_prebuild'

docker build -t $PREBUID_IMAGE -f DockerfilePrebuild .
