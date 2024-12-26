# kubeasy

This project will used ansible to deploy a production ready kubernetes cluster.

Read the [documentation](https://github.com/buxiaomo/kubeasy/wiki) to see how the project is used

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

## Supported Linux Distributions

all node please install python.

* [x] UnionTech OS
* [x] Arch Linux
* [x] CentOS (7.\*, 8.\*)
* [x] Ubuntu (16.\*, 18.\*, 20.\*, 21.\*, 22.\*) 
* [x] Debian (10.\*, 11.\*)
* [x] OpenSUSE 15
* [x] Alma Linux 9
* [x] Amazon Linux 2
* [x] Rocky Linux (8, 9)
* [x] Red Hat Enterprise Linux (7, 8)
* [x] SUSE Linux Enterprise Server 15

## Supported Components
* Core
    * kubernetes
    * etcd
    * docker
    * containerd
    * cri-o
* Network Plugin
    * cni-plugins
    * antrea
    * calico
    * canal
    * cilium
    * flannel

* Application
    * coredns
    * metrics
    * nvidia-device-plugin
