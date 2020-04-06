#!/bin/bash
command -v yum &> /dev/null && export PKG=yum
command -v apt &> /dev/null && export PKG=apt
${PKG} install python python-pip sshpass -y
pip install --upgrade -i https://pypi.tuna.tsinghua.edu.cn/simple ansible>=2.9.6