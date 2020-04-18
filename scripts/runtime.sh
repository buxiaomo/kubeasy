#!/bin/bash
command -v yum &> /dev/null && export PKG=yum
command -v apt &> /dev/null && export PKG=apt
${PKG} install python3 python3-pip sshpass -y
pip3 install --upgrade -i https://pypi.tuna.tsinghua.edu.cn/simple ansible