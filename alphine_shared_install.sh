#!/bin/sh

set -e

apk update
apk add git
apk add g++
apk add nodejs
apk add tzdata
apk add ruby-dev
apk add make
apk add postgresql-dev
apk add postgresql-client
apk add openssh-client
apk add bash
apk add nodejs-npm
apk add gnupg

gem install bundler

if ! [ -x "$(command -v yarn)" ]; then
  apk add curl bash binutils tar
  rm -rf /var/cache/apk/*
  touch ~/.bashrc
  curl -o- -L https://yarnpkg.com/install.sh | bash
fi

wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.11.tar.gz
tar -xvzf libiconv-1.11.tar.gz
cd libiconv-1.11
./configure --prefix=/usr/local/libiconv
make install
