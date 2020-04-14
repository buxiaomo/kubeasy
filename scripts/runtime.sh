#!/bin/bash
command -v yum &> /dev/null && export PKG=yum
command -v apt &> /dev/null && export PKG=apt
${PKG} install python3 python3-pip sshpass -y
# command -v pip3 &> /dev/null || curl https://bootstrap.pypa.io/get-pip.py | python
pip3 install --upgrade -i https://pypi.tuna.tsinghua.edu.cn/simple ansible