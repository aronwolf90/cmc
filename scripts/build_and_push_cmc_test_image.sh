#!/bin/bash

set -e

IMAGE='registry.gitlab.com/cmc_system/cmc/cmc:test'

docker build -f DockerfileGitlab  -t $IMAGE .

docker push $IMAGE
