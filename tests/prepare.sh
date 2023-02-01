#!/bin/bash
set -x
export KUBE_VERSION=$1
export KUBE_NETWORK=$2

command -v cloud-init >/dev/null 2>&1 && sudo cloud-init status --wait

sudo mkdir -p /home/vagrant/.ssh
sudo cp /vagrant/.ssh/id_rsa /home/vagrant/.ssh/id_rsa
sudo cp /vagrant/.ssh/id_rsa.pub /home/vagrant/.ssh/id_rsa.pub
sudo cp /vagrant/.ssh/id_rsa.pub /home/vagrant/.ssh/authorized_keys
sudo chown -R vagrant:vagrant /home/vagrant/.ssh
sudo chmod 600 /home/vagrant/.ssh/id_rsa /home/vagrant/.ssh/id_rsa.pub

sudo mkdir -p /root/.ssh
sudo cp /vagrant/.ssh/id_rsa /root/.ssh/id_rsa
sudo cp /vagrant/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub
sudo cp /vagrant/.ssh/id_rsa.pub /root/.ssh/authorized_keys
sudo chown -R root:root /root/.ssh
sudo chmod 600 /root/.ssh/id_rsa /root/.ssh/id_rsa.pub

source /etc/os-release
case ${ID} in
centos)
  case ${VERSION_ID} in
  7)
    sudo rm -rf /etc/yum.repos.d/*
    sudo curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-7.repo
    ;;
  8)
    sudo rm -rf /etc/yum.repos.d/*
    sudo curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.aliyun.com/repo/Centos-vault-8.5.2111.repo
    ;;
  esac
  ;;
ubuntu)
  sudo sed -i "s@http://.*archive.ubuntu.com@http://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
  sudo sed -i "s@http://.*security.ubuntu.com@http://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
  ;;
debian)
  sudo sed -i "s@https://.*deb.debian.org@http://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
  sudo sed -i "s@https://.*security.debian.org@http://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
  ;;
almalinux)
  sudo sed -e 's|^mirrorlist=|#mirrorlist=|g' -e 's|^# baseurl=https://repo.almalinux.org|baseurl=http://mirrors.aliyun.com|g' -i.bak /etc/yum.repos.d/almalinux*.repo
  ;;
rocky)
  sudo sed -e 's|^mirrorlist=|#mirrorlist=|g' -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=http://mirrors.ustc.edu.cn/rocky|g' -i.bak /etc/yum.repos.d/rocky-extras.repo /etc/yum.repos.d/rocky.repo
  ;;
opensuse-leap)
  sudo zypper mr -da
  sudo zypper ar -cfg 'http://mirrors.tuna.tsinghua.edu.cn/opensuse/distribution/leap/$releasever/repo/oss/' tuna-oss
  sudo zypper ar -cfg 'http://mirrors.tuna.tsinghua.edu.cn/opensuse/distribution/leap/$releasever/repo/non-oss/' tuna-non-oss
  sudo zypper ar -cfg 'http://mirrors.tuna.tsinghua.edu.cn/opensuse/update/leap/$releasever/oss/' tuna-update
  sudo zypper ar -cfg 'http://mirrors.tuna.tsinghua.edu.cn/opensuse/update/leap/$releasever/non-oss/' tuna-update-non-oss
  ;;
arch)
  echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' >/etc/pacman.d/mirrorlist
  pacman -Scc --noconfirm
  pacman -Syy --noconfirm
  pacman -S --noconfirm python3
  ;;
esac

if [ $(cat /proc/sys/kernel/hostname) == 'master01' ]; then
  set -e
  sudo apt-get clean
  sudo apt-get update
  sudo apt-get install make python3 python3-pip -y
  sudo git clone -b ${KUBE_VERSION} https://github.com/buxiaomo/kubeasy.git /usr/local/src/kubeasy
  pushd /usr/local/src/kubeasy >/dev/null 2>&1
    sudo pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
    sudo make runtime
    sudo pip3 install pyOpenSSL --upgrade
    [ -f ./inventory/kubeasy-dev.ini ] || cp ./inventory/template/vagrant-compatibility.template ./inventory/kubeasy-dev.ini
    sudo make prepare
    sudo make deploy REGISTRY_URL=http://192.168.56.10:5000 KUBE_NETWORK=${KUBE_NETWORK}
  popd >/dev/null 2>&1
fi
