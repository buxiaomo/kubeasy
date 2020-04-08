# kube-ansible

## Cloud Support

* [ ] Azure
* [ ] Aws
* [ ] GCP

## OS Support

* [x] CentOS 7.*
* [ ] Ubuntu 16.04.6
* [ ] Ubuntu 18.04.6


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

# issue

* New node kube-proxy not ready


<!-- 

NS
env=
name=
project=


ansible-playbook -i hosts install.yml -t kube-master --start-at-task "Install some applications"

ansible-playbook -i hosts install.yml --list-tags
ansible-playbook -i hosts install.yml --list-tasks

ansible-playbook -i hosts install.yml -t common
ansible-playbook -i hosts install.yml -t ca
ansible-playbook -i hosts install.yml -t etcd
ansible-playbook -i hosts install.yml -t kube-master
ansible-playbook -i hosts install.yml -t kube-minion

ansible-playbook -i hosts install.yml -t test


Master: 
systemctl stop kube-apiserver.service kube-scheduler.service kube-controller-manager.service kube-proxy.service kubelet.service etcd.service
systemctl start kube-apiserver.service kube-scheduler.service kube-controller-manager.service etcd.service kube-proxy.service kubelet.service
systemctl restart kube-apiserver.service kube-scheduler.service kube-controller-manager.service kube-proxy.service kubelet.service

Minion: 
systemctl stop kube-proxy.service kubelet.service -->


k8s                                                           Manage Kubernetes (K8s) objects
k8s_auth                                                      Authenticate to Kubernetes clusters which require an explicit login step
k8s_info                                                      Describe Kubernetes (K8s) objects
k8s_scale                                                     Set a new size for a Deployment, ReplicaSet, Replication Controller, or Job
k8s_service                                                   Manage Services on Kubernetes