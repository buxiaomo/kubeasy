# kube-ansible

## Cloud Support

* [x] Azure

## OS Support

* [x] Ubuntu 16.04.6
* [x] CentOS 7.*


## How to use

### clone code

```
apt install make -y
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

<!-- 
ansible-playbook -i hosts install.yml -t kube-master --start-at-task "Install some applications"

ansible-playbook -i hosts install.yml --list-tags
ansible-playbook -i hosts install.yml --list-tasks

ansible-playbook -i hosts install.yml -t common
ansible-playbook -i hosts install.yml -t ca
ansible-playbook -i hosts install.yml -t etcd
ansible-playbook -i hosts install.yml -t kube-master
ansible-playbook -i hosts install.yml -t kube-minion


Master: 
systemctl stop kube-apiserver.service kube-scheduler.service kube-controller-manager.service kube-proxy.service kubelet.service etcd.service
systemctl start kube-apiserver.service kube-scheduler.service kube-controller-manager.service etcd.service kube-proxy.service kubelet.service
systemctl restart kube-apiserver.service kube-scheduler.service kube-controller-manager.service kube-proxy.service kubelet.service

Minion: 
systemctl stop kube-proxy.service kubelet.service -->