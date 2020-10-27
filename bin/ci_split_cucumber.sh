#!/bin/bash

cucumber --retry 2 $(bin/split_files.sh $CI_NODE_TOTAL $CI_NODE_INDEX features/ features/[^a][^p][^i].*feature)
