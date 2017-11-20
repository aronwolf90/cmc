#!/bin/bash

set -e

IMAGE='registry.gitlab.com/cmc_system/cmc/cmc:test'

docker build --build-arg GITLAB_CI=true -t $IMAGE .

docker push $IMAGE
