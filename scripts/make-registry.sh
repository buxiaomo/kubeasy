#!/bin/bash
SHELL_FOLDER=$(dirname $(readlink -f "$0"))
REGISTRY_URL="127.0.0.1:5000"

command -v docker >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "\033[32m-> Install docker.\033[0m"
    curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
    systemctl restart docker.service
fi

set -e
echo -e "\033[32m-> Install registry.\033[0m"
docker rm -f registry >/dev/null 2>&1 || true
docker run -d --name registry \
-p 5000:5000 --restart always \
-v ${SHELL_FOLDER}/src/registry:/var/lib/registry \
registry:2.8.1

# calico
docker pull calico/cni:v3.25.0
docker tag calico/cni:v3.25.0 ${REGISTRY_URL}/calico/cni:v3.25.0
docker push ${REGISTRY_URL}/calico/cni:v3.25.0

docker pull calico/pod2daemon-flexvol:v3.25.0
docker tag calico/pod2daemon-flexvol:v3.25.0 ${REGISTRY_URL}/calico/pod2daemon-flexvol:v3.25.0
docker push ${REGISTRY_URL}/calico/pod2daemon-flexvol:v3.25.0

docker pull calico/node:v3.25.0
docker tag calico/node:v3.25.0 ${REGISTRY_URL}/calico/node:v3.25.0
docker push ${REGISTRY_URL}/calico/node:v3.25.0

docker pull calico/kube-controllers:v3.25.0
docker tag calico/kube-controllers:v3.25.0 ${REGISTRY_URL}/calico/kube-controllers:v3.25.0
docker push ${REGISTRY_URL}/calico/kube-controllers:v3.25.0


# canal
docker pull docker.io/flannelcni/flannel:v0.16.3
docker tag docker.io/flannelcni/flannel:v0.16.3 ${REGISTRY_URL}/flannelcni/flannel:v0.16.3
docker push ${REGISTRY_URL}/flannelcni/flannel:v0.16.3


# coredns
docker pull coredns/coredns:1.9.3
docker tag coredns/coredns:1.9.3 ${REGISTRY_URL}/coredns/coredns:1.9.3
docker push ${REGISTRY_URL}/coredns/coredns:1.9.3


# flannel
docker pull rancher/mirrored-flannelcni-flannel-cni-plugin:v1.1.0
docker tag rancher/mirrored-flannelcni-flannel-cni-plugin:v1.1.0 ${REGISTRY_URL}/rancher/mirrored-flannelcni-flannel-cni-plugin:v1.1.0
docker push ${REGISTRY_URL}/rancher/mirrored-flannelcni-flannel-cni-plugin:v1.1.0

docker pull rancher/mirrored-flannelcni-flannel:v0.20.2
docker tag rancher/mirrored-flannelcni-flannel:v0.20.2 ${REGISTRY_URL}/rancher/mirrored-flannelcni-flannel:v0.20.2
docker push ${REGISTRY_URL}/rancher/mirrored-flannelcni-flannel:v0.20.2


# metrics-server
docker pull k8s.gcr.io/metrics-server/metrics-server:v0.6.2
docker tag k8s.gcr.io/metrics-server/metrics-server:v0.6.2 ${REGISTRY_URL}/metrics-server/metrics-server:v0.6.2
docker push ${REGISTRY_URL}/metrics-server/metrics-server:v0.6.2


# pause
docker pull registry.aliyuncs.com/google_containers/pause:3.9
docker tag registry.aliyuncs.com/google_containers/pause:3.9 ${REGISTRY_URL}/google_containers/pause:3.9
docker push ${REGISTRY_URL}/google_containers/pause:3.9


# cilium
docker pull quay.io/cilium/cilium:v1.12.5
docker tag quay.io/cilium/cilium:v1.12.5 ${REGISTRY_URL}/cilium/cilium:v1.12.5
docker push ${REGISTRY_URL}/cilium/cilium:v1.12.5

docker pull quay.io/cilium/operator-generic:v1.12.5
docker tag quay.io/cilium/operator-generic:v1.12.5 ${REGISTRY_URL}/cilium/operator-generic:v1.12.5
docker push ${REGISTRY_URL}/cilium/operator-generic:v1.12.5

docker pull quay.io/cilium/hubble-ui-backend:v0.9.2
docker tag quay.io/cilium/hubble-ui-backend:v0.9.2 ${REGISTRY_URL}/cilium/hubble-ui-backend:v0.9.2
docker push ${REGISTRY_URL}/cilium/hubble-ui-backend:v0.9.2

docker pull quay.io/cilium/hubble-ui:v0.9.2
docker tag quay.io/cilium/hubble-ui:v0.9.2 ${REGISTRY_URL}/cilium/hubble-ui:v0.9.2
docker push ${REGISTRY_URL}/cilium/hubble-ui:v0.9.2

docker pull quay.io/cilium/hubble-relay:v1.12.5
docker tag quay.io/cilium/hubble-relay:v1.12.5 ${REGISTRY_URL}/cilium/hubble-relay:v1.12.5
docker push ${REGISTRY_URL}/cilium/hubble-relay:v1.12.5


# nvidia-device-plugin
docker pull nvcr.io/nvidia/k8s-device-plugin:v0.12.3
docker tag nvcr.io/nvidia/k8s-device-plugin:v0.12.3 ${REGISTRY_URL}/nvidia/k8s-device-plugin:v0.12.3
docker push ${REGISTRY_URL}/nvidia/k8s-device-plugin:v0.12.3
