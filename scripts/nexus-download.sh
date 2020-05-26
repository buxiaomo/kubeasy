#!/bin/bash
if ${DEBUG} ;then
  set -x
fi

function printb(){
  echo -e "\033[32m$1\033[0m"
}

pushd $(dirname $0) > /dev/null 2>&1

mkdir -p binaries

if [ "${NEXUS_HTTP_USERNAME}" = "" ] || [ ${NEXUS_HTTP_PASSWORD} = "" ];then
  export DOWNLOAD_OPTION="-f --connect-timeout 20 --retry 5 --location --insecure"
else
  export DOWNLOAD_OPTION="-u ${NEXUS_HTTP_USERNAME}:${NEXUS_HTTP_PASSWORD} -f --connect-timeout 20 --retry 5 --location --insecure"
fi

# docker
DOCKER_VERSION=${DOCKER_VERSION:-"19.03.8"}
printb "Prepare docker ${DOCKER_VERSION} release ..."
mkdir -p binaries/docker/${DOCKER_VERSION}
grep -q "^${DOCKER_VERSION}\$" binaries/docker/${DOCKER_VERSION}/.docker 2>/dev/null || {
  if [ ! -f src/docker-${DOCKER_VERSION}.tgz ];then
    printb "Download from the Internet..."
    curl ${DOWNLOAD_OPTION} http://${NEXUS_DOMAIN_NAME}/repository/${NEXUS_REPOSITORY}/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz -o binaries/docker/${DOCKER_VERSION}/docker-${DOCKER_VERSION}.tgz
    tar -zxf binaries/docker/${DOCKER_VERSION}/docker-${DOCKER_VERSION}.tgz --strip-components 1 -C binaries/docker/${DOCKER_VERSION}
    rm -rf binaries/docker/${DOCKER_VERSION}/docker-${DOCKER_VERSION}.tgz
  else
    printb "Use local binary packages..."
    tar -zxf src/docker-${DOCKER_VERSION}.tgz --strip-components 1 -C binaries/docker/${DOCKER_VERSION}
  fi
  chmod +x binaries/docker/${DOCKER_VERSION}/*
  binaries/docker/${DOCKER_VERSION}/dockerd --version > /dev/null 2>&1 && echo ${DOCKER_VERSION} > binaries/docker/${DOCKER_VERSION}/.docker
}

# flannel
FLANNEL_VERSION=${FLANNEL_VERSION:-"0.12.0"}
printb "Prepare flannel ${FLANNEL_VERSION} release ..."
mkdir -p binaries/flannel/${FLANNEL_VERSION}
grep -q "^${FLANNEL_VERSION}\$" binaries/flannel/${FLANNEL_VERSION}/.flannel 2>/dev/null || {
  if [ ! -f src/flannel-v${FLANNEL_VERSION}-linux-amd64.tar.gz ];then
    printb "Download from the Internet..."
    curl ${DOWNLOAD_OPTION} http://${NEXUS_DOMAIN_NAME}/repository/${NEXUS_REPOSITORY}/coreos/flannel/releases/download/v${FLANNEL_VERSION}/flannel-v${FLANNEL_VERSION}-linux-amd64.tar.gz -o binaries/flannel/${FLANNEL_VERSION}/flannel-v${FLANNEL_VERSION}-linux-amd64.tar.gz
    tar -zxf binaries/flannel/${FLANNEL_VERSION}/flannel-v${FLANNEL_VERSION}-linux-amd64.tar.gz -C binaries/flannel/${FLANNEL_VERSION}/ flanneld mk-docker-opts.sh
    rm -rf binaries/flannel/${FLANNEL_VERSION}/flannel-v${FLANNEL_VERSION}-linux-amd64.tar.gz
  else
    printb "Use local binary packages..."
    tar -zxf src/flannel-v${FLANNEL_VERSION}-linux-amd64.tar.gz --strip-components 1 -C binaries/flannel/${FLANNEL_VERSION}/ flanneld mk-docker-opts.sh
  fi
  chmod +x binaries/flannel/${FLANNEL_VERSION}/*
  binaries/flannel/${FLANNEL_VERSION}/flanneld -version > /dev/null 2>&1 && echo ${FLANNEL_VERSION} > binaries/flannel/${FLANNEL_VERSION}/.flannel
}

# ectd
ETCD_VERSION=${ETCD_VERSION:-"3.4.5"}
printb "Prepare etcd ${ETCD_VERSION} release ..."
mkdir -p binaries/etcd/${ETCD_VERSION}
grep -q "^${ETCD_VERSION}\$" binaries/etcd/${ETCD_VERSION}/.etcd 2>/dev/null || {
  if [ ! -f src/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz ];then
    printb "Download from the Internet..."
    curl ${DOWNLOAD_OPTION} http://${NEXUS_DOMAIN_NAME}/repository/${NEXUS_REPOSITORY}/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz -o binaries/etcd/${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
    tar -zxf binaries/etcd/${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz --strip-components 1 -C binaries/etcd/${ETCD_VERSION}/ etcd-v${ETCD_VERSION}-linux-amd64/etcd etcd-v${ETCD_VERSION}-linux-amd64/etcdctl 
    rm -rf binaries/etcd/${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz
  else
    printb "Use local binary packages..."
    tar -zxf src/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz --strip-components 1 -C binaries/etcd/${ETCD_VERSION}/ etcd-v${ETCD_VERSION}-linux-amd64/etcd etcd-v${ETCD_VERSION}-linux-amd64/etcdctl 
  fi
  chmod +x binaries/etcd/${ETCD_VERSION}/*
  binaries/etcd/${ETCD_VERSION}/etcd -version > /dev/null 2>&1 && echo ${ETCD_VERSION} > binaries/etcd/${ETCD_VERSION}/.etcd
}

# kubernetes
KUBE_VERSION=${KUBE_VERSION:-"1.14.4"}
printb "Prepare kubernetes ${KUBE_VERSION} release ..."
mkdir -p binaries/kubernetes/${KUBE_VERSION}
grep -q "^${KUBE_VERSION}\$" binaries/kubernetes/${KUBE_VERSION}/.kubernetes 2>/dev/null || {
  if [ ! -f src/kubernetes-client-linux-amd64.v${KUBE_VERSION}.tar.gz ] || [ ! -f src/kubernetes-server-linux-amd64.v${KUBE_VERSION}.tar.gz ];then
    printb "Download from the Internet..."
    curl ${DOWNLOAD_OPTION} "http://${NEXUS_DOMAIN_NAME}/repository/${NEXUS_REPOSITORY}/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kube-apiserver" -o binaries/kubernetes/${KUBE_VERSION}/kube-apiserver
    curl ${DOWNLOAD_OPTION} "http://${NEXUS_DOMAIN_NAME}/repository/${NEXUS_REPOSITORY}/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kube-controller-manager" -o binaries/kubernetes/${KUBE_VERSION}/kube-controller-manager
    curl ${DOWNLOAD_OPTION} "http://${NEXUS_DOMAIN_NAME}/repository/${NEXUS_REPOSITORY}/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kube-scheduler" -o binaries/kubernetes/${KUBE_VERSION}/kube-scheduler
    curl ${DOWNLOAD_OPTION} "http://${NEXUS_DOMAIN_NAME}/repository/${NEXUS_REPOSITORY}/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl" -o binaries/kubernetes/${KUBE_VERSION}/kubectl
    curl ${DOWNLOAD_OPTION} "http://${NEXUS_DOMAIN_NAME}/repository/${NEXUS_REPOSITORY}/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kube-proxy" -o binaries/kubernetes/${KUBE_VERSION}/kube-proxy
    curl ${DOWNLOAD_OPTION} "http://${NEXUS_DOMAIN_NAME}/repository/${NEXUS_REPOSITORY}/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubelet" -o binaries/kubernetes/${KUBE_VERSION}/kubelet
    chmod +x binaries/kubernetes/${KUBE_VERSION}/*
  else
    printb "Use local binary packages..."
    tar -zxf src/kubernetes-client-linux-amd64.v${KUBE_VERSION}.tar.gz --strip-components 3 -C binaries/kubernetes/${KUBE_VERSION}/
    tar -zxf src/kubernetes-server-linux-amd64.v${KUBE_VERSION}.tar.gz --strip-components 3 -C binaries/kubernetes/${KUBE_VERSION}/
  fi
  chmod +x binaries/kubernetes/${KUBE_VERSION}/*
  binaries/kubernetes/${KUBE_VERSION}/kube-apiserver --version > /dev/null 2>&1 && \
  binaries/kubernetes/${KUBE_VERSION}/kube-controller-manager --version > /dev/null 2>&1 && \
  binaries/kubernetes/${KUBE_VERSION}/kube-scheduler --version > /dev/null 2>&1 && \
  binaries/kubernetes/${KUBE_VERSION}/kubectl version --client=true > /dev/null 2>&1 && \
  binaries/kubernetes/${KUBE_VERSION}/kube-proxy --version > /dev/null 2>&1 && \
  binaries/kubernetes/${KUBE_VERSION}/kubelet --version > /dev/null 2>&1 && \
  echo ${KUBE_VERSION} > binaries/kubernetes/${KUBE_VERSION}/.kubernetes
}

# CNI
CNI_VERSION=${CNI_VERSION:-"0.8.5"}
printb "Prepare cni-plugins ${CNI_VERSION} release ..."
mkdir -p binaries/cni-plugins/${CNI_VERSION}
grep -q "^${CNI_VERSION}\$" binaries/cni-plugins/${CNI_VERSION}/.cni 2>/dev/null || {
  if [ ! -f src/cni-plugins-linux-amd64-v${CNI_VERSION}.tgz ];then
    printb "Download from the Internet..."
    curl ${DOWNLOAD_OPTION} "http://${NEXUS_DOMAIN_NAME}/repository/${NEXUS_REPOSITORY}/containernetworking/plugins/releases/download/v${CNI_VERSION}/cni-plugins-linux-amd64-v${CNI_VERSION}.tgz" -o binaries/cni-plugins/${CNI_VERSION}/cni-plugins-linux-amd64-v${CNI_VERSION}.tgz
    tar -zxf binaries/cni-plugins/${CNI_VERSION}/cni-plugins-linux-amd64-v${CNI_VERSION}.tgz --strip-components 1 -C binaries/cni-plugins/${CNI_VERSION}/
    rm -rf binaries/cni-plugins/${CNI_VERSION}/cni-plugins-linux-amd64-v${CNI_VERSION}.tgz
  else
    printb "Use local binary packages..."
    tar -zxf src/cni-plugins-linux-amd64-v${CNI_VERSION}.tgz --strip-components 1 -C binaries/cni-plugins/${CNI_VERSION}/
  fi
  echo ${CNI_VERSION} > binaries/cni-plugins/${CNI_VERSION}/.cni
}