#!/bin/bash
command -v yum &> /dev/null && export PKG=yum
command -v apt &> /dev/null && export PKG=apt
${PKG} install python3 python3-pip sshpass curl -y
pip3 install --upgrade -i https://pypi.tuna.tsinghua.edu.cn/simple "ansible==2.9.7"
chmod +x /usr/local/bin/ansible*