container=docker ps | grep -m 1 cmc_app | cut -d ' ' -f1
uid=if [ "$$(uname -s)" = "Darwin" ]; then echo "1000"; else id -u; fi
gid=if [ "$$(uname -s)" = "Darwin" ]; then echo "1000"; else id -g; fi

docker_compose=uid=$$($(uid)) gid=$$($(gid)) docker-compose
docker_exec_app=docker exec -it $$($(container))
docker_start=\
  if [ -z "$$($(container))" ]; then \
    $(docker_compose) -f docker-compose.yml -f docker-compose.xmake.yml up -d; \
  fi


install:
	@echo "what kind of installation do you want?"
	@echo "- 1. development"
	@echo "- 2. production"
	@read option; \
	  if [ $$option -eq 1 ]; then make -s install_develop; \
	  else make -s install_production; fi

install_production:
	@./production_install.sh
	@echo "true"

install_develop:
	@bash ./develop_install.sh
	@echo "true"

setup:
	@$(docker_compose) build
	@$(docker_compose) down
	@$(docker_start)
	@$(docker_exec_app) setup

build:
	@$(docker_compose) down
	@$(docker_compose) build

build_and_push_test_image:
	@$(eval IMAGE:="registry.gitlab.com/cmc_system/cmc/cmc:test")
	@docker build -f DockerfileGitlab -t $(IMAGE) .
	@docker push ${IMAGE}

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
	@echo "docker exec $$($(container)) eslint app/javascript/ spec/"

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
