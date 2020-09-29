#!/bin/bash

set -euo pipefail

PART_SIZE=$(( $(find $3 -type f -regex $4| wc -l) / $1 + 1 ))
TOP=$(( $PART_SIZE * ($2 - 1) + 1 ))

find $3 -type f -regex $4 | tail -n+$TOP | head -n$PART_SIZE
