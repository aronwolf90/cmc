#!/bin/bash

set -e

docker build -f DockerfileDevelop -t cmc .

docker-compose run web /bin/bash -c "bundle install; yarn install; rake db:migrate; rake db:seed"
