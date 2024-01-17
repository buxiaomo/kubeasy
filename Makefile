SHELL := /bin/bash

# Cluster information use by pki project
PROJECT_NAME:=kubeasy
PROJECT_ENV:=dev

# Binary file download way, official or nexus
DOWNLOAD_WAY:=official

# kubernetes version
KUBE_VERSION:=1.27.10
ETCD_VERSION:=3.5.7
CNI_VERSION:=1.4.0

# kubernetes container runtime
# only support containerd
KUBE_RUNTIME:=containerd
DOCKER_VERSION:=20.10.17

CONTAINERD_VERSION:=1.7.12
CRICTL_VERSION:=1.27.0
RUNC_VERSION:=1.1.11

# kubernetes network plugin
# flannel, calico, canal, cilium, none
KUBE_NETWORK:=flannel

# Private registry
# eg: 
# https://192.168.119.20:5000/infra
# http://192.168.119.20:5000/infra
# https://192.168.119.20/infra
# http://192.168.119.20/infra
# http://192.168.119.20
# https://192.168.119.20
REGISTRY_URL:=

# Nexus information
# eg: http://192.168.119.20:5001
NEXUS_DOMAIN_NAME:=
NEXUS_REPOSITORY:=kubeasy
NEXUS_USERNAME:=
NEXUS_PASSWORD:=

# PKI server
# PKI_URL:=http://192.168.119.20:8000/v1/pki/project
PKI_URL:=

# e2e test software version
SONOBUOY_VERSION:=0.56.14

# Install ansible on depoy server
runtime:
	@./scripts/runtime.sh

hosts:
	@[ -f ./inventory/$(PROJECT_NAME)-$(PROJECT_ENV).ini ] || cp ./inventory/template/etcd-on-master.template ./inventory/$(PROJECT_NAME)-$(PROJECT_ENV).ini
	@vi ./inventory/$(PROJECT_NAME)-$(PROJECT_ENV).ini

deploy: 
	@make -C group_vars/ >/dev/null 2>&1
	@[ -f ./inventory/${PROJECT_NAME}-${PROJECT_ENV}.ini ] || ( echo -e "\033[31mPlease Create './inventory/${PROJECT_NAME}-${PROJECT_ENV}.ini' file...\033[0m" && exit 1 )
	@PROJECT_NAME=$(PROJECT_NAME) \
		PROJECT_ENV=$(PROJECT_ENV) \
		DOWNLOAD_WAY=$(DOWNLOAD_WAY) \
		KUBE_VERSION=$(KUBE_VERSION) \
		ETCD_VERSION=$(ETCD_VERSION) \
		CNI_VERSION=$(CNI_VERSION) \
		KUBE_RUNTIME=$(KUBE_RUNTIME) \
		DOCKER_VERSION=$(DOCKER_VERSION) \
		CONTAINERD_VERSION=$(CONTAINERD_VERSION) \
		CRICTL_VERSION=$(CRICTL_VERSION) \
		RUNC_VERSION=$(RUNC_VERSION) \
		KUBE_RUNTIME=$(KUBE_RUNTIME) \
		KUBE_NETWORK=$(KUBE_NETWORK) \
		REGISTRY_URL=$(REGISTRY_URL) \
		NEXUS_DOMAIN_NAME=$(NEXUS_DOMAIN_NAME) \
		NEXUS_REPOSITORY=$(NEXUS_REPOSITORY) \
		NEXUS_USERNAME=$(NEXUS_USERNAME) \
		NEXUS_PASSWORD=$(NEXUS_PASSWORD) \
		PKI_URL=$(PKI_URL) ./scripts/action.sh deploy

scale: 
	@PROJECT_NAME=$(PROJECT_NAME) \
		PROJECT_ENV=$(PROJECT_ENV) \
		DOWNLOAD_WAY=$(DOWNLOAD_WAY) \
		KUBE_VERSION=$(KUBE_VERSION) \
		ETCD_VERSION=$(ETCD_VERSION) \
		CNI_VERSION=$(CNI_VERSION) \
		KUBE_RUNTIME=$(KUBE_RUNTIME) \
		DOCKER_VERSION=$(DOCKER_VERSION) \
		CONTAINERD_VERSION=$(CONTAINERD_VERSION) \
		CRICTL_VERSION=$(CRICTL_VERSION) \
		RUNC_VERSION=$(RUNC_VERSION) \
		KUBE_RUNTIME=$(KUBE_RUNTIME) \
		KUBE_NETWORK=$(KUBE_NETWORK) \
		REGISTRY_URL=$(REGISTRY_URL) \
		NEXUS_DOMAIN_NAME=$(NEXUS_DOMAIN_NAME) \
		NEXUS_REPOSITORY=$(NEXUS_REPOSITORY) \
		NEXUS_USERNAME=$(NEXUS_USERNAME) \
		NEXUS_PASSWORD=$(NEXUS_PASSWORD) \
		PKI_URL=$(PKI_URL) ./scripts/action.sh scale

update: 
	@PROJECT_NAME=$(PROJECT_NAME) \
		PROJECT_ENV=$(PROJECT_ENV) \
		DOWNLOAD_WAY=$(DOWNLOAD_WAY) \
		KUBE_VERSION=$(KUBE_VERSION) \
		ETCD_VERSION=$(ETCD_VERSION) \
		CNI_VERSION=$(CNI_VERSION) \
		KUBE_RUNTIME=$(KUBE_RUNTIME) \
		DOCKER_VERSION=$(DOCKER_VERSION) \
		CONTAINERD_VERSION=$(CONTAINERD_VERSION) \
		CRICTL_VERSION=$(CRICTL_VERSION) \
		RUNC_VERSION=$(RUNC_VERSION) \
		KUBE_RUNTIME=$(KUBE_RUNTIME) \
		KUBE_NETWORK=$(KUBE_NETWORK) \
		REGISTRY_URL=$(REGISTRY_URL) \
		NEXUS_DOMAIN_NAME=$(NEXUS_DOMAIN_NAME) \
		NEXUS_REPOSITORY=$(NEXUS_REPOSITORY) \
		NEXUS_USERNAME=$(NEXUS_USERNAME) \
		NEXUS_PASSWORD=$(NEXUS_PASSWORD) \
		PKI_URL=$(PKI_URL) ./scripts/action.sh update

upgrade: 
	@PROJECT_NAME=$(PROJECT_NAME) \
		PROJECT_ENV=$(PROJECT_ENV) \
		DOWNLOAD_WAY=$(DOWNLOAD_WAY) \
		KUBE_VERSION=$(KUBE_VERSION) \
		ETCD_VERSION=$(ETCD_VERSION) \
		CNI_VERSION=$(CNI_VERSION) \
		KUBE_RUNTIME=$(KUBE_RUNTIME) \
		DOCKER_VERSION=$(DOCKER_VERSION) \
		CONTAINERD_VERSION=$(CONTAINERD_VERSION) \
		CRICTL_VERSION=$(CRICTL_VERSION) \
		RUNC_VERSION=$(RUNC_VERSION) \
		KUBE_RUNTIME=$(KUBE_RUNTIME) \
		KUBE_NETWORK=$(KUBE_NETWORK) \
		REGISTRY_URL=$(REGISTRY_URL) \
		NEXUS_DOMAIN_NAME=$(NEXUS_DOMAIN_NAME) \
		NEXUS_REPOSITORY=$(NEXUS_REPOSITORY) \
		NEXUS_USERNAME=$(NEXUS_USERNAME) \
		NEXUS_PASSWORD=$(NEXUS_PASSWORD) \
		PKI_URL=$(PKI_URL) ./scripts/action.sh upgrade

renew:
	@PROJECT_NAME=$(PROJECT_NAME) \
		PROJECT_ENV=$(PROJECT_ENV) \
		DOWNLOAD_WAY=$(DOWNLOAD_WAY) \
		KUBE_VERSION=$(KUBE_VERSION) \
		ETCD_VERSION=$(ETCD_VERSION) \
		CNI_VERSION=$(CNI_VERSION) \
		KUBE_RUNTIME=$(KUBE_RUNTIME) \
		DOCKER_VERSION=$(DOCKER_VERSION) \
		CONTAINERD_VERSION=$(CONTAINERD_VERSION) \
		CRICTL_VERSION=$(CRICTL_VERSION) \
		RUNC_VERSION=$(RUNC_VERSION) \
		KUBE_RUNTIME=$(KUBE_RUNTIME) \
		KUBE_NETWORK=$(KUBE_NETWORK) \
		REGISTRY_URL=$(REGISTRY_URL) \
		NEXUS_DOMAIN_NAME=$(NEXUS_DOMAIN_NAME) \
		NEXUS_REPOSITORY=$(NEXUS_REPOSITORY) \
		NEXUS_USERNAME=$(NEXUS_USERNAME) \
		NEXUS_PASSWORD=$(NEXUS_PASSWORD) \
		PKI_URL=$(PKI_URL) ./scripts/action.sh renew

version: 
	@command -v jq > /dev/null 2>&1 || ( echo -e "\033[32mPlease install jq\033[0m" &&  exit 1)
	@echo "etcd" > .etcd
	@curl -s `curl -s https://api.github.com/repos/coreos/etcd/releases | jq -r .url` | jq -r '.[].tag_name' | grep -Ev 'rc|beta|alpha' | sed 's/v//g' | head -n 15 | sort -r -V >> .etcd
	@echo "docker" > .docker
	@curl -s https://api.github.com/repos/moby/moby/releases | jq -r '.[].tag_name' | grep -Ev 'rc|beta|alpha|-ce' | sed 's/v//g' | head -n 15 | sort -r -V >> .docker
	@echo "kubernetes" > .kubernetes
	@curl -s https://api.github.com/repos/kubernetes/kubernetes/releases | jq -r '.[].tag_name' | grep -Ev 'rc|beta|alpha' | sed 's/v//g' | head -n 15 | sort -r -V >> .kubernetes
	@echo "containerd" > .containerd
	@curl -s https://api.github.com/repos/containerd/containerd/releases | jq -r '.[].tag_name' | grep -Ev 'rc|beta|alpha' | sed 's/v//g' | head -n 15 | sort -r -V >> .containerd
	@echo "crictl" > .crictl
	@curl -s https://api.github.com/repos/kubernetes-sigs/cri-tools/releases | jq -r '.[].tag_name' | grep -Ev 'rc|beta|alpha' | sed 's/v//g'| head -n 15 | sort -r -V >> .crictl
	@echo "runc" > .runc
	@curl -s https://api.github.com/repos/opencontainers/runc/releases | jq -r '.[].tag_name' | grep -Ev 'rc|beta|alpha' | sed 's/v//g'| head -n 15 | sort -r -V >> .runc
	@echo "cni" > .cni
	@curl -s https://api.github.com/repos/containernetworking/plugins/releases | jq -r '.[].tag_name' | grep -Ev 'rc|beta|alpha' | sed 's/v//g'| head -n 15 | sort -r -V >> .cni
	@echo "-------------------- Versions are not related! --------------------"
	@paste -d '|' .etcd .docker .kubernetes .containerd .crictl .runc .cni | column -t -s '|'
	@rm -rf .etcd .docker .kubernetes .containerd .crictl .runc .cni

check:
	@./tests/check-cluster.sh

help:
	@./scripts/help.sh

local: clean
	@mkdir -p .ssh
	@ssh-keygen -t RSA -N '' -f .ssh/id_rsa
	@[ -f ./inventory/${PROJECT_NAME}-${PROJECT_ENV}.ini ] || cp ./inventory/template/vagrant.template ./inventory/${PROJECT_NAME}-${PROJECT_ENV}.ini
	@vagrant up

clean:
	@rm -rf .ssh
	@vagrant destroy -f

e2e:
	@wget https://github.com/vmware-tanzu/sonobuoy/releases/download/v$(SONOBUOY_VERSION)/sonobuoy_$(SONOBUOY_VERSION)_linux_amd64.tar.gz -O /usr/local/src/sonobuoy_$(SONOBUOY_VERSION)_linux_amd64.tar.gz
	@tar -zxf /usr/local/src/sonobuoy_$(SONOBUOY_VERSION)_linux_amd64.tar.gz -C /usr/local/bin --exclude=LICENSE
	@sonobuoy run --image-pull-policy=IfNotPresent --mode=certified-conformance --wait
	@mkdir -p ./tests/k8s-conformance
	@tar -zxf `sonobuoy retrieve /tmp` --strip-components=4 -C ./tests/k8s-conformance plugins/e2e/results/global/e2e.log plugins/e2e/results/global/junit_01.xml
	@kubectl get nodes -o wide
	@sonobuoy results `sonobuoy retrieve /tmp`
	@sonobuoy delete --all

prepare:
	@./scripts/prepare.sh $(KUBE_VERSION)

download:
	@./scripts/nexus.py --kubernetes $(KUBE_VERSION) \
		--etcd $(ETCD_VERSION) \
		--cni $(CNI_VERSION) \
		--docker $(DOCKER_VERSION) \
		--containerd $(CONTAINERD_VERSION) \
		--runc $(RUNC_VERSION) \
		--crictl $(CRICTL_VERSION) download --quiet

upload:
	@./scripts/nexus.py --kubernetes $(KUBE_VERSION) \
		--etcd $(ETCD_VERSION) \
		--cni $(CNI_VERSION) \
		--docker $(DOCKER_VERSION) \
		--containerd $(CONTAINERD_VERSION) \
		--runc $(RUNC_VERSION) \
		--crictl $(CRICTL_VERSION) upload --url $(NEXUS_DOMAIN_NAME) --repository $(NEXUS_REPOSITORY)