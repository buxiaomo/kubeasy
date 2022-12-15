#!/bin/bash
set -x
function check_new_version() {
  COMMIT_MSG=""
  # K8S
  export tag_name=$(curl -s -k -f --connect-timeout 20 --retry 5 --location --insecure https://api.github.com/repos/kubernetes/kubernetes/releases/latest | jq -r .tag_name)
  grep -E "KUBE_VERSION:=${tag_name:1}" ./Makefile
  if [ $? -ne 0 ]; then
    sed -i "s/KUBE_VERSION:=.*/KUBE_VERSION:=${tag_name:1}/g" ./Makefile
    COMMIT_MSG="${COMMIT_MSG} update kubernetes version to ${tag_name};"
  fi

  # Etcd
  export tag_name=$(curl -s -k -f --connect-timeout 20 --retry 5 --location --insecure https://api.github.com/repos/etcd-io/etcd/releases/latest | jq -r .tag_name)
  grep -E "ETCD_VERSION:=${tag_name:1}" ./Makefile
  if [ $? -ne 0 ]; then
    sed -i "s/ETCD_VERSION:=.*/ETCD_VERSION:=${tag_name:1}/g" ./Makefile
    COMMIT_MSG="${COMMIT_MSG} update etcd version to ${tag_name};"
  fi

  # CNI
  export tag_name=$(curl -s -k -f --connect-timeout 20 --retry 5 --location --insecure https://api.github.com/repos/containernetworking/plugins/releases/latest | jq -r .tag_name)
  grep -E "CNI_VERSION:=${tag_name:1}" ./Makefile
  if [ $? -ne 0 ]; then
    sed -i "s/CNI_VERSION:=.*/CNI_VERSION:=${tag_name:1}/g" ./Makefile
    COMMIT_MSG="${COMMIT_MSG} update cni version to ${tag_name};"
  fi

  # Docker
  export tag_name=$(curl -s -k -f --connect-timeout 20 --retry 5 --location --insecure https://api.github.com/repos/moby/moby/releases/latest | jq -r .tag_name)
  grep -E "DOCKER_VERSION:=${tag_name:1}" ./Makefile
  if [ $? -ne 0 ]; then
    sed -i "s/DOCKER_VERSION:=.*/DOCKER_VERSION:=${tag_name:1}/g" ./Makefile
    COMMIT_MSG="${COMMIT_MSG} update docker version to ${tag_name};"
  fi

  # containerd
  export tag_name=$(curl -s -k -f --connect-timeout 20 --retry 5 --location --insecure https://api.github.com/repos/containerd/containerd/releases/latest | jq -r .tag_name)
  grep -E "CONTAINERD_VERSION:=${tag_name:1}" ./Makefile
  if [ $? -ne 0 ]; then
    sed -i "s/CONTAINERD_VERSION:=.*/CONTAINERD_VERSION:=${tag_name:1}/g" ./Makefile
    COMMIT_MSG="${COMMIT_MSG} update containerd version to ${tag_name};"
  fi

  # crictl
  export tag_name=$(curl -s -k -f --connect-timeout 20 --retry 5 --location --insecure https://api.github.com/repos/kubernetes-sigs/cri-tools/releases/latest | jq -r .tag_name)
  grep -E "CRICTL_VERSION:=${tag_name:1}" ./Makefile
  if [ $? -ne 0 ]; then
    sed -i "s/CRICTL_VERSION:=.*/CRICTL_VERSION:=${tag_name:1}/g" ./Makefile
    COMMIT_MSG="${COMMIT_MSG} update crictl version to ${tag_name};"
  fi

  # runc
  export tag_name=$(curl -s -k -f --connect-timeout 20 --retry 5 --location --insecure https://api.github.com/repos/opencontainers/runc/releases/latest | jq -r .tag_name)
  grep -E "RUNC_VERSION:=${tag_name:1}" ./Makefile
  if [ $? -ne 0 ]; then
    sed -i "s/RUNC_VERSION:=.*/RUNC_VERSION:=${tag_name:1}/g" ./Makefile
    COMMIT_MSG="${COMMIT_MSG} update runc version to ${tag_name};"
  fi

  echo ${COMMIT_MSG}

  if [ -n "${COMMIT_MSG}" ]; then
    git config --local user.email "action@github.com"
    git config --local user.name "GitHub Action"
    git add ./Makefile
    git commit -am "${COMMIT_MSG}"
    git push
  fi
}

$@
