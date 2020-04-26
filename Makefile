SHELL := /bin/bash

DEBUG := false

DOWNLOAD_WAY := "official"

KUBE_VERSION := "1.17.5"
DOCKER_VERSION := "19.03.8"
FLANNEL_VERSION := "0.12.0"
ETCD_VERSION := "3.4.5"
CNI_VERSION := "0.8.5"

NEXUS_HTTP_USERNAME := ""
NEXUS_HTTP_PASSWORD := ""
NEXUS_DOMAIN_NAME := "nexus.xiaomo.site"
NEXUS_REPOSITORY := "kube-ansible"

force := false

auto: runtime download sync
	@make install

install:
	@echo -e "\033[32mDeploy kubernetes...\033[0m"
	@[ -f group_vars/all.yml ] || cp group_vars/template.yml group_vars/all.yml
	@[ -f ./inventory/hosts ] || echo "Create asset information"
	@ansible-playbook install.yml -e force=$(force)
	@echo "source /etc/bash_completion.d/kubectl.sh"

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
	@rsync -a ./scripts/binaries/docker/$(DOCKER_VERSION)/* ./roles/docker/files/ --delete
	@rsync -a ./scripts/binaries/etcd/$(ETCD_VERSION)/* ./roles/etcd/files/ --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kube-apiserver ./roles/kube-apiserver/files/kube-apiserver --delete	
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kubectl ./roles/kubectl/files/kubectl --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kubelet ./roles/kubelet/files/kubelet --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kube-controller-manager ./roles/kube-controller-manager/files/kube-controller-manager --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kube-scheduler ./roles/kube-scheduler/files/kube-scheduler --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kube-proxy ./roles/kube-proxy/files/kube-proxy --delete
	@rsync -a ./scripts/binaries/cni-plugins/$(CNI_VERSION)/* ./roles/cni-plugins/files/ --delete
	@echo -e "\033[32mPlaybook is ready. Enjoy!\033[0m"

# check:
# 	@ansible all -m ping
# 	# @ansible-playbook --check install.yml
# 	@ping -c 3 $(awk -F "=" "/^VIP/{print \$2}" hosts) 2> /dev/null