#!/bin/bash

cucumber $(bin/split_files.sh $CI_NODE_TOTAL $CI_NODE_INDEX features/ features/[^a][^p][^i].*feature)
