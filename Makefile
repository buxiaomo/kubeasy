SHELL := /bin/bash

DOWNLOAD_WAY := "official"

KUBE_VERSION := "1.14.1"
DOCKER_VERSION := "19.03.8"
FLANNEL_VERSION := "0.12.0"
ETCD_VERSION := "3.4.5"
CNI_VERSION := "0.8.5"
DEBUG := true

HTTP_USERNAME := ""
HTTP_PASSWORD := ""

auto: runtime download sync
	@make install

install:
	@[ -f group_vars/all.yml ] || cp group_vars/all.yml group_vars/template.yml
	@ansible-playbook -i hosts install.yml

uninstall:
	@ansible-playbook uninstall.yml

upgrade:
	@ansible-playbook upgrade.yml

download:
	@echo 'Download the binaries package to ./scripts/binaries directory...'
	@export DEBUG=$(DEBUG) \
	&& export KUBE_VERSION=$(KUBE_VERSION) \
	&& export DOCKER_VERSION=$(DOCKER_VERSION) \
	&& export FLANNEL_VERSION=$(FLANNEL_VERSION) \
	&& export ETCD_VERSION=$(ETCD_VERSION) \
	&& export CNI_VERSION=$(CNI_VERSION) \
	&& export HTTP_USERNAME=$(HTTP_USERNAME) \
	&& export HTTP_PASSWORD=$(HTTP_PASSWORD) \
	&& bash scripts/$(DOWNLOAD_WAY)-download.sh

runtime:
	@scripts/runtime.sh

sync:
	@rsync -a ./scripts/binaries/docker/$(DOCKER_VERSION)/* ./roles/docker/files/ --delete
	@rsync -a ./scripts/binaries/etcd/$(ETCD_VERSION)/* ./roles/etcd/files/ --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kube-apiserver ./roles/kube-apiserver/files/kube-apiserver --delete	
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kubectl ./roles/kubectl/files/kubectl --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kubelet ./roles/kubelet/files/kubelet --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kube-controller-manager ./roles/kube-controller-manager/files/kube-controller-manager --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kube-scheduler ./roles/kube-scheduler/files/kube-scheduler --delete
	@rsync -a ./scripts/binaries/kubernetes/$(KUBE_VERSION)/kube-proxy ./roles/kube-proxy/files/kube-proxy --delete
	@rsync -a ./scripts/binaries/cni-plugins/$(CNI_VERSION)/* ./roles/cni-plugins/files/ --delete
	@echo "Playbook is ready. Enjoy!"

check:
	@ansible -i hosts all -m ping
	# @ansible-playbook -i hosts --check install.yml
	@ping -c 3 $(awk -F "=" "/^VIP/{print \$2}" hosts) 2> /dev/null