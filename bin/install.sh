#!/bin/bash

bundle check || bundle
yarn check --verify-tree || yarn install

$@
