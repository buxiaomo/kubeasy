#!/bin/bash
command -v yum &> /dev/null && export PKG=yum
command -v apt &> /dev/null && export PKG=apt
${PKG} install python sshpass -y
curl https://bootstrap.pypa.io/get-pip.py | python
pip install --upgrade -i https://pypi.tuna.tsinghua.edu.cn/simple ansible