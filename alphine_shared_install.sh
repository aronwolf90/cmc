#!/bin/sh

set -e

./alphine_minimum_shared_install.sh
apk add git
apk add g++
apk add ruby-dev
apk add make
apk add postgresql-dev
apk add bash
apk add curl
apk add openssh-client
apk add yarn

wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.11.tar.gz
tar -xvzf libiconv-1.11.tar.gz
cd libiconv-1.11
./configure --prefix=/usr/local/libiconv
make install

gem install bundler
