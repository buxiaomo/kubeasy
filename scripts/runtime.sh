#!/bin/bash
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/bin"

if command -v yum >/dev/null 2>&1; then
    if grep -Eqi "CentOS" /etc/issue || grep -Eq "CentOS" /etc/*-release || grep -Eqi "rockylinux" /etc/issue || grep -Eq "Rocky Linux" /etc/*-release; then
        yum install -y epel-release
    fi
    yum install git python3 python3-pip sshpass jq curl rsync wget vim tar -y
elif command -v apt-get >/dev/null 2>&1; then
    apt-get update
    apt-get install --no-install-recommends git python3 python3-pip jq python3-testresources sshpass curl vim rsync wget tar -y
    apt-get clean all
    rm -rf /var/lib/apt/lists/*
elif command -v zypper >/dev/null 2>&1; then
    zypper refresh
    zypper --non-interactive install git python3 sshpass wget curl vim jq tar
elif command -v apk >/dev/null 2>&1; then
    apk add --no-cache sshpass wget curl git vim tar
elif command -v pacman >/dev/null 2>&1; then
    pacman -Syu --noconfirm python3 python-pip sshpass wget curl git vim tar --ignore linux
else
    echo -e "\033[31merror: unknow OS version.\033[0m"
    exit 1
fi
echo -e "\033[32mDeploy ansible...\033[0m"
mkdir -p /usr/local/src/pip
pip3 install --no-cache-dir --upgrade pip ${PIP_ARGS}
TMPDIR=/usr/local/src/pip pip3 install --no-cache-dir --upgrade --ignore-installed -r requirements.txt ${PIP_ARGS}
rm -rf /usr/local/src/pip