#!/bin/bash
if ${DEBUG};then
  set -ex
fi

function printb(){
  echo -e "\033[32m$1\033[0m"
}

pushd $(dirname $0)

mkdir -p binaries

# if [ "${HTTP_USERNAME}" = "" ] || [ ${HTTP_PASSWORD} = "" ];then
#   Download="curl -f --connect-timeout 20 --retry 5 --location --insecure"
# else
#   Download="curl -u '${HTTP_USERNAME}:${HTTP_PASSWORD}' -f --connect-timeout 20 --retry 5 --location --insecure"
# fi


# docker
DOCKER_VERSION=${DOCKER_VERSION:-"19.03.8"}
printb "Prepare docker ${DOCKER_VERSION} release ..."
mkdir -p binaries/docker/${DOCKER_VERSION}
grep -q "^${DOCKER_VERSION}\$" binaries/docker/${DOCKER_VERSION}/.docker 2>/dev/null || {
  curl -f --connect-timeout 20 --retry 5 --location --insecure https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz -o binaries/docker/${DOCKER_VERSION}/docker-${DOCKER_VERSION}.tgz
  tar -zxf binaries/docker/${DOCKER_VERSION}/docker-${DOCKER_VERSION}.tgz --strip-components 1 -C binaries/docker/${DOCKER_VERSION}
  rm -rf binaries/docker/${DOCKER_VERSION}/docker-${DOCKER_VERSION}.tgz
  echo ${DOCKER_VERSION} > binaries/docker/${DOCKER_VERSION}/.docker
}

# # flannel
# FLANNEL_VERSION=${FLANNEL_VERSION:-"0.12.0"}
# printb "Prepare flannel ${FLANNEL_VERSION} release ..."
# mkdir -p binaries/flannel/${FLANNEL_VERSION}
# grep -q "^${FLANNEL_VERSION}\$" binaries/flannel/${FLANNEL_VERSION}/.flannel 2>/dev/null || {
#   curl -f --connect-timeout 20 --retry 5 --location --insecure https://github.com/coreos/flannel/releases/download/v${FLANNEL_VERSION}/flannel-v${FLANNEL_VERSION}-linux-amd64.tar.gz -o binaries/flannel/${FLANNEL_VERSION}/flannel-v${FLANNEL_VERSION}-linux-amd64.tar.gz
#   tar -zxf binaries/flannel/${FLANNEL_VERSION}/flannel-v${FLANNEL_VERSION}-linux-amd64.tar.gz -C binaries/flannel/${FLANNEL_VERSION}/ flanneld mk-docker-opts.sh
#   rm -rf binaries/flannel/${FLANNEL_VERSION}/flannel-v${FLANNEL_VERSION}-linux-amd64.tar.gz
#   echo ${FLANNEL_VERSION} > binaries/flannel/${FLANNEL_VERSION}/.flannel
# }

# ectd
ETCD_VERSION=${ETCD_VERSION:-"3.4.5"}
printb "Prepare etcd ${ETCD_VERSION} release ..."
mkdir -p binaries/etcd/${ETCD_VERSION}
grep -q "^${ETCD_VERSION}\$" binaries/etcd/${ETCD_VERSION}/.etcd 2>/dev/null || {
  curl -f --connect-timeout 20 --retry 5 --location --insecure https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz -o binaries/etcd/${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
  tar -zxf binaries/etcd/${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz --strip-components 1 -C binaries/etcd/${ETCD_VERSION}/ etcd-v${ETCD_VERSION}-linux-amd64/etcd etcd-v${ETCD_VERSION}-linux-amd64/etcdctl 
  rm -rf binaries/etcd/${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
  echo ${ETCD_VERSION} > binaries/etcd/${ETCD_VERSION}/.etcd
}

# kubernetes
KUBE_VERSION=${KUBE_VERSION:-"1.14.4"}
printb "Prepare kubernetes ${KUBE_VERSION} release ..."
mkdir -p binaries/kubernetes/${KUBE_VERSION}
grep -q "^${KUBE_VERSION}\$" binaries/kubernetes/${KUBE_VERSION}/.kubernetes 2>/dev/null || {
  curl -f --connect-timeout 20 --retry 5 --location --insecure "https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kube-apiserver" -o binaries/kubernetes/${KUBE_VERSION}/kube-apiserver
  curl -f --connect-timeout 20 --retry 5 --location --insecure "https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kube-controller-manager" -o binaries/kubernetes/${KUBE_VERSION}/kube-controller-manager
  curl -f --connect-timeout 20 --retry 5 --location --insecure "https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kube-scheduler" -o binaries/kubernetes/${KUBE_VERSION}/kube-scheduler
  curl -f --connect-timeout 20 --retry 5 --location --insecure "https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl" -o binaries/kubernetes/${KUBE_VERSION}/kubectl
  curl -f --connect-timeout 20 --retry 5 --location --insecure "https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kube-proxy" -o binaries/kubernetes/${KUBE_VERSION}/kube-proxy
  curl -f --connect-timeout 20 --retry 5 --location --insecure "https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubelet" -o binaries/kubernetes/${KUBE_VERSION}/kubelet
  echo ${KUBE_VERSION} > binaries/kubernetes/${KUBE_VERSION}/.kubernetes
}

# CNI_VERSION=${CNI_VERSION:-"0.8.5"}
# printb "Prepare cni-plugins ${CNI_VERSION} release ..."
# mkdir -p binaries/cni-plugins/${CNI_VERSION}
# grep -q "^${CNI_VERSION}\$" binaries/cni-plugins/${CNI_VERSION}/.cni 2>/dev/null || {
#   curl -f --connect-timeout 20 --retry 5 --location --insecure "https://github.com/containernetworking/plugins/releases/download/v${CNI_VERSION}/cni-plugins-linux-amd64-v${CNI_VERSION}.tgz" -o binaries/cni-plugins/${CNI_VERSION}/cni-plugins-linux-amd64-v${CNI_VERSION}.tgz
#   tar -zxf binaries/cni-plugins/${CNI_VERSION}/cni-plugins-linux-amd64-v${CNI_VERSION}.tgz --strip-components 1 -C binaries/cni-plugins/${CNI_VERSION}/
#   rm -rf binaries/cni-plugins/${CNI_VERSION}/cni-plugins-linux-amd64-v${CNI_VERSION}.tgz
#   echo ${CNI_VERSION} > binaries/cni-plugins/${CNI_VERSION}/.cni
# }