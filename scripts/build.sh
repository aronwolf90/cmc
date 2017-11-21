#!/bin/bash

set -e

mkdir -p bundle
mkdir -p databases/db/

docker build --build-arg MODUS="develop" -t cmc .

docker-compose run web /bin/bash -c "bundle install; yarn install; rake db:migrate"

