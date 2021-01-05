[![coverage report](https://gitlab.com/cmc_system/cmc/badges/master/coverage.svg)](https://gitlab.com/cmc_system/cmc/commits/master)

# About
Ticktensio is a feature-rich time tracker. Its features include
* easy time tracking
* project management
* wiki
* document uploads (archive)
* user managment (e.g assigen rolles)

I wrote this because I was unsatisfied with existing solutions.


# Setup for development
- Install docker and docker-compose
- Execute:  git clone git@gitlab.com:cmc_system/cmc.git
- Execute: docker-compose run app bin/setup
- Execute: docker-compose run payment mix ecto.setup
- Execute: docker-compose up
- open http://test-organization.lvh.me:3000 

NOTE: Take a look on the [contributing.md](CONTRIBUTING.md)

# Setup for production
Right now we only support the kubernetics packet manager named helm.
- Create a Kubernetics cluster
- Install helm on it
- Execute: git clone git@gitlab.com:cmc_system/cmc.git
- Execute: cd cmc
- Execute: helm install cmc/ --name ticktensio

NOTE: The configuration options for
the helm package can be found [here](cmc/README.md)

# Tests
* rspec: docker-compose run app bin/setup
* cucumber:
  * docker-compose up
  * wait until app is ready
  * docker-compose run app cucumber

# Linters
* ESLint (Javascipt): docker-compose run yarn eslint
* RuboCop (Ruby): docker-compose run rubocop

# Links
homepage: https://about.ticktensio.com/
