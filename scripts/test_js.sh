#!/bin/bash

set -e

export NODE_PATH=`pwd`

if [ -z $1 ]; then
  cross-env NODE_ENV=test nyc mocha-webpack --webpack-config config/webpack/test.js -u bdd-lazy-var/global --require spec/mocha.js spec/load_all.js --recursive spec/javascript/
else
  cross-env NODE_ENV=test mocha-webpack --webpack-config config/webpack/test.js -u bdd-lazy-var/global --require spec/mocha.js --recursive $@
fi
