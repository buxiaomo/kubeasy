SHELL := /bin/bash

# Debug model
DEBUG := false

# binary file download way, official or nexus
DOWNLOAD_WAY := "official"

# binary version
KUBE_VERSION := "1.14.4"
DOCKER_VERSION := "19.03.9"
ETCD_VERSION := "3.4.5"
CNI_VERSION := "0.8.5"

# nexus information
NEXUS_HTTP_USERNAME := ""
NEXUS_HTTP_PASSWORD := ""
NEXUS_DOMAIN_NAME := "nexus.xiaomo.site"
NEXUS_REPOSITORY := "kube-ansible"

auto: runtime download sync
	@make install

install:
	@echo -e "\033[32mDeploy kubernetes...\033[0m"
	@[ -f group_vars/all.yml ] || cp group_vars/template.yml group_vars/all.yml
	@[ -f ./inventory/hosts ] || ( echo -e "\033[31mPlease Create asset information...\033[0m" && exit 1 )
	@ansible-playbook install.yml
	@echo "source /etc/bash_completion.d/kubectl"

scale: download sync
	@echo -e "\033[32mScale kubernetes node...\033[0m"
	@ansible-playbook scale.yml	

upgrade: download sync
	@echo -e "\033[32mUpgrade kubernetes...\033[0m"
	@ansible-playbook upgrade.yml

uninstall:
	@echo -e "\033[32mUninstall kubernetes...\033[0m"
	@ansible-playbook uninstall.yml

download:
	@echo -e "\033[32mDownload the binaries package to ./scripts/binaries directory...\033[0m"
	@export DEBUG=$(DEBUG) \
	&& export KUBE_VERSION=$(KUBE_VERSION) \
	&& export DOCKER_VERSION=$(DOCKER_VERSION) \
	&& export FLANNEL_VERSION=$(FLANNEL_VERSION) \
	&& export ETCD_VERSION=$(ETCD_VERSION) \
	&& export CNI_VERSION=$(CNI_VERSION) \
	&& export NEXUS_HTTP_USERNAME=$(NEXUS_HTTP_USERNAME) \
	&& export NEXUS_HTTP_PASSWORD=$(NEXUS_HTTP_PASSWORD) \
	&& export NEXUS_DOMAIN_NAME=$(NEXUS_DOMAIN_NAME) \
	&& export NEXUS_REPOSITORY=$(NEXUS_REPOSITORY) \
	&& bash scripts/$(DOWNLOAD_WAY)-download.sh

runtime:
	@echo -e "\033[32mDeploy ansible...\033[0m"
	@scripts/runtime.sh

sync:
	@echo -e "\033[32mSync binary...\033[0m"
	@echo "Sync docker binaries from scripts/binaries"
	@rsync -a ./scripts/binaries/docker/$(DOCKER_VERSION)/* ./roles/docker/files/ --delete
	@echo "Sync etcd binaries from scripts/binaries"
	@rsync -a ./scripts/binaries/etcd/$(ETCD_VERSION)/* ./roles/etcd/files/ --delete
	@echo "Sync kubernetes binaries from scripts/binaries"
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kube-apiserver ./roles/kube-apiserver/files/kube-apiserver --delete	
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kubectl ./roles/kubectl/files/kubectl --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kubelet ./roles/kubelet/files/kubelet --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kube-controller-manager ./roles/kube-controller-manager/files/kube-controller-manager --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kube-scheduler ./roles/kube-scheduler/files/kube-scheduler --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kube-proxy ./roles/kube-proxy/files/kube-proxy --delete
	@echo "Sync cni-plugins binaries from scripts/binaries"
	@rsync -a ./scripts/binaries/cni-plugins/$(CNI_VERSION)/* ./roles/cni-plugins/files/ --delete
	@echo -e "\033[32mPlaybook is ready. Enjoy!\033[0m"

test:
	@./test/podman/Makefile test