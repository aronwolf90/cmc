#!/bin/bash

set -euo pipefail

PART=$(expr $(find $3 -type f | wc -l) / $1 + 1)
TOP=$(eval expr 0)

echo "$PART"

find features/ -type f | tail -n+$TOP | head -n$PART
