#!/bin/bash

if [[ "$(docker images -q cmc_prebuild 2> /dev/null)" != "" ]]; then
  docker build -t cmc_prebuild -f DockerfilePrebuild .
fi

docker run -it cmc_prebuild --mount source=./,target=/app bundle install

docker build -t cmc .
