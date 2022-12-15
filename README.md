# kubeasy

This project will used ansible to deployment kubernetes.

Read the documentation to see how the project is used

`kubeasy` passed the [cncf conformance test](https://github.com/cncf/k8s-conformance), because k8s-conformance does not allow submission of personal projects, please check here for [details](https://github.com/buxiaomo/k8s-conformance)

* [group_vars/README.md](group_vars/README.md)
* [inventory/README.md](inventory/README.md)

## Cloud Support

* [x] Raspberry Pi
* [x] Azure
* [x] Aliyun
* [x] Aws (APIServer HA use the CLB)
* [x] GCP (APIServer HA use the TCP Load balancing)

## Architecture Support

* [x] aarch64 (only download from official)
* [x] x86_64

## OS Support

all node please install python.

* [x] CentOS (7.\*, 8.\*)
* [x] Ubuntu (16.\*, 18.\*, 20.\*, 21.\*, 22.\*) 
* [x] Debian (10.\*, 11.\*)
* [x] OpenSUSE 15
* [x] Alma Linux 9
* [x] Amazon Linux 2
* [x] Rocky Linux (8, 9)
* [x] Red Hat Enterprise Linux (7, 8)
* [x] SUSE Linux Enterprise Server 15

## kubeasy installs the version corresponding to the k8s component

| Kubernetes | Etcd | Docker | Containerd | CNI | CoreDNS | metrics-server | pause |
|---|---|---|---|---|---|---|---|
| [1.14.x](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.14.md) | v3.3.10  | v19.03.9  | v1.5.13 | v0.7.5 | v1.3.1 | v0.5.2 | 3.1    |
| [1.15.x](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.15.md) | v3.3.10  | v19.03.9  | v1.5.13 | v0.7.5 | v1.3.1 | v0.5.2 | 3.1    |
| [1.16.x](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.16.md) | v3.3.15  | v19.03.9  | v1.5.13 | v0.7.5 | v1.6.2 | v0.5.2 | 3.1    |
| [1.17.x](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.17.md) | v3.4.3   | v19.03.9  | v1.5.13 | v0.7.5 | v1.6.5 | v0.5.2 | 3.1    |
| [1.18.x](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.18.md) | v3.4.3   | v19.03.9  | v1.5.13 | v0.8.5 | v1.6.7 | v0.5.2 | 3.2    |
| [1.19.x](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.19.md) | v3.4.13  | v19.03.9  | v1.5.13 | v0.8.6 | v1.7.0 | v0.5.2 | 3.2    |
| [1.20.x](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.20.md) | v3.4.13  | v19.03.9  | v1.5.13 | v0.8.7 | v1.7.0 | v0.6.1 | 3.2    |
| [1.21.x](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.21.md) | v3.4.13  | v20.10.17 | v1.5.13 | v1.1.1 | v1.8.0 | v0.6.1 | 3.4.1  |
| [1.22.x](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.22.md) | v3.5.0   | v20.10.17 | v1.5.13 | v1.1.1 | v1.8.4 | v0.6.1 | 3.5    |
| [1.23.x](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.23.md) | v3.5.1   | v20.10.17 | v1.8.6  | v1.1.1 | v1.8.6 | v0.6.1 | 3.6    |
| [1.24.x](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.24.md) | v3.5.3   | N/A       | v1.8.6  | v1.1.1 | v1.8.6 | v0.6.1 | 3.6    |
| [1.25.x](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG/CHANGELOG-1.25.md) | v3.5.4   | N/A       | v1.8.6  | v1.1.1 | v1.9.3 | v0.6.1 | 3.8    |

## How to use

The playbook depends on `python2` or `python3` , all nodes need to install `python`

* [online deployment](#online)

* [offline deployment](#offline)

### <span id = "online">online</span>

#### Clone code

Gitee: https://gitee.com/buxiaomo/kubeasy.git

Gitlab: https://gitlab.com/buxiaomo/kubeasy.git

Github: https://github.com/buxiaomo/kubeasy.git

JiHulab: https://jihulab.com/buxiaomo/kubeasy.git

```
# ubuntu
apt-get update
apt-get install git make -y

# centos
yum install git make vim -y

# Install ansible
git clone -b v1.24 https://github.com/buxiaomo/kubeasy.git /usr/local/src/kubeasy
cd /usr/local/src/kubeasy
```
#### Install ansible
```
cd /usr/local/src/kubeasy
make runtime
```

#### Configuration parameters

Please modify the parameters on `group_vars` directory if you need

* [group_vars/README.md](group_vars/README.md)

#### Configuration inventory

```
cd /usr/local/src/kubeasy
make hosts
```

for example:

```
[master]
172.16.114.11
172.16.114.12
172.16.114.13

[worker]
172.16.114.14
172.16.114.15
172.16.114.16
172.16.114.17

[kubernetes:children]
master
worker

[kubernetes:vars]
; kubernetes network config
networking={"dnsDomain": "cluster.local", "serviceSubnet": "10.96.0.0/12", "podSubnet": "10.244.0.0/16"}

; ha config
; slb is software load balancing, will install harpoxy and keepalived on master node
; clb is cloud load balancing, will use cloud load balancing
ha={"type": "slb", "vip": "172.16.114.10", "mask": 16 }

; loadBalancing is 4 layer forwarding to ingress by haproxy, only used in slb
loadBalancing={"http": {"src": 80, "dest": 30001}, "https": {"src": 443, "dest": 30002}}

[all:vars]
ansible_ssh_port=22
ansible_ssh_user=root
ansible_ssh_pass=root
# ansible_sudo_user=root
# ansible_sudo_pass=root
```

For more instructions reference [inventory/README.md](inventory/README.md)

#### Kubernetes management
##### Deploy

[![asciicast](https://asciinema.org/a/533389.svg)](https://asciinema.org/a/533389)

```
cd /usr/local/src/kubeasy
make deploy
```

##### Scale

[![asciicast](https://asciinema.org/a/533392.svg)](https://asciinema.org/a/533392)

```
cd /usr/local/src/kubeasy
make scale
```

##### Update kubernetes configuration

```
cd /usr/local/src/kubeasy
make update
```

##### Renew kubernetes certificates

```
cd /usr/local/src/kubeasy
make renew
```

##### Upgrade kubernetes version

For version upgrades, reference [here](https://kubernetes.io/zh-cn/releases/version-skew-policy/)

```
cd /usr/local/src/kubeasy
git pull
git checkout v1.25
make upgrade KUBE_VERSION=<New Version>
```

### <span id = "offline">offline</span>

Offline installation is divided into the following four files, Download the corresponding files for your needs.

1. kubeasy-v${KUBEASY_VERSION}.tar.gz
    * software packages and Pod images will be downloaded from the Internet
2. kubeasy-binary-v${KUBEASY_VERSION}.tar.gz
    * software packages required to deploy kubernetes
3. kubeasy-registry-v${KUBEASY_VERSION}.tar.gz
    * Pod images required to deploy kubernetes
4. kubeasy-offline-v${KUBEASY_VERSION}.tar.gz
    * Using Docker to run kubeasy, kubernetes can be installed completely offline


If use the kubeasy-offline-v${KUBEASY_VERSION}.tar.gz, you need a deployment server. docker restarts and the deployment container is aborted because the installed docker and kubeasy methods are different.

#### used kubeasy-binary or kubeasy-registry file

[![asciicast](https://asciinema.org/a/533648.svg)](https://asciinema.org/a/533648)

```
KUBEASY_VERSION=1.24.8
wget https://github.com/buxiaomo/kubeasy/releases/download/v${KUBEASY_VERSION}/kubeasy-v${KUBEASY_VERSION}.tar.gz -O /usr/local/src/kubeasy-v${KUBEASY_VERSION}.tar.gz
tar -zxf /usr/local/src/kubeasy-v${KUBEASY_VERSION}.tar.gz -C /usr/local/src
wget https://github.com/buxiaomo/kubeasy/releases/download/v${KUBEASY_VERSION}/kubeasy-registry-v${KUBEASY_VERSION}.tar.gz -O /usr/local/src/kubeasy/scripts/src/kubeasy-registry-v${KUBEASY_VERSION}.tar.gz
wget https://github.com/buxiaomo/kubeasy/releases/download/v${KUBEASY_VERSION}/kubeasy-binary-v${KUBEASY_VERSION}.tar.gz -O /usr/local/src/kubeasy/scripts/src/kubeasy-binary-v${KUBEASY_VERSION}.tar.gz

cd /usr/local/src/kubeasy
ls -l ./scripts/src/
make runtime
make hosts
make prepare
make deploy REGISTRY_URL=http://<IP Addr>:5000
```

#### use kubeasy-offline

[![asciicast](https://asciinema.org/a/533677.svg)](https://asciinema.org/a/533677)

```
KUBEASY_VERSION=1.24.8
wget https://github.com/buxiaomo/kubeasy/releases/download/v${KUBEASY_VERSION}/kubeasy-offline-v${KUBEASY_VERSION}.tar.gz -O /usr/local/src/kubeasy-offline-v${KUBEASY_VERSION}.tar.gz
tar -zxf /usr/local/src/kubeasy-offline-v${KUBEASY_VERSION}.tar.gz -C /usr/local/src
cd /usr/local/src/kubeasy-offline-v${KUBEASY_VERSION}
./main.sh
```


## Known Issues 

* error: Following Cgroup subsystem not mounted: [memory], see [here](https://github.com/buxiaomo/kubeasy/issues/2)


## knowledge

* [download kubernetes](https://www.downloadkubernetes.com)
* [kubernetes](https://github.com/kubernetes/kubernetes)
* [kubernetes changelog](https://github.com/kubernetes/kubernetes/tree/master/CHANGELOG)
* [kubernetes command line tools reference](https://kubernetes.io/zh/docs/reference/command-line-tools-reference/feature-gates/)
* [calico](https://docs.projectcalico.org/getting-started/kubernetes/quickstart)
* [canal](https://docs.projectcalico.org/getting-started/kubernetes/flannel/flannel)
* [calico version of k8s](https://projectcalico.docs.tigera.io/getting-started/kubernetes/requirements)
* [flannel](https://github.com/coreos/flannel#flannel)
* [cilium](https://docs.cilium.io/en/stable/gettingstarted/#gs-guide)
* [hubble](https://github.com/cilium/hubble)
* [metrics-server](https://github.com/kubernetes-sigs/metrics-server)
* [coredns on k8s](https://github.com/coredns/deployment/blob/master/kubernetes/CoreDNS-k8s_version.md)
* [certificates](https://kubernetes.io/zh/docs/setup/best-practices/certificates/)
* [k8s_the_hard_way](https://github.com/pythops/k8s_the_hard_way)
* [IPv4/IPv6 dual-stack](https://kubernetes.io/zh/docs/concepts/services-networking/dual-stack/)
* [validate IPv4/IPv6 dual-stack](https://kubernetes.io/zh/docs/tasks/network/validate-dual-stack/)
* [CoreDNS k8s version](https://github.com/coredns/deployment/blob/master/kubernetes/CoreDNS-k8s_version.md)
