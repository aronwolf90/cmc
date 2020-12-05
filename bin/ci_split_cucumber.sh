#!/bin/bash

cucumber --retry 2 --no-strict-flaky $(bin/split_files.sh $CI_NODE_TOTAL $CI_NODE_INDEX features/ features/[^a][^p][^i].*feature)
