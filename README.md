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
- Install docker and docker-compose and then:
- Execute: ./dc-exec setup
- Execute: ./db-exec rails s -b 0.0.0.0
- browse to: http://lvh.me:3000

On windows:
- Install docker and docker compose
- Enable virtualization
- docker-compose run --rm app setup
- docker-compose up

NOTE: ./dc-exec can be used to execute every comand inside the conatainer E.g.
- ./dc-exec ls
- ./dc-exec rspec
- ...

NOTE: We recomend to move ./dc-exec to the bin folder, so that you can
use dc-exec instead ./dc-exec
- Execute: cp ./dc-exec /usr/local/bin

NOTE: Take a look on the [contributing.md](CONTRIBUTING.md)

# Setup for production
Right now we only support the kubernetics packet manager named helm.
- Create a Kubernetics cluster
- Install helm on it
- Execute: git clone git@gitlab.com:cmc_system/cmc.git
- Execute: cd cmc
- Execute: helm install cmc/ --name cmc-production

NOTE: The configuration options for
the helm package can be found [here](cmc/README.md)

# Setup up linters (e.g for atom)
eslint:
- Execute: ./dc-exec eslint app/javascipt spec

gitlinter:
- Install pip (eg. sudo apt-get install pip)
- Execute: pip install gitlint
- Execute: git log -1 --pretty=%B | gitlint

atom (using docker-compose):
- eslinter
  * Execute: apm install linter-eslint
  * Select global npm option
  * Set command: ./dc-exec --no-interactive eslint
- rubocop:
  * apm install linter-rubocop
  * set command: ./dc-exec --no-interactive rubocop

vim:
Just install the w0rp/ale plugin.


# Links
homepage: https://about.cost-manager.com
