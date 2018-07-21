container=docker ps | grep -m 1 cmc_app_run | cut -d ' ' -f1
uid=id -u
gid=id -g

docker_compose=uid=$$($(uid)) gid=$$($(gid)) docker-compose
docker_exec_app=docker exec -it $$($(container))
docker_start=if ! docker ps | grep cmc_app_run_1 1>/dev/null; then uid=$($(uid)) gid=$($(gid)) docker-compose run --rm --service-ports -d app sleep 7200; fi

install_develop:
	@if ! docker -v > /dev/null && docker-compose -v > /dev/null; then \
	  if apt-get -v; then \
	    sudo apt-get install docker.io docker-compose; \
	  elif brew -v > /dev/null; then \
	    brew install docker docker-compose docker-machine xhyve docker-machine-driver-xhyve; \
	    sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve; \
	    sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve; \
	  else \
	    echo "can not install docker on yur machine, so pleas do one of this things"; \
	    echo "- on linux: go to https://docs.docker.com/install/#server, click on yut linux distribution and folow the instructions"; \
	    echo "- on mac: follow the instructions on https://docs.docker.com/docker-for-mac/install/ or install brew"; \
	    exit; \
	  fi \
	fi

	@sudo cp xmake /usr/local/bin/xmake

	@$(docker_compose) build
	@xmake setup
	@echo "successfully installed!!!!!"
	@echo
	@echo "pleas use xmake for every Makefile commant except install and install_develop"
	@echo "useful commands:"
	@echo "- xmake server: run the server"
	@echo "- xmake bash: for run a bash shell inside docker"
	@echo ""

setup:
	@$(docker_compose) build
	@$(docker_compose) down
	@$(docker_start)
	@$(docker_exec_app) setup
	@echo ""

build:
	@$(docker_compose) down
	@echo "$(docker_compose) build"

build_and_push_test_image:
	@$(eval IMAGE:="registry.gitlab.com/cmc_system/cmc/cmc:test")
	@echo "rest"
	@docker build -f DockerfileGitlab -t $(IMAGE) .
	@docker push ${IMAGE}
	@echo ""

server:
	@$(docker_start)
	@echo "$(docker_exec_app) rails s"

down:
	@echo "$(docker_compose) down"

rubocop:
	@$(docker_start)
	@echo "docker exec $$($(container)) rubocop"

eslint:
	@$(docker_start)
	@echo "$(docker_exec_app) eslint app/javascript/ spec/"

rspec_guard:
	@$(docker_start)
	@echo "$(docker_exec_app) guard"

mocha:
	@$(docker_start)
	@echo "$(docker_exec_app) yarn test"

mocha_guard:
	@$(docker_start)
	@echo "$(docker_exec_app) yarn test:watch"

%:
	@$(docker_start)
	@echo "$(docker_exec_app) $(@)"
