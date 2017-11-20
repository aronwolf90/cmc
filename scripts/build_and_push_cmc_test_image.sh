#!/bin/bash

set -e

IMAGE='registry.gitlab.com/cmc_system/cmc/cmc:test'

docker build -t $IMAGE  .

docker push $IMAGE
