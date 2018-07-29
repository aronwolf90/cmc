# !/bin/bash

# install docker
if ! docker -v > /dev/null 2>1 && ! docker-compose -v > /dev/null 2>1; then
  if apt-get -v 2> /dev/null >1; then
    sudo apt-get update
    sudo apt-get install docker.io docker-compose
  elif brew -v > /dev/null 2>1; then
    brew install docker docker-compose docker-machine xhyve docker-machine-driver-xhyve
    sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
    sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
  else
    echo "can not install docker on yur machine, so pleas do one of this things"
    echo "- on linux: go to https://docs.docker.com/install/#server, click on yut linux distribution and folow the instructions"
    echo "- on mac: follow the instructions on https://docs.docker.com/docker-for-mac/install/ or install brew"
    exit
  fi
fi

# install xmake
sudo cp xmake /usr/local/bin/xmake

# setup rails
make setup

# message
echo "successfully installed!!!!!"
echo
echo "pleas use xmake for every Makefile commant"
echo "useful commands:"
echo "- xmake server: run the server"
echo "- xmake bash: for run a bash shell inside docker"

