#!/bin/bash

curl --retry 30 --retry-connrefused --retry-delay 1
cucumber --retry 2 --no-strict-flaky $(bin/split_files.sh $CI_NODE_TOTAL $CI_NODE_INDEX features/ $REGEX)
