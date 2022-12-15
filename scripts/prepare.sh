#!/bin/bash
KUBE_VERSION=$1
if ! command -v curl >/dev/null 2>&1; then
  echo -e "\033[31mNeed curl command!\033[0m"
  exit 1
fi
if ! command -v wget >/dev/null 2>&1; then
  echo -e "\033[31mNeed wget command!\033[0m"
  exit 1
fi

if [ ! -f ./scripts/src/kubeasy-registry-v${KUBE_VERSION}.tar.gz ] && [ ! -f ./scripts/src/kubeasy-binary-v${KUBE_VERSION}.tar.gz ]; then
  curl --connect-timeout 3 https://github.com >/dev/null 2>&1
  if [ $? != 0 ]; then
    echo -e "\033[31mFailed to access github, please download manually.\033[0m"
    exit 1
  else
    if [ ! -f ./scripts/src/kubeasy-registry-v${KUBE_VERSION}.tar.gz ]; then
      echo -e "\033[32m-> Download kubeasy-registry-v${KUBE_VERSION}.tar.gz save to './scripts/src/'.\033[0m"
      wget -c --prefer-family=IPv4 --no-check-certificate -T 120 -t3 https://github.com/buxiaomo/kubeasy/releases/download/v${KUBE_VERSION}/kubeasy-registry-v${KUBE_VERSION}.tar.gz -O ./scripts/src/kubeasy-registry-v${KUBE_VERSION}.tar.gz
    fi

    if [ ! -f ./scripts/src/kubeasy-binary-v${KUBE_VERSION}.tar.gz ]; then
      echo -e "\033[32m-> Download kubeasy-binary-v${KUBE_VERSION}.tar.gz save to './scripts/src/'.\033[0m"
      wget -c --prefer-family=IPv4 --no-check-certificate -T 120 -t3 https://github.com/buxiaomo/kubeasy/releases/download/v${KUBE_VERSION}/kubeasy-binary-v${KUBE_VERSION}.tar.gz -O ./scripts/src/kubeasy-binary-v${KUBE_VERSION}.tar.gz
    fi
  fi
fi

if [ -f ./scripts/src/kubeasy-binary-v${KUBE_VERSION}.tar.gz ]; then
  tar -zxf ./scripts/src/kubeasy-binary-v${KUBE_VERSION}.tar.gz -C ./scripts/src
  mkdir -p ./roles/kube-apiserver/files/${KUBE_VERSION} ./roles/kube-controller-manager/files/${KUBE_VERSION} ./roles/kube-scheduler/files/${KUBE_VERSION} ./roles/kubectl/files/${KUBE_VERSION} ./roles/kube-proxy/files/${KUBE_VERSION} ./roles/kubelet/files/${KUBE_VERSION}
  find ./scripts/src/${KUBE_VERSION} -name containerd-*-linux-amd64.tar.gz -exec cp "{}" ./roles/containerd/files \;
  find ./scripts/src/${KUBE_VERSION} -name runc.amd64 -exec cp "{}" ./roles/containerd/files \;
  find ./scripts/src/${KUBE_VERSION} -name crictl-*-linux-amd64.tar.gz -exec cp "{}" ./roles/containerd/files \;
  find ./scripts/src/${KUBE_VERSION} -name docker-*.tgz -exec cp "{}" ./roles/docker/files \;
  find ./scripts/src/${KUBE_VERSION} -name cni-plugins-*.tgz -exec cp "{}" ./roles/cni/files \;
  find ./scripts/src/${KUBE_VERSION} -name etcd-*-linux-amd64.tar.gz -exec cp "{}" ./roles/etcd/files \;
  find ./scripts/src/${KUBE_VERSION} -name kube-apiserver -exec cp "{}" ./roles/kube-apiserver/files/${KUBE_VERSION} \;
  find ./scripts/src/${KUBE_VERSION} -name kube-controller-manager -exec cp "{}" ./roles/kube-controller-manager/files/${KUBE_VERSION} \;
  find ./scripts/src/${KUBE_VERSION} -name kube-scheduler -exec cp "{}" ./roles/kube-scheduler/files/${KUBE_VERSION} \;
  find ./scripts/src/${KUBE_VERSION} -name kubectl -exec cp "{}" ./roles/kubectl/files/${KUBE_VERSION} \;
  find ./scripts/src/${KUBE_VERSION} -name kube-proxy -exec cp "{}" ./roles/kube-proxy/files/${KUBE_VERSION} \;
  find ./scripts/src/${KUBE_VERSION} -name kubelet -exec cp "{}" ./roles/kubelet/files/${KUBE_VERSION} \;
fi

if [ -f ./scripts/src/kubeasy-registry-v${KUBE_VERSION}.tar.gz ]; then
  tar -zxf ./scripts/src/kubeasy-registry-v${KUBE_VERSION}.tar.gz -C /usr/local/src
  tar -zxf /usr/local/src/registry_2.8.1_linux_amd64.tar.gz -C /usr/local/bin registry
  cat >/usr/local/etc/registry.yml <<EOF
version: 0.1
log:
  fields:
    service: registry
storage:
  cache:
    blobdescriptor: inmemory
  filesystem:
    rootdirectory: /usr/local/src/registry
http:
  addr: :5000
  headers:
    X-Content-Type-Options: [nosniff]
health:
  storagedriver:
    enabled: true
    interval: 10s
    threshold: 3
EOF
  cat >/etc/systemd/system/registry.service <<EOF
[Unit]
Description=Docker Registry Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service
Wants=network-online.target

[Service]
ExecStart=/usr/local/bin/registry serve /usr/local/etc/registry.yml
ExecReload=/bin/kill -s HUP \$MAINPID
TimeoutSec=0
RestartSec=2
Restart=always
StartLimitBurst=3
StartLimitInterval=60s
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
TasksMax=infinity
Delegate=yes
KillMode=process

[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
  systemctl restart registry.service
  systemctl enable registry.service
  echo -e "\033[32mYou have deployed a private repository. Specify the private repository using the REGISTRY_URL parameter, for example: \n  make deploy REGISTRY_URL=http://<private repository ip>:5000 \033[0m"
fi
