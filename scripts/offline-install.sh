#!/bin/bash
SHELL_FOLDER=$(dirname $(readlink -f "$0"))
command -v docker >/dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "\033[32m-> Install docker.\033[0m"
    tar -zxf ${SHELL_FOLDER}/docker-20.10.9.tgz --strip-components=1 -C /usr/local/bin
    cp ${SHELL_FOLDER}/docker.service /etc/systemd/system/docker.service
    systemctl daemon-reload
    systemctl enable docker.service
    systemctl restart docker.service
fi
echo -e "\033[32m-> Install registry.\033[0m"
tar -zvxf ${SHELL_FOLDER}/registry_2.8.1_linux_amd64.tar.gz -C /usr/local/bin registry >/dev/null 2>&1
cp -rf registry /usr/local/src
mkdir -p /usr/local/etc
cat > /usr/local/etc/registry.yml << EOF
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
cat > /etc/systemd/system/registry.service << EOF
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
echo -e "\033[32mYou can run the following command \033[0m"
echo -e "\033[32mdocker run -it --rm --name kubeasy --privileged --pull always -v group_vars:/app/group_vars -v inventory:/app/inventory -v ssl:/etc/ssl/kubernetes 127.0.0.1:5000/buxiaomo/kubeasy:v\${KUBEASY_VERSION}\033[0m"
