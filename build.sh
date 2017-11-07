#!/bin/bash

PREBUID_IMAGE='registry.gitlab.com/cmc_system/cmc/cmc_prebuild'

if [[ "$(docker images -q $PREBUID_IMAGE 2> /dev/null)" == "" ]]; then
  docker build -t $PREBUID_IMAGE -f DockerfilePrebuild .
fi

docker run -it -v $(pwd):/app $PREBUID_IMAGE  bundle install

docker build -t cmc .
