#!/bin/bash

set -e

IMAGE='registry.gitlab.com/cmc_system/cmc/cmc:test'

docker build --build-arg MODUS="gitlab-ci" -t $IMAGE .

docker push $IMAGE
