container=docker ps | grep -m 1 cmc_app_run | cut -d ' ' -f1
uid=id -u
gid=id -g

docker_compose=uid=$$($(uid)) gid=$$($(gid)) docker-compose
docker_exec_app=docker exec -it $$($(container))
docker_start=if [ -z "$$($(container))" ]; then uid=$($(uid)) gid=$($(gid)) docker-compose run --rm --service-ports -d app spring server; fi


install:
	@echo "what kind of installation do you want?"
	@echo "- 1. development"
	@echo "- 2. production"
	@read option; \
	  if [ $$option -eq 1 ]; then make -s install_develop; \
	  else make -s install_production; fi

install_production: install_docker
	@if ! apt-get -v > /dev/null 2>1; then \
	   echo "this script only support ubuntu, but you can do it manually:"; \
	   echo "1. install kubernetics"; \
	   echo "2. install helm"; \
	   echo "3 execute: helm install chart"; \
	   echo "  --name cmc-production"; \
	   echo "  --set image.tag=latest"; \
	   echo "  --set remote=true"; \
	   echo "  --force;" \
	   exit; \
	 fi;
	# this will install kubernetics if it is not installed
	@if ! kubectl --help > /dev/null 2>1; then \
          sudo apt-get install apt-transport-https curl; \
	  curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add; \
          sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" \
	  sudo apt-get update -y; \
	  sudo apt-get install -y kubeadm kubectl; \
	  sudo systemctl enable docker.service; \
	  sudo bash -c 'echo "vm.swappiness=10" >> /etc/sysctl.conf'; \
	  sudo swapoff -a; \
	  sudo kubeadm init; \
	  sudo mkdir -p $$HOME/.kube; \
	  sudo cp -i /etc/kubernetes/admin.conf $$HOME/.kube/config; \
          sudo chown $$(id -u):$$(id -g) $HOME/.kube/config \
	  sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml; \
	  sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml; \
         fi
	# this will install helm if it is not installed (kubernetics packet manager)
	@if ! helm -v > /dev/null 2>1; then \
	  sudo kubectl taint nodes mymasternode dedicated-; \
	  sudo curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh; \
	  sudo chmod 700 get_helm.sh; \
	  sudo ./get_helm.sh; \
	  sudo helm init --wait; \
	 fi
	# this will deploy the application
	@helm install chart --name cmc-production \
          --set image.tag=latest \
          --set remote=true

install_develop: install_docker install_xmake setup
	@echo "successfully installed!!!!!"
	@echo
	@echo "pleas use xmake for every Makefile commant"
	@echo "useful commands:"
	@echo "- xmake server: run the server"
	@echo "- xmake bash: for run a bash shell inside docker"
	@echo "true"

install_docker:
	@if ! docker -v > /dev/null 2>1 && ! docker-compose -v > /dev/null 2>1; then \
	  if apt-get -v 2> /dev/null >1; then \
            sudo apt-get update; \
	    sudo apt-get install docker.io docker-compose; \
	  elif brew -v > /dev/null 2>1; then \
	    brew install docker docker-compose docker-machine xhyve docker-machine-driver-xhyve; \
	    sudo chown root:wheel $$(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve; \
	    sudo chmod u+s $$(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve; \
	  else \
	    echo "can not install docker on yur machine, so pleas do one of this things"; \
	    echo "- on linux: go to https://docs.docker.com/install/#server, click on yut linux distribution and folow the instructions"; \
	    echo "- on mac: follow the instructions on https://docs.docker.com/docker-for-mac/install/ or install brew"; \
	    exit; \
	  fi; \
	fi

install_xmake:
	@sudo cp xmake /usr/local/bin/xmake

setup:
	@$(docker_compose) build
	@$(docker_compose) down
	@$(docker_start)
	@$(docker_exec_app) setup

build:
	@$(docker_compose) down

build_and_push_test_image:
	@$(eval IMAGE:="registry.gitlab.com/cmc_system/cmc/cmc:test")
	@echo "rest"
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
