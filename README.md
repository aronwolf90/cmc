[![coverage report](https://gitlab.com/cmc_system/cmc/badges/master/coverage.svg)](https://gitlab.com/cmc_system/cmc/commits/master)

* coverage: https://cmc_system.gitlab.io/cmc/coverage/
* rubycritic: https://cmc_system.gitlab.io/cmc/rubycritic/code_index.html

# About
CMC is a feature-rich time tracker. Its features include
* easy session tracking
* scrum project management
* extended project information including prioritizing
* wiki

I wrote this because I was unsatisfied with existing solutions.


# Setup for development
On linux and mac:
- Install make (sudo apt-get install make or brew install make)
- make install_develop
- xmake server (or xmake rails s)

On windows:
- Install docker and docker compose
- Enable virtualizaton
- docker-compose up

note: you can execute every command prefixing t with xmake. E.g
- xmake ls
- xmake rspec
- ...

# Setup up linters (e.g for atom)
rubocop:
- install ruby (see version on Gemfile)
- install cmake (eg. sudo apt-get install cmake)
- gem install pronto
- gem install pronto-rubocop
- gem install rubocop-rails
- gem install rubocop-rspec

eslint:
- npm install -g \
  eslint eslint-config-standard \
  eslint-plugin-import \
  eslint-plugin-node \
  eslint-plugin-standard \
  eslint-config-standart \
  eslint-plugin-promise \
  eslint-plugin-vue

gitlinter:
- install pip (eg. sudo apt-get install pip)
- pip install gitlint
- git log -1 --pretty=%B | gitlint

atom:
- apm install linter-rubocop
- apm install linter-eslint
- select global npm option (eslint package)

# CI
When the automatic test become to slow, it can help that an administrator (e.g. Aron Wolf) execute:
  - scripts/build_and_push_cmc_prebuild.sh

# Notices
When the build command (scripts/build.sh) become to slow, execute this:
  - build_prebuild
