#!/bin/bash

set -e

export NODE_PATH=`pwd`

if [ -z $1 ]; then
  cross-env NODE_ENV=test nyc mocha-webpack -u bdd-lazy-var/global --webpack-config config/webpack/mocha.js --require spec/mocha.js --include spec/javascript/global.js spec/load_all.js --recursive spec/javascript/
else
  cross-env NODE_ENV=test mocha-webpack  -u bdd-lazy-var/global --webpack-config config/webpack/mocha.js --require spec/mocha.js --include spec/javascript/global.js --recursive $@
fi
