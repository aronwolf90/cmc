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
apk add tar
apk add gzip
apk add binutils-gold
apk add gnupg
apk add libgcc
apk add linux-headers
apk add python
apk add libstdc++
apk add xz

addgroup -g 1000 node \
    && adduser -u 1000 -G node -s /bin/sh -D node

curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz"
tar -xf "node-v$NODE_VERSION.tar.xz"
cd "node-v$NODE_VERSION"
./configure
make -j$(getconf _NPROCESSORS_ONLN)
make install
cd ..
rm -Rf "node-v$NODE_VERSION"
rm "node-v$NODE_VERSION.tar.xz"

curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz"
mkdir -p /opt
tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/
ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/bin/yarn
rm yarn-v$YARN_VERSION.tar.gz

wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.11.tar.gz
tar -xvzf libiconv-1.11.tar.gz
cd libiconv-1.11
./configure --prefix=/usr/local/libiconv
make install

gem install bundler
