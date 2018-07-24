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

NOTICE: You can also use it without docker, but because we rarelly test
it without it, there can be some configuration errors. If this is the case,
pleas feal free to submit a MR or an issue.

# Setup for production
on Upuntu (should also work on debian):
- make install_production

On other:
- Install kuberntics
- Install helm (kubernetics packet manager)
- Eexecute: helm install chart --name cmc-production \
             --set image.tag=latest \
             --set remote=true \
             --force

# Setup up linters (e.g for atom)
eslint:
- Execute: xmake eslint app/javascipt spec

gitlinter:
- Install pip (eg. sudo apt-get install pip)
- pip install gitlint
- git log -1 --pretty=%B | gitlint

atom:
- eslinter
  * apm install linter-eslint
  * select global npm option
  * set command: xmake eslint (to execute it inside docker)
- rubocop:
  * apm install linter-rubocop
  * set command: xmake rubocop (to execute it inside docker)
