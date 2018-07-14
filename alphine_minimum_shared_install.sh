#!/bin/sh

set -e

apk update
apk add tzdata
apk add postgresql-client
apk add libssl1.0
apk add gnupg
apk add libstdc++
