#!/bin/bash

PREBUID_IMAGE='registry.gitlab.com/cmc_system/cmc/cmc_prebuild'

docker build -t $PREBUID_IMAGE -f DockerfilePrebuild .


docker push $PREBUID_IMAGE
docker push $PREBUID_IMAGE
