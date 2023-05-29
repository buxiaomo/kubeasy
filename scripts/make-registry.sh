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
docker pull docker.io/calico/cni:v3.26.0
docker tag docker.io/calico/cni:v3.26.0 ${REGISTRY_URL}/calico/cni:v3.26.0
docker push ${REGISTRY_URL}/calico/cni:v3.26.0

docker pull docker.io/calico/node:v3.26.0
docker tag docker.io/calico/node:v3.26.0 ${REGISTRY_URL}/calico/node:v3.26.0
docker push ${REGISTRY_URL}/calico/node:v3.26.0

docker pull docker.io/calico/kube-controllers:v3.26.0
docker tag docker.io/calico/kube-controllers:v3.26.0 ${REGISTRY_URL}/calico/kube-controllers:v3.26.0
docker push ${REGISTRY_URL}/calico/kube-controllers:v3.26.0


# canal
docker pull docker.io/flannel/flannel:v0.21.3
docker tag docker.io/flannel/flannel:v0.21.3 ${REGISTRY_URL}/flannel/flannel:v0.21.3
docker push ${REGISTRY_URL}/flannel/flannel:v0.21.3


# coredns
docker pull coredns/coredns:1.10.1
docker tag coredns/coredns:1.10.1 ${REGISTRY_URL}/coredns/coredns:1.10.1
docker push ${REGISTRY_URL}/coredns/coredns:1.10.1


# flannel
docker pull docker.io/flannel/flannel-cni-plugin:v1.1.2
docker tag docker.io/flannel/flannel-cni-plugin:v1.1.2 ${REGISTRY_URL}/flannel/flannel-cni-plugin:v1.1.2
docker push ${REGISTRY_URL}/flannel/flannel-cni-plugin:v1.1.2

docker pull docker.io/flannel/flannel:v0.21.5
docker tag docker.io/flannel/flannel:v0.21.5 ${REGISTRY_URL}/flannel/flannel:v0.21.5
docker push ${REGISTRY_URL}/flannel/flannel:v0.21.5


# metrics-server
docker pull k8s.gcr.io/metrics-server/metrics-server:v0.6.3
docker tag k8s.gcr.io/metrics-server/metrics-server:v0.6.3 ${REGISTRY_URL}/metrics-server/metrics-server:v0.6.3
docker push ${REGISTRY_URL}/metrics-server/metrics-server:v0.6.3


# pause
docker pull registry.aliyuncs.com/google_containers/pause:3.9
docker tag registry.aliyuncs.com/google_containers/pause:3.9 ${REGISTRY_URL}/google_containers/pause:3.9
docker push ${REGISTRY_URL}/google_containers/pause:3.9


# cilium
docker pull quay.io/cilium/cilium:v1.13.2
docker tag quay.io/cilium/cilium:v1.13.2 ${REGISTRY_URL}/cilium/cilium:v1.13.2
docker push ${REGISTRY_URL}/cilium/cilium:v1.13.2

docker pull quay.io/cilium/operator-generic:v1.13.2
docker tag quay.io/cilium/operator-generic:v1.13.2 ${REGISTRY_URL}/cilium/operator-generic:v1.13.2
docker push ${REGISTRY_URL}/cilium/operator-generic:v1.13.2

docker pull quay.io/cilium/hubble-ui-backend:v0.11.0
docker tag quay.io/cilium/hubble-ui-backend:v0.11.0 ${REGISTRY_URL}/cilium/hubble-ui-backend:v0.11.0
docker push ${REGISTRY_URL}/cilium/hubble-ui-backend:v0.11.0

docker pull quay.io/cilium/hubble-ui:v0.11.0
docker tag quay.io/cilium/hubble-ui:v0.11.0 ${REGISTRY_URL}/cilium/hubble-ui:v0.11.0
docker push ${REGISTRY_URL}/cilium/hubble-ui:v0.11.0

docker pull quay.io/cilium/hubble-relay:v1.13.2
docker tag quay.io/cilium/hubble-relay:v1.13.2 ${REGISTRY_URL}/cilium/hubble-relay:v1.13.2
docker push ${REGISTRY_URL}/cilium/hubble-relay:v1.13.2


# nvidia-device-plugin
docker pull nvcr.io/nvidia/k8s-device-plugin:v0.13.0
docker tag nvcr.io/nvidia/k8s-device-plugin:v0.13.0 ${REGISTRY_URL}/nvidia/k8s-device-plugin:v0.13.0
docker push ${REGISTRY_URL}/nvidia/k8s-device-plugin:v0.13.0
