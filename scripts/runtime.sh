#!/bin/bash
command -v yum &> /dev/null && export PKG=yum
command -v apt &> /dev/null && export PKG=apt

if [ ${PKG} == "yum" ];then
  yum install epel-release -y
  yum install make curl ansible -y
fi

if [ ${PKG} == "apt" ];then
  apt-add-repository ppa:ansible/ansible
  apt-get update
  apt-get install ansible -y
fi