# kube-ansible

## Cloud Support

* [ ] Azure
* [ ] Aws
* [x] GCP(Apiserver HA use the TCP Load balancing)

## OS Support

* [x] CentOS 7.*
* [x] Ubuntu 16.04.6
* [ ] Ubuntu 18.04.6

## Kubernetes Support

* [x] 1.14.x
* [x] 1.15.x
* [x] 1.16.x
* [x] 1.17.x
* [x] 1.18.x

## How to use

### clone code

```
# ubuntu
apt install git make -y
# centos
yum install git make -y
git clone https://github.com/buxiaomo/kube-ansible.git /usr/local/src/kube-ansible
cd /usr/local/src/kube-ansible
```

### install ansible

```
make runtime
```

### download binaries

if you want to use local package files, Reference [here](#local).

```
# default version
make download
make sync
make install

# custom version
make download KUBE_VERSION=1.16.8 DOCKER_VERSION=19.03.8 FLANNEL_VERSION=0.12.0 ETCD_VERSION=3.4.5
make install KUBE_VERSION=1.16.8 DOCKER_VERSION=19.03.8 FLANNEL_VERSION=0.12.0 ETCD_VERSION=3.4.5
```

### deploy

```
# default version
make install

# custom version
make install KUBE_VERSION=1.16.8 DOCKER_VERSION=19.03.8 FLANNEL_VERSION=0.12.0 ETCD_VERSION=3.4.5
```

### auto deploy
```
# default version
make

# custom version
make KUBE_VERSION=1.16.8 DOCKER_VERSION=19.03.8 FLANNEL_VERSION=0.12.0 ETCD_VERSION=3.4.5
```

## <span id = "local">use local package</span>

download package save to `scripts/src` directory.

package name format:

* docker-${DOCKER_VERSION}.tgz
* flannel-v${FLANNEL_VERSION}-linux-amd64.tar.gz
* etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
* kubernetes-client-linux-amd64.v${KUBE_VERSION}.tar.gz
* kubernetes-server-linux-amd64.v${KUBE_VERSION}.tar.gz
* cni-plugins-linux-amd64-v${CNI_VERSION}.tgz

all version please consistent with the makefile or make command

example: 

```
cd scripts/src
KUBE_VERSION=1.14.4
wget https://download.docker.com/linux/static/stable/x86_64/docker-19.03.8.tgz
wget https://github.com/coreos/flannel/releases/download/v0.12.0/flannel-v0.12.0-linux-amd64.tar.gz
wget https://dl.k8s.io/v${KUBE_VERSION}/kubernetes-client-linux-amd64.tar.gz -O kubernetes-client-linux-amd64.v${KUBE_VERSION}.tar.gz
wget https://dl.k8s.io/v${KUBE_VERSION}/kubernetes-server-linux-amd64.tar.gz -O kubernetes-server-linux-amd64.v${KUBE_VERSION}.tar.gz
wget https://github.com/coreos/etcd/releases/download/v3.4.5/etcd-v3.4.5-linux-amd64.tar.gz
wget https://github.com/containernetworking/plugins/releases/download/v0.8.5/cni-plugins-linux-amd64-v0.8.5.tgz
```

# knowledge

* [kubernetes](https://github.com/kubernetes/kubernetes) 
* [kubernetes command line tools reference](https://kubernetes.io/zh/docs/reference/command-line-tools-reference/feature-gates/)
* [calico](https://docs.projectcalico.org/getting-started/kubernetes/quickstart)
* [canal](https://docs.projectcalico.org/getting-started/kubernetes/flannel/flannel) 
* [flannel](https://github.com/coreos/flannel#flannel)

# issue

* New node kube-proxy not ready
* K8S custom setting CIDR
* Add check svc、pod ip is on host cird
* Deploy flannel failure
* Flag --experimental-encryption-provider-config has been deprecated, use --encryption-provider-config

# future

* Support ca update
* Support version update
* Standardize log

<!-- 

NS
env=
name=
project=


ansible-playbook -i hosts install.yml -t kube-master --start-at-task "Install some applications"

ansible-playbook -i hosts install.yml --list-tags
ansible-playbook -i hosts install.yml --list-tasks

ansible-playbook -i hosts install.yml -e force=$(force)
ansible-playbook -i hosts install.yml -t common
ansible-playbook -i hosts install.yml -t ca
ansible-playbook -i hosts install.yml -t etcd
ansible-playbook -i hosts install.yml -t kubernetes-init
ansible-playbook -i hosts install.yml -t kube-master
ansible-playbook -i hosts install.yml -t kube-worker
ansible-playbook -i hosts install.yml -t addons

ansible-playbook -i hosts install.yml -t test


Master: 
systemctl stop kube-apiserver.service kube-scheduler.service kube-controller-manager.service kube-proxy.service kubelet.service etcd.service
systemctl start kube-apiserver.service kube-scheduler.service kube-controller-manager.service etcd.service kube-proxy.service kubelet.service
systemctl restart kube-apiserver.service kube-scheduler.service kube-controller-manager.service kube-proxy.service kubelet.service

Minion: 
systemctl stop kube-proxy.service kubelet.service -->