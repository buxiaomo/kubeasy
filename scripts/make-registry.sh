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
docker pull docker.io/calico/cni:v3.28.2
docker tag docker.io/calico/cni:v3.28.2 ${REGISTRY_URL}/calico/cni:v3.28.2
docker push ${REGISTRY_URL}/calico/cni:v3.28.2

docker pull docker.io/calico/node:v3.28.2
docker tag docker.io/calico/node:v3.28.2 ${REGISTRY_URL}/calico/node:v3.28.2
docker push ${REGISTRY_URL}/calico/node:v3.28.2

docker pull docker.io/calico/kube-controllers:v3.28.2
docker tag docker.io/calico/kube-controllers:v3.28.2 ${REGISTRY_URL}/calico/kube-controllers:v3.28.2
docker push ${REGISTRY_URL}/calico/kube-controllers:v3.28.2


# canal
docker pull docker.io/flannel/flannel:v0.24.3
docker tag docker.io/flannel/flannel:v0.24.3 ${REGISTRY_URL}/flannel/flannel:v0.24.3
docker push ${REGISTRY_URL}/flannel/flannel:v0.24.3


# coredns

docker pull registry.k8s.io/coredns/coredns:v1.10.1
docker tag registry.k8s.io/coredns/coredns:v1.10.1 ${REGISTRY_URL}/coredns/coredns:v1.10.1
docker push ${REGISTRY_URL}/coredns/coredns:v1.10.1


# flannel
docker pull ghcr.io/flannel-io/flannel-cni-plugin:v1.6.2-flannel1
docker tag ghcr.io/flannel-io/flannel-cni-plugin:v1.6.2-flannel1 ${REGISTRY_URL}/flannel-io/flannel-cni-plugin:v1.6.2-flannel1
docker push ${REGISTRY_URL}/flannel-io/flannel-cni-plugin:v1.6.2-flannel1

docker pull ghcr.io/flannel-io/flannel:v0.26.7
docker tag ghcr.io/flannel-io/flannel:v0.26.7 ${REGISTRY_URL}/flannel-io/flannel:v0.26.7
docker push ${REGISTRY_URL}/flannel-io/flannel:v0.26.7


# metrics-server
docker pull registry.k8s.io/metrics-server/metrics-server:v0.7.2
docker tag registry.k8s.io/metrics-server/metrics-server:v0.7.2 ${REGISTRY_URL}/metrics-server/metrics-server:v0.7.2
docker push ${REGISTRY_URL}/metrics-server/metrics-server:v0.7.2


# pause
docker pull registry.aliyuncs.com/google_containers/pause:3.9
docker tag registry.aliyuncs.com/google_containers/pause:3.9 ${REGISTRY_URL}/google_containers/pause:3.9
docker push ${REGISTRY_URL}/google_containers/pause:3.9


# cilium
docker pull quay.io/cilium/cilium:v1.16.6
docker tag quay.io/cilium/cilium:v1.16.6 ${REGISTRY_URL}/cilium/cilium:v1.16.6
docker push ${REGISTRY_URL}/cilium/cilium:v1.16.6

docker pull quay.io/cilium/operator-generic:v1.16.6
docker tag quay.io/cilium/operator-generic:v1.16.6 ${REGISTRY_URL}/cilium/operator-generic:v1.16.6
docker push ${REGISTRY_URL}/cilium/operator-generic:v1.16.6

docker pull quay.io/cilium/hubble-ui-backend:v0.13.1
docker tag quay.io/cilium/hubble-ui-backend:v0.13.1 ${REGISTRY_URL}/cilium/hubble-ui-backend:v0.13.1
docker push ${REGISTRY_URL}/cilium/hubble-ui-backend:v0.13.1

docker pull quay.io/cilium/hubble-ui:v0.13.1
docker tag quay.io/cilium/hubble-ui:v0.13.1 ${REGISTRY_URL}/cilium/hubble-ui:v0.13.1
docker push ${REGISTRY_URL}/cilium/hubble-ui:v0.13.1

docker pull quay.io/cilium/hubble-relay:v1.16.6
docker tag quay.io/cilium/hubble-relay:v1.16.6 ${REGISTRY_URL}/cilium/hubble-relay:v1.16.6
docker push ${REGISTRY_URL}/cilium/hubble-relay:v1.16.6

docker pull quay.io/cilium/cilium-envoy:v1.30.9-1737073743-40a016d11c0d863b772961ed0168eea6fe6b10a5
docker tag quay.io/cilium/cilium-envoy:v1.30.9-1737073743-40a016d11c0d863b772961ed0168eea6fe6b10a5 ${REGISTRY_URL}/cilium/cilium-envoy:v1.30.9-1737073743-40a016d11c0d863b772961ed0168eea6fe6b10a5
docker push ${REGISTRY_URL}/cilium/cilium-envoy:v1.30.9-1737073743-40a016d11c0d863b772961ed0168eea6fe6b10a5


# nvidia-device-plugin
docker pull nvcr.io/nvidia/k8s-device-plugin:v0.17.0
docker tag nvcr.io/nvidia/k8s-device-plugin:v0.17.0 ${REGISTRY_URL}/nvidia/k8s-device-plugin:v0.17.0
docker push ${REGISTRY_URL}/nvidia/k8s-device-plugin:v0.17.0


# antrea
docker pull antrea/antrea-agent-ubuntu:v2.3.0
docker tag antrea/antrea-agent-ubuntu:v2.3.0 ${REGISTRY_URL}/antrea/antrea-agent-ubuntu:v2.3.0
docker push ${REGISTRY_URL}/antrea/antrea-agent-ubuntu:v2.3.0

docker pull antrea/antrea-controller-ubuntu:v2.3.0
docker tag antrea/antrea-controller-ubuntu:v2.3.0 ${REGISTRY_URL}/antrea/antrea-controller-ubuntu:v2.3.0
docker push ${REGISTRY_URL}/antrea/antrea-controller-ubuntu:v2.3.0
