[root@k8s-m01 Kubernetes-ansible]# ansible-playbook 01-setup.yml -e 'kernel=true'

PLAY [Allnode] ****************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************
ok: [172.16.14.11]
ok: [172.16.14.14]
ok: [172.16.14.12]
ok: [172.16.14.13]

TASK [setup : include_tasks] **************************************************************************************************************************
included: /root/Kubernetes-ansible/roles/setup/tasks/centos.yml for 172.16.14.14, 172.16.14.11, 172.16.14.12, 172.16.14.13

TASK [setup : 关闭firewalld NetworkManager dnsmasq - CentOS] ********************************************************************************************
changed: [172.16.14.11] => (item=firewalld)
changed: [172.16.14.14] => (item=firewalld)
changed: [172.16.14.12] => (item=firewalld)
changed: [172.16.14.13] => (item=firewalld)
failed: [172.16.14.14] (item=dnsmasq) => {"ansible_loop_var": "item", "changed": false, "item": "dnsmasq", "msg": "Could not find the requested service dnsmasq: host"}
...ignoring
failed: [172.16.14.12] (item=dnsmasq) => {"ansible_loop_var": "item", "changed": false, "item": "dnsmasq", "msg": "Could not find the requested service dnsmasq: host"}
...ignoring
failed: [172.16.14.13] (item=dnsmasq) => {"ansible_loop_var": "item", "changed": false, "item": "dnsmasq", "msg": "Could not find the requested service dnsmasq: host"}
...ignoring
failed: [172.16.14.11] (item=dnsmasq) => {"ansible_loop_var": "item", "changed": false, "item": "dnsmasq", "msg": "Could not find the requested service dnsmasq: host"}
...ignoring

TASK [setup : 临时关闭 selinux] ***************************************************************************************************************************
changed: [172.16.14.12]
changed: [172.16.14.13]
changed: [172.16.14.14]
changed: [172.16.14.11]

TASK [setup : 永久关闭 selinux] ***************************************************************************************************************************
ok: [172.16.14.13]
ok: [172.16.14.14]
ok: [172.16.14.12]
ok: [172.16.14.11]

TASK [setup : 禁止rsyslog获取journald日志] ******************************************************************************************************************
changed: [172.16.14.14] => (item=(^\$ModLoad imjournal))
changed: [172.16.14.12] => (item=(^\$ModLoad imjournal))
changed: [172.16.14.13] => (item=(^\$ModLoad imjournal))
changed: [172.16.14.11] => (item=(^\$ModLoad imjournal))
changed: [172.16.14.14] => (item=(^\$IMJournalStateFile))
changed: [172.16.14.12] => (item=(^\$IMJournalStateFile))
changed: [172.16.14.13] => (item=(^\$IMJournalStateFile))
changed: [172.16.14.11] => (item=(^\$IMJournalStateFile))

TASK [setup : 修改systemctl启动的最小文件打开数量] *****************************************************************************************************************
changed: [172.16.14.14] => (item={u'key': u'(DefaultLimitCORE)=', u'value': u'100000'})
changed: [172.16.14.12] => (item={u'key': u'(DefaultLimitCORE)=', u'value': u'100000'})
changed: [172.16.14.13] => (item={u'key': u'(DefaultLimitCORE)=', u'value': u'100000'})
changed: [172.16.14.11] => (item={u'key': u'(DefaultLimitCORE)=', u'value': u'100000'})
changed: [172.16.14.14] => (item={u'key': u'(DefaultLimitNOFILE)=', u'value': u'100000'})
changed: [172.16.14.12] => (item={u'key': u'(DefaultLimitNOFILE)=', u'value': u'100000'})
changed: [172.16.14.13] => (item={u'key': u'(DefaultLimitNOFILE)=', u'value': u'100000'})
changed: [172.16.14.11] => (item={u'key': u'(DefaultLimitNOFILE)=', u'value': u'100000'})

TASK [setup : 添加EPEL仓库] *******************************************************************************************************************************
changed: [172.16.14.14]
changed: [172.16.14.12]
changed: [172.16.14.13]
changed: [172.16.14.11]

TASK [setup : 安装基础软件包] ********************************************************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.14]
changed: [172.16.14.13]
changed: [172.16.14.12]

TASK [setup : 导入GPG key] ******************************************************************************************************************************
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
changed: [172.16.14.13]
changed: [172.16.14.14]
changed: [172.16.14.12]
changed: [172.16.14.11]

TASK [setup : 导入elrepo] *******************************************************************************************************************************
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
changed: [172.16.14.14]
changed: [172.16.14.11]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [setup : 升级到最新内核] ********************************************************************************************************************************
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
^@^@changed: [172.16.14.11]
changed: [172.16.14.14]
changed: [172.16.14.13]
changed: [172.16.14.12]

TASK [setup : 修改默认启动内核到新内核] ***************************************************************************************************************************
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
[DEPRECATION WARNING]: evaluating u'kernel' as a bare variable, this behaviour will go away and you might need to add |bool to the expression in the
future. Also see CONDITIONAL_BARE_VARS configuration toggle. This feature will be removed in version 2.12. Deprecation warnings can be disabled by
setting deprecation_warnings=False in ansible.cfg.
changed: [172.16.14.11]
changed: [172.16.14.14]
changed: [172.16.14.13]
changed: [172.16.14.12]

TASK [setup : 设置内核参数适应docker] *************************************************************************************************************************
changed: [172.16.14.14]
changed: [172.16.14.12]
changed: [172.16.14.13]
changed: [172.16.14.11]

TASK [setup : 物理机下调整cpu到非省电模式] ************************************************************************************************************************
skipping: [172.16.14.14]
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [setup : Set timezone] ***************************************************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.13]
changed: [172.16.14.12]
changed: [172.16.14.14]

TASK [setup : 修改fstab文件关闭swap] ************************************************************************************************************************
ok: [172.16.14.14]
ok: [172.16.14.12]
ok: [172.16.14.13]
ok: [172.16.14.11]

TASK [setup : 分发modules-load和sysctl的conf] *************************************************************************************************************
changed: [172.16.14.11] => (item={u'dest': u'/etc/modules-load.d/', u'src': u'k8s-ipvs.conf'})
changed: [172.16.14.13] => (item={u'dest': u'/etc/modules-load.d/', u'src': u'k8s-ipvs.conf'})
changed: [172.16.14.14] => (item={u'dest': u'/etc/modules-load.d/', u'src': u'k8s-ipvs.conf'})
changed: [172.16.14.12] => (item={u'dest': u'/etc/modules-load.d/', u'src': u'k8s-ipvs.conf'})
changed: [172.16.14.13] => (item={u'dest': u'/etc/security/limits.d/', u'src': u'kubernetes.conf'})
changed: [172.16.14.12] => (item={u'dest': u'/etc/security/limits.d/', u'src': u'kubernetes.conf'})
changed: [172.16.14.14] => (item={u'dest': u'/etc/security/limits.d/', u'src': u'kubernetes.conf'})
changed: [172.16.14.11] => (item={u'dest': u'/etc/security/limits.d/', u'src': u'kubernetes.conf'})

TASK [setup : Send sysctl file] ***********************************************************************************************************************
changed: [172.16.14.14]
changed: [172.16.14.13]
changed: [172.16.14.12]
changed: [172.16.14.11]

TASK [setup : enable --now systemd-modules-load] ******************************************************************************************************
changed: [172.16.14.14]
changed: [172.16.14.12]
changed: [172.16.14.13]
changed: [172.16.14.11]

TASK [setup : include_tasks] **************************************************************************************************************************
included: /root/Kubernetes-ansible/tasks/time/chrony.yml for 172.16.14.14, 172.16.14.11, 172.16.14.12, 172.16.14.13

TASK [setup : remove ntp] *****************************************************************************************************************************
ok: [172.16.14.14]
ok: [172.16.14.12]
ok: [172.16.14.13]
ok: [172.16.14.11]

TASK [setup : Install chrony] *************************************************************************************************************************
ok: [172.16.14.14]
ok: [172.16.14.12]
ok: [172.16.14.11]
ok: [172.16.14.13]

TASK [setup : Send chrony configuration file] *********************************************************************************************************
changed: [172.16.14.14]
changed: [172.16.14.12]
changed: [172.16.14.13]
changed: [172.16.14.11]

TASK [setup : include_tasks] **************************************************************************************************************************
skipping: [172.16.14.14]
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [setup : 设置crond开机并启动] ***************************************************************************************************************************
ok: [172.16.14.14]
ok: [172.16.14.12]
ok: [172.16.14.13]
ok: [172.16.14.11]

TASK [setup : 关闭sshd反向解析] *****************************************************************************************************************************
changed: [172.16.14.14]
changed: [172.16.14.12]
changed: [172.16.14.13]
changed: [172.16.14.11]

TASK [setup : prepare some dirs] **********************************************************************************************************************
changed: [172.16.14.11] => (item=/etc/kubernetes/pki)
changed: [172.16.14.12] => (item=/etc/kubernetes/pki)
changed: [172.16.14.13] => (item=/etc/kubernetes/pki)
changed: [172.16.14.14] => (item=/etc/kubernetes/pki)
changed: [172.16.14.13] => (item=/etc/kubernetes/manifests)
changed: [172.16.14.12] => (item=/etc/kubernetes/manifests)
changed: [172.16.14.14] => (item=/etc/kubernetes/manifests)
changed: [172.16.14.11] => (item=/etc/kubernetes/manifests)
changed: [172.16.14.12] => (item=/var/log/kubernetes)
changed: [172.16.14.14] => (item=/var/log/kubernetes)
changed: [172.16.14.13] => (item=/var/log/kubernetes)
changed: [172.16.14.11] => (item=/var/log/kubernetes)

TASK [setup : Set hostname] ***************************************************************************************************************************
ok: [172.16.14.11]
ok: [172.16.14.14]
ok: [172.16.14.13]
ok: [172.16.14.12]

TASK [setup : Reboot host] ****************************************************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.12]
changed: [172.16.14.13]
changed: [172.16.14.14]

PLAY RECAP ********************************************************************************************************************************************
172.16.14.11               : ok=28   changed=19   unreachable=0    failed=0    skipped=2    rescued=0    ignored=1
172.16.14.12               : ok=28   changed=19   unreachable=0    failed=0    skipped=2    rescued=0    ignored=1
172.16.14.13               : ok=28   changed=19   unreachable=0    failed=0    skipped=2    rescued=0    ignored=1
172.16.14.14               : ok=28   changed=19   unreachable=0    failed=0    skipped=2    rescued=0    ignored=1

[root@k8s-m01 Kubernetes-ansible]# Connection to 172.16.14.11 closed by remote host.
Connection to 172.16.14.11 closed.
➜  ~ ssh root@172.16.14.11
root@172.16.14.11's password:
Last login: Tue Mar 31 16:39:22 2020 from k8s-m01
[root@k8s-m01 ~]# cd Kubernetes-ansible/
[root@k8s-m01 Kubernetes-ansible]# ls
01-setup.yml        04-tls.yml   07-master.yml     10-addon.yml  deploy.yml  preRedo.yml  restoreETCD.yml  tasks
02-docker.yml       05-etcd.yml  08-bootstrap.yml  addNode.yml   group_vars  README.md    roles            templates
03-get-binaries.sh  06-HA.yml    09-node.yml       ansible.cfg   inventory   redo.yml     scripts
[root@k8s-m01 Kubernetes-ansible]# ansible-playbook 02-docker.yml

PLAY [Allnode] ****************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************
ok: [172.16.14.11]
ok: [172.16.14.12]
ok: [172.16.14.13]
ok: [172.16.14.14]

TASK [docker : create the dir for docker] *************************************************************************************************************
changed: [172.16.14.11] => (item=/etc/docker)
changed: [172.16.14.14] => (item=/etc/docker)
changed: [172.16.14.12] => (item=/etc/docker)
changed: [172.16.14.13] => (item=/etc/docker)
changed: [172.16.14.11] => (item=/etc/systemd/system/docker.service.d/)
changed: [172.16.14.12] => (item=/etc/systemd/system/docker.service.d/)
changed: [172.16.14.13] => (item=/etc/systemd/system/docker.service.d/)
changed: [172.16.14.14] => (item=/etc/systemd/system/docker.service.d/)

TASK [docker : populate service facts] ****************************************************************************************************************
ok: [172.16.14.11]
ok: [172.16.14.12]
ok: [172.16.14.13]
ok: [172.16.14.14]

TASK [docker : set_fact] ******************************************************************************************************************************
ok: [172.16.14.14]
ok: [172.16.14.11]
ok: [172.16.14.12]
ok: [172.16.14.13]

TASK [docker : include_tasks] *************************************************************************************************************************
included: /root/Kubernetes-ansible/roles/docker/tasks/centos.yml for 172.16.14.14, 172.16.14.11, 172.16.14.12, 172.16.14.13

TASK [docker : Add the repo] **************************************************************************************************************************
changed: [172.16.14.12]
changed: [172.16.14.14]
changed: [172.16.14.13]
changed: [172.16.14.11]

TASK [docker : yum] ***********************************************************************************************************************************
ok: [172.16.14.11]
ok: [172.16.14.14]
ok: [172.16.14.13]
ok: [172.16.14.12]

TASK [docker : get the info of the docker-ce] *********************************************************************************************************
ok: [172.16.14.11]
ok: [172.16.14.13]
ok: [172.16.14.12]
ok: [172.16.14.14]

TASK [docker : set_fact] ******************************************************************************************************************************
ok: [172.16.14.14]
ok: [172.16.14.11]
ok: [172.16.14.12]
ok: [172.16.14.13]

TASK [docker : Check if docker-ce-19.03.8 is installed] ***********************************************************************************************
ok: [172.16.14.14]
ok: [172.16.14.11]
ok: [172.16.14.12]
ok: [172.16.14.13]

TASK [docker : Install docker-ce-19.03.8] *************************************************************************************************************
^@changed: [172.16.14.11]
changed: [172.16.14.14]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [docker : send the config file] ******************************************************************************************************************
changed: [172.16.14.13] => (item={u'dest': u'/etc/docker/daemon.json', u'src': u'daemon.json.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/etc/docker/daemon.json', u'src': u'daemon.json.j2'})
changed: [172.16.14.14] => (item={u'dest': u'/etc/docker/daemon.json', u'src': u'daemon.json.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/etc/docker/daemon.json', u'src': u'daemon.json.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/etc/systemd/system/docker.service.d/10-docker.conf', u'src': u'10-docker.conf.j2'})
changed: [172.16.14.14] => (item={u'dest': u'/etc/systemd/system/docker.service.d/10-docker.conf', u'src': u'10-docker.conf.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/etc/systemd/system/docker.service.d/10-docker.conf', u'src': u'10-docker.conf.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/etc/systemd/system/docker.service.d/10-docker.conf', u'src': u'10-docker.conf.j2'})

TASK [docker : Check if the completion script exists] *************************************************************************************************
ok: [172.16.14.14]
ok: [172.16.14.11]
ok: [172.16.14.12]
ok: [172.16.14.13]

TASK [docker : Set docker command completion script] **************************************************************************************************
changed: [172.16.14.14]
changed: [172.16.14.11]
changed: [172.16.14.12]
changed: [172.16.14.13]

RUNNING HANDLER [docker : restart docker] *************************************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.13]
changed: [172.16.14.12]
changed: [172.16.14.14]

PLAY RECAP ********************************************************************************************************************************************
172.16.14.11               : ok=15   changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.16.14.12               : ok=15   changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.16.14.13               : ok=15   changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.16.14.14               : ok=15   changed=6    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[root@k8s-m01 Kubernetes-ansible]# bash 03-get-binaries.sh all
v1.16.7-full: Pulling from zhangguanzhang/k8s_bin
e6b0cf9c0882: Pull complete
c82b6e09e8dd: Pull complete
4950b931189e: Pull complete
Digest: sha256:ec7fc167fb2390a2390acd1f332091687c88133423802c02d97a085288f66bbe
Status: Downloaded newer image for dockerhub.azk8s.cn/zhangguanzhang/k8s_bin:v1.16.7-full
dockerhub.azk8s.cn/zhangguanzhang/k8s_bin:v1.16.7-full
db7c0469ab95dc732192483a7fe070db16198d818f6010262252278b014d4f9d
kubernetes/server/bin/kubectl
kubernetes/server/bin/kube-scheduler
kubernetes/server/bin/kube-controller-manager
kubernetes/server/bin/kubelet
kubernetes/server/bin/kube-proxy
kubernetes/server/bin/kube-apiserver
v3.3.18: Pulling from coreos/etcd
89d9c30c1d48: Pull complete
13e71c3898bb: Pull complete
3407757785b9: Pull complete
e3937cb0ab26: Pull complete
5b7e2dfa5bc4: Pull complete
1e83ffbd0070: Pull complete
Digest: sha256:b2843a585bbe95ea5676d1d378d5fd2311f46403a501b51eaafc3d7c0cdee2e4
Status: Downloaded newer image for quay.azk8s.cn/coreos/etcd:v3.3.18
quay.azk8s.cn/coreos/etcd:v3.3.18
8f1906e78c80ca41dbf472a4c6f090c7603e78413939d9ba59be99d4961310d8
linux-amd64-v0.8.1: Pulling from zhangguanzhang/cni-plugins
8e402f1a9c57: Pull complete
8e20b0104ec4: Pull complete
c016f55f410e: Pull complete
Digest: sha256:cb48c09adacd8ef9bebbe16abf7037b30582a64f30e089b468299789dfd7c52f
Status: Downloaded newer image for dockerhub.azk8s.cn/zhangguanzhang/cni-plugins:linux-amd64-v0.8.1
dockerhub.azk8s.cn/zhangguanzhang/cni-plugins:linux-amd64-v0.8.1
750372a56ffb74f82b641fd43440acd19975ff450146f606e282b0bfbeda6a3b
v0.11.0-amd64: Pulling from coreos/flannel
cd784148e348: Pull complete
04ac94e9255c: Pull complete
e10b013543eb: Pull complete
005e31e443b1: Pull complete
74f794f05817: Pull complete
Digest: sha256:7806805c93b20a168d0bbbd25c6a213f00ac58a511c47e8fa6409543528a204e
Status: Downloaded newer image for quay.azk8s.cn/coreos/flannel:v0.11.0-amd64
quay.azk8s.cn/coreos/flannel:v0.11.0-amd64
c4bdb6f5ce6c0c8f96d81e7a3cb362a5b02078f943c1d98da750256e1dd96eaa
[root@k8s-m01 Kubernetes-ansible]# ansible-playbook 04-tls.yml

PLAY [localhost] **************************************************************************************************************************************

TASK [stat] *******************************************************************************************************************************************
ok: [localhost]

TASK [fail] *******************************************************************************************************************************************
skipping: [localhost]

PLAY [localhost] **************************************************************************************************************************************

TASK [tls : stat] *************************************************************************************************************************************
ok: [localhost]

TASK [tls : fail] *************************************************************************************************************************************
skipping: [localhost]

TASK [tls : Create the dir] ***************************************************************************************************************************
changed: [localhost]

TASK [tls : 生成kubeconfig] *****************************************************************************************************************************
included: /root/Kubernetes-ansible/roles/tls/tasks/tls.yml for localhost

TASK [tls : 渲染ip到openssl配置文件] *************************************************************************************************************************
changed: [localhost]

TASK [tls : kubernetes-ca] ****************************************************************************************************************************
changed: [localhost]

TASK [tls : etcd-ca] **********************************************************************************************************************************
changed: [localhost]

TASK [tls : front-proxy-ca] ***************************************************************************************************************************
changed: [localhost]

TASK [tls : apiserver-etcd-client --- part.1] *********************************************************************************************************
changed: [localhost]

TASK [tls : apiserver-etcd-client --- part.2] *********************************************************************************************************
changed: [localhost]

TASK [tls : kube-etcd --- part.1] *********************************************************************************************************************
changed: [localhost]

TASK [tls : kube-etcd --- part.2] *********************************************************************************************************************
changed: [localhost]

TASK [tls : kube-etcd-peer --- part.1] ****************************************************************************************************************
changed: [localhost]

TASK [tls : kube-etcd-peer --- part.2] ****************************************************************************************************************
changed: [localhost]

TASK [tls : kube-etcd-healthcheck-client --- part.1] **************************************************************************************************
changed: [localhost]

TASK [tls : kube-etcd-healthcheck-client --- part.2] **************************************************************************************************
changed: [localhost]

TASK [tls : kube-apiserver --- part.1] ****************************************************************************************************************
changed: [localhost]

TASK [tls : kube-apiserver --- part.2] ****************************************************************************************************************
changed: [localhost]

TASK [tls : apiserver-kubelet-client --- part.1] ******************************************************************************************************
changed: [localhost]

TASK [tls : apiserver-kubelet-client --- part.2] ******************************************************************************************************
changed: [localhost]

TASK [tls : front-proxy-client --- part.1] ************************************************************************************************************
changed: [localhost]

TASK [tls : front-proxy-client --- part.2] ************************************************************************************************************
changed: [localhost]

TASK [tls : kube-scheduler --- part.1] ****************************************************************************************************************
changed: [localhost]

TASK [tls : kube-scheduler --- part.2] ****************************************************************************************************************
changed: [localhost]

TASK [tls : sa.pub sa.key] ****************************************************************************************************************************
changed: [localhost]

TASK [tls : admin] ************************************************************************************************************************************
changed: [localhost]

TASK [tls : 清理 srl] ***********************************************************************************************************************************
changed: [localhost]

TASK [tls : 生成kubeconfig] *****************************************************************************************************************************
included: /root/Kubernetes-ansible/roles/tls/tasks/kubeconfig.yml for localhost

TASK [tls : 生成kubeconfig] *****************************************************************************************************************************
changed: [localhost] => (item={u'KUBE_CERT': u'sa', u'KUBE_USER': u'system:kube-controller-manager', u'KUBE_CONFIG': u'controller-manager.kubeconfig'})
changed: [localhost] => (item={u'KUBE_CERT': u'kube-scheduler', u'KUBE_USER': u'system:kube-scheduler', u'KUBE_CONFIG': u'scheduler.kubeconfig'})
changed: [localhost] => (item={u'KUBE_CERT': u'admin', u'KUBE_USER': u'kubernetes-admin', u'KUBE_CONFIG': u'admin.kubeconfig'})

PLAY RECAP ********************************************************************************************************************************************
localhost                  : ok=29   changed=25   unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

[root@k8s-m01 Kubernetes-ansible]# ansible-playbook 05-etcd.yml

PLAY [master] *****************************************************************************************************************************************

TASK [etcd : Set hostname] ****************************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [etcd : include_tasks] ***************************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [etcd : include_tasks] ***************************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [etcd : include_tasks] ***************************************************************************************************************************
included: /root/Kubernetes-ansible/roles/etcd/tasks/etcd.yml for 172.16.14.11, 172.16.14.12, 172.16.14.13

TASK [etcd : 创建etcd相关目录] ******************************************************************************************************************************
changed: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd)
changed: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd)
changed: [172.16.14.11] => (item=/var/lib/etcd)
changed: [172.16.14.13] => (item=/var/lib/etcd)
changed: [172.16.14.12] => (item=/var/lib/etcd)
changed: [172.16.14.11] => (item=/etc/etcd)
changed: [172.16.14.13] => (item=/etc/etcd)
changed: [172.16.14.12] => (item=/etc/etcd)
ok: [172.16.14.11] => (item=/etc/etcd/)
ok: [172.16.14.13] => (item=/etc/etcd/)
ok: [172.16.14.12] => (item=/etc/etcd/)
changed: [172.16.14.11] => (item=/root/etcd_bak)
changed: [172.16.14.13] => (item=/root/etcd_bak)
changed: [172.16.14.12] => (item=/root/etcd_bak)

TASK [etcd : set_fact] ********************************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [etcd : 分发etcd二进制文件] *****************************************************************************************************************************
ok: [172.16.14.11] => (item=/usr/local/bin/etcd)
ok: [172.16.14.11] => (item=/usr/local/bin/etcdctl)
changed: [172.16.14.12] => (item=/usr/local/bin/etcd)
changed: [172.16.14.13] => (item=/usr/local/bin/etcd)
changed: [172.16.14.12] => (item=/usr/local/bin/etcdctl)
changed: [172.16.14.13] => (item=/usr/local/bin/etcdctl)

TASK [etcd : 分发etcd证书] ********************************************************************************************************************************
changed: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/ca.key)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/ca.key)
changed: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/ca.key)
changed: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/ca.crt)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/ca.crt)
changed: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/ca.crt)
changed: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/server.key)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/server.key)
changed: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/server.key)
changed: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/server.csr)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/server.csr)
changed: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/server.csr)
changed: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/server.crt)
changed: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/server.crt)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/server.crt)
changed: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/peer.key)
changed: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/peer.key)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/peer.key)
changed: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/peer.csr)
changed: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/peer.csr)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/peer.csr)
changed: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/peer.crt)
changed: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/peer.crt)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/peer.crt)
changed: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.key)
changed: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.key)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.key)
changed: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.csr)
changed: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.csr)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.csr)
changed: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.crt)
changed: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.crt)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.crt)

TASK [etcd : 分发etcd配置文件和systemd文件] ********************************************************************************************************************
changed: [172.16.14.12] => (item={u'dest': u'/etc/etcd', u'src': u'etcd.config.yml.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/etc/etcd', u'src': u'etcd.config.yml.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/etc/etcd', u'src': u'etcd.config.yml.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/usr/lib/systemd/system', u'src': u'etcd.service.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/usr/lib/systemd/system', u'src': u'etcd.service.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/usr/lib/systemd/system', u'src': u'etcd.service.j2'})

TASK [etcd : 启动etcd并设置成开机启动] **************************************************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [etcd : localhost |渲染etcd.sh到/etc/profile.d/] ****************************************************************************************************
changed: [172.16.14.11]

TASK [etcd : 渲染etcd.sh到/etc/profile.d/] ***************************************************************************************************************
changed: [172.16.14.12]
changed: [172.16.14.13]
ok: [172.16.14.11]

TASK [etcd : 渲染etcd备份脚本] ******************************************************************************************************************************
changed: [172.16.14.11] => (item={u'dest': u'/etc/etcd//', u'src': u'etcd_cron.sh.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/etc/etcd//', u'src': u'etcd_cron.sh.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/etc/etcd//', u'src': u'etcd_cron.sh.j2'})

TASK [etcd : crontab配置备份脚本] ***************************************************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.13]
changed: [172.16.14.12]

PLAY RECAP ********************************************************************************************************************************************
172.16.14.11               : ok=10   changed=6    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0
172.16.14.12               : ok=9    changed=8    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0
172.16.14.13               : ok=9    changed=8    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

[root@k8s-m01 Kubernetes-ansible]# ansible-playbook 05-etcd.yml^C
[root@k8s-m01 Kubernetes-ansible]# ansible-playbook 06-HA.yml

PLAY [master] *****************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************
ok: [172.16.14.11]
ok: [172.16.14.13]
ok: [172.16.14.12]

TASK [HA : Install keepalived] ************************************************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [HA : Install haproxy] ***************************************************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [HA : Send HA configuration file] ****************************************************************************************************************
changed: [172.16.14.12] => (item={u'dest': u'/etc/keepalived/keepalived.conf', u'src': u'keepalived.conf.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/etc/keepalived/keepalived.conf', u'src': u'keepalived.conf.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/etc/keepalived/keepalived.conf', u'src': u'keepalived.conf.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/etc/keepalived/check_haproxy.sh', u'src': u'check_haproxy.sh.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/etc/keepalived/check_haproxy.sh', u'src': u'check_haproxy.sh.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/etc/keepalived/check_haproxy.sh', u'src': u'check_haproxy.sh.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/etc/haproxy/haproxy.cfg', u'src': u'haproxy.cfg.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/etc/haproxy/haproxy.cfg', u'src': u'haproxy.cfg.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/etc/haproxy/haproxy.cfg', u'src': u'haproxy.cfg.j2'})

TASK [HA : 启动haproxy keepalived] **********************************************************************************************************************
changed: [172.16.14.11] => (item=keepalived)
changed: [172.16.14.12] => (item=keepalived)
changed: [172.16.14.13] => (item=keepalived)
changed: [172.16.14.11] => (item=haproxy)
changed: [172.16.14.12] => (item=haproxy)
changed: [172.16.14.13] => (item=haproxy)

TASK [HA : wait_for] **********************************************************************************************************************************
^@ok: [172.16.14.13]
ok: [172.16.14.11]
ok: [172.16.14.12]

PLAY RECAP ********************************************************************************************************************************************
172.16.14.11               : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.16.14.12               : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
172.16.14.13               : ok=6    changed=4    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[root@k8s-m01 Kubernetes-ansible]# ansible-playbook 07-master.yml

PLAY [master] *****************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************
ok: [172.16.14.11]
ok: [172.16.14.12]
ok: [172.16.14.13]

TASK [master : include_tasks] *************************************************************************************************************************
included: /root/Kubernetes-ansible/roles/master/tasks/master.yml for 172.16.14.11, 172.16.14.12, 172.16.14.13

TASK [master : 创建证书,kubeconfig目录] *********************************************************************************************************************
ok: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd)
ok: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd)
changed: [172.16.14.12] => (item=~/.kube/)
ok: [172.16.14.11] => (item=~/.kube/)
changed: [172.16.14.13] => (item=~/.kube/)

TASK [master : include_tasks] *************************************************************************************************************************
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.11, 172.16.14.12, 172.16.14.13
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.11
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.11, 172.16.14.12, 172.16.14.13
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.11
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.11, 172.16.14.12, 172.16.14.13
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.11, 172.16.14.12, 172.16.14.13
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.11, 172.16.14.12, 172.16.14.13
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.11, 172.16.14.12, 172.16.14.13
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.11, 172.16.14.12, 172.16.14.13
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.11, 172.16.14.12, 172.16.14.13
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.12
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.12
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.13
included: /root/Kubernetes-ansible/roles/master/tasks/newlog.yml for 172.16.14.13

TASK [master : 创建组件目录] ********************************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [master : 创建组件目录] ********************************************************************************************************************************
skipping: [172.16.14.11]

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
skipping: [172.16.14.11]

TASK [master : 创建组件目录] ********************************************************************************************************************************
changed: [172.16.14.11] => (item=/var/log/kubernetes/kube-apiserver)
changed: [172.16.14.12] => (item=/var/log/kubernetes/kube-apiserver)
changed: [172.16.14.13] => (item=/var/log/kubernetes/kube-apiserver)

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
changed: [172.16.14.13] => (item=logrotate/kube-apiserver)
changed: [172.16.14.12] => (item=logrotate/kube-apiserver)
changed: [172.16.14.11] => (item=logrotate/kube-apiserver)

TASK [master : 创建组件目录] ********************************************************************************************************************************
skipping: [172.16.14.11]

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
skipping: [172.16.14.11]

TASK [master : 创建组件目录] ********************************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [master : 创建组件目录] ********************************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [master : 创建组件目录] ********************************************************************************************************************************
changed: [172.16.14.11] => (item=/var/log/kubernetes/kube-controller-manager)
changed: [172.16.14.12] => (item=/var/log/kubernetes/kube-controller-manager)
changed: [172.16.14.13] => (item=/var/log/kubernetes/kube-controller-manager)

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
changed: [172.16.14.11] => (item=logrotate/kube-controller-manager)
changed: [172.16.14.12] => (item=logrotate/kube-controller-manager)
changed: [172.16.14.13] => (item=logrotate/kube-controller-manager)

TASK [master : 创建组件目录] ********************************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [master : 创建组件目录] ********************************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [master : 创建组件目录] ********************************************************************************************************************************
changed: [172.16.14.11] => (item=/var/log/kubernetes/kube-scheduler)
changed: [172.16.14.12] => (item=/var/log/kubernetes/kube-scheduler)
changed: [172.16.14.13] => (item=/var/log/kubernetes/kube-scheduler)

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
changed: [172.16.14.11] => (item=logrotate/kube-scheduler)
changed: [172.16.14.12] => (item=logrotate/kube-scheduler)
changed: [172.16.14.13] => (item=logrotate/kube-scheduler)

TASK [master : 创建组件目录] ********************************************************************************************************************************
skipping: [172.16.14.12]

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
skipping: [172.16.14.12]

TASK [master : 创建组件目录] ********************************************************************************************************************************
skipping: [172.16.14.12]

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
skipping: [172.16.14.12]

TASK [master : 创建组件目录] ********************************************************************************************************************************
skipping: [172.16.14.13]

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
skipping: [172.16.14.13]

TASK [master : 创建组件目录] ********************************************************************************************************************************
skipping: [172.16.14.13]

TASK [master : 渲染logrotate配置文件] ***********************************************************************************************************************
skipping: [172.16.14.13]

TASK [master : 分发etcdctl到master成员] ********************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [master : etcd非master上跑时分发etcd证书到master成员] *******************************************************************************************************
skipping: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/ca.key)
skipping: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/ca.crt)
skipping: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/ca.key)
skipping: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/server.key)
skipping: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/server.csr)
skipping: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/server.crt)
skipping: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/ca.key)
skipping: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/ca.crt)
skipping: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/server.key)
skipping: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/server.csr)
skipping: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/server.crt)
skipping: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/peer.key)
skipping: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/peer.csr)
skipping: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/peer.crt)
skipping: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.key)
skipping: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.csr)
skipping: [172.16.14.11] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.crt)
skipping: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/peer.key)
skipping: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/peer.csr)
skipping: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/peer.crt)
skipping: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.key)
skipping: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.csr)
skipping: [172.16.14.12] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.crt)
skipping: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/ca.crt)
skipping: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/server.key)
skipping: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/server.csr)
skipping: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/server.crt)
skipping: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/peer.key)
skipping: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/peer.csr)
skipping: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/peer.crt)
skipping: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.key)
skipping: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.csr)
skipping: [172.16.14.13] => (item=/etc/kubernetes/pki/etcd/healthcheck-client.crt)

TASK [master : 渲染etcd.sh到/etc/profile.d/] *************************************************************************************************************
skipping: [172.16.14.11]
skipping: [172.16.14.12]
skipping: [172.16.14.13]

TASK [master : 分发证书] **********************************************************************************************************************************
skipping: [172.16.14.11] => (item={'group': u'root', 'uid': 0, 'state': 'directory', 'gid': 0, 'mode': '0755', 'mtime': 1585644345.8225088, 'owner': 'root', 'path': u'etcd', 'size': 226, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.8225088})
skipping: [172.16.14.12] => (item={'group': u'root', 'uid': 0, 'state': 'directory', 'gid': 0, 'mode': '0755', 'mtime': 1585644345.8225088, 'owner': 'root', 'path': u'etcd', 'size': 226, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.8225088})
skipping: [172.16.14.13] => (item={'group': u'root', 'uid': 0, 'state': 'directory', 'gid': 0, 'mode': '0755', 'mtime': 1585644345.8225088, 'owner': 'root', 'path': u'etcd', 'size': 226, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.8225088})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/openssl.cnf', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644337.8324733, 'owner': 'root', 'path': u'openssl.cnf', 'size': 1454, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644338.1924748})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/openssl.cnf', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644337.8324733, 'owner': 'root', 'path': u'openssl.cnf', 'size': 1454, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644338.1924748})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/openssl.cnf', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644337.8324733, 'owner': 'root', 'path': u'openssl.cnf', 'size': 1454, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644338.1924748})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/ca.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644338.8144774, 'owner': 'root', 'path': u'ca.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644338.8144774})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/ca.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644338.8144774, 'owner': 'root', 'path': u'ca.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644338.8144774})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/ca.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644338.8144774, 'owner': 'root', 'path': u'ca.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644338.8144774})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/ca.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644338.8214777, 'owner': 'root', 'path': u'ca.crt', 'size': 1046, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644338.8214777})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/ca.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644338.8214777, 'owner': 'root', 'path': u'ca.crt', 'size': 1046, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644338.8214777})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/ca.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644338.8214777, 'owner': 'root', 'path': u'ca.crt', 'size': 1046, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644338.8214777})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/front-proxy-ca.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.626481, 'owner': 'root', 'path': u'front-proxy-ca.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.626481})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/front-proxy-ca.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.626481, 'owner': 'root', 'path': u'front-proxy-ca.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.626481})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/front-proxy-ca.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.626481, 'owner': 'root', 'path': u'front-proxy-ca.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.626481})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/front-proxy-ca.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.6334813, 'owner': 'root', 'path': u'front-proxy-ca.crt', 'size': 1046, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.6334813})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/front-proxy-ca.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.6334813, 'owner': 'root', 'path': u'front-proxy-ca.crt', 'size': 1046, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.6334813})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/front-proxy-ca.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.6334813, 'owner': 'root', 'path': u'front-proxy-ca.crt', 'size': 1046, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.6334813})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/apiserver-etcd-client.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.9704826, 'owner': 'root', 'path': u'apiserver-etcd-client.key', 'size': 1679, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.9704826})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/apiserver-etcd-client.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.9704826, 'owner': 'root', 'path': u'apiserver-etcd-client.key', 'size': 1679, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.9704826})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/apiserver-etcd-client.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.9704826, 'owner': 'root', 'path': u'apiserver-etcd-client.key', 'size': 1679, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.9704826})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/apiserver-etcd-client.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.9764826, 'owner': 'root', 'path': u'apiserver-etcd-client.csr', 'size': 940, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.9764826})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/apiserver-etcd-client.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.9764826, 'owner': 'root', 'path': u'apiserver-etcd-client.csr', 'size': 940, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.9764826})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/apiserver-etcd-client.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.9764826, 'owner': 'root', 'path': u'apiserver-etcd-client.csr', 'size': 940, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.9764826})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/apiserver-etcd-client.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644340.2944841, 'owner': 'root', 'path': u'apiserver-etcd-client.crt', 'size': 1261, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644340.2944841})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/apiserver-etcd-client.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644340.2944841, 'owner': 'root', 'path': u'apiserver-etcd-client.crt', 'size': 1261, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644340.2944841})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/apiserver-etcd-client.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644340.2944841, 'owner': 'root', 'path': u'apiserver-etcd-client.crt', 'size': 1261, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644340.2944841})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/apiserver.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.5984943, 'owner': 'root', 'path': u'apiserver.key', 'size': 1679, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.5984943})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/apiserver.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.5984943, 'owner': 'root', 'path': u'apiserver.key', 'size': 1679, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.5984943})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/apiserver.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.5984943, 'owner': 'root', 'path': u'apiserver.key', 'size': 1679, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.5984943})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/apiserver.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.6054945, 'owner': 'root', 'path': u'apiserver.csr', 'size': 899, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.6054945})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/apiserver.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.6054945, 'owner': 'root', 'path': u'apiserver.csr', 'size': 899, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.6054945})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/apiserver.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.6054945, 'owner': 'root', 'path': u'apiserver.csr', 'size': 899, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.6054945})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/apiserver.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.8624957, 'owner': 'root', 'path': u'apiserver.crt', 'size': 1419, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.8624957})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/apiserver.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.8624957, 'owner': 'root', 'path': u'apiserver.crt', 'size': 1419, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.8624957})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/apiserver.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.8624957, 'owner': 'root', 'path': u'apiserver.crt', 'size': 1419, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.8624957})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/apiserver-kubelet-client.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.2644973, 'owner': 'root', 'path': u'apiserver-kubelet-client.key', 'size': 1679, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.2644973})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/apiserver-kubelet-client.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.2644973, 'owner': 'root', 'path': u'apiserver-kubelet-client.key', 'size': 1679, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.2644973})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/apiserver-kubelet-client.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.2644973, 'owner': 'root', 'path': u'apiserver-kubelet-client.key', 'size': 1679, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.2644973})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/apiserver-kubelet-client.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.2714975, 'owner': 'root', 'path': u'apiserver-kubelet-client.csr', 'size': 944, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.2714975})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/apiserver-kubelet-client.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.2714975, 'owner': 'root', 'path': u'apiserver-kubelet-client.csr', 'size': 944, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.2714975})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/apiserver-kubelet-client.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.2714975, 'owner': 'root', 'path': u'apiserver-kubelet-client.csr', 'size': 944, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.2714975})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/apiserver-kubelet-client.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.5274985, 'owner': 'root', 'path': u'apiserver-kubelet-client.crt', 'size': 1115, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.5274985})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/apiserver-kubelet-client.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.5274985, 'owner': 'root', 'path': u'apiserver-kubelet-client.crt', 'size': 1115, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.5274985})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/apiserver-kubelet-client.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.5274985, 'owner': 'root', 'path': u'apiserver-kubelet-client.crt', 'size': 1115, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.5274985})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/front-proxy-client.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.8645, 'owner': 'root', 'path': u'front-proxy-client.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.8645})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/front-proxy-client.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.8645, 'owner': 'root', 'path': u'front-proxy-client.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.8645})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/front-proxy-client.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.8645, 'owner': 'root', 'path': u'front-proxy-client.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.8645})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/front-proxy-client.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.8715, 'owner': 'root', 'path': u'front-proxy-client.csr', 'size': 903, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.8715})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/front-proxy-client.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.8715, 'owner': 'root', 'path': u'front-proxy-client.csr', 'size': 903, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.8715})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/front-proxy-client.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644343.8715, 'owner': 'root', 'path': u'front-proxy-client.csr', 'size': 903, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644343.8715})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/front-proxy-client.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644344.1305013, 'owner': 'root', 'path': u'front-proxy-client.crt', 'size': 1074, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644344.1305013})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/front-proxy-client.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644344.1305013, 'owner': 'root', 'path': u'front-proxy-client.crt', 'size': 1074, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644344.1305013})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/front-proxy-client.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644344.1305013, 'owner': 'root', 'path': u'front-proxy-client.crt', 'size': 1074, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644344.1305013})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/kube-scheduler.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644344.5875032, 'owner': 'root', 'path': u'kube-scheduler.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644344.5875032})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/kube-scheduler.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644344.5875032, 'owner': 'root', 'path': u'kube-scheduler.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644344.5875032})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/kube-scheduler.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644344.5875032, 'owner': 'root', 'path': u'kube-scheduler.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644344.5875032})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/kube-scheduler.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644344.5945032, 'owner': 'root', 'path': u'kube-scheduler.csr', 'size': 907, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644344.5945032})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/kube-scheduler.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644344.5945032, 'owner': 'root', 'path': u'kube-scheduler.csr', 'size': 907, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644344.5945032})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/kube-scheduler.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644344.5945032, 'owner': 'root', 'path': u'kube-scheduler.csr', 'size': 907, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644344.5945032})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/kube-scheduler.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644344.8635044, 'owner': 'root', 'path': u'kube-scheduler.crt', 'size': 1078, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644344.8635044})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/kube-scheduler.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644344.8635044, 'owner': 'root', 'path': u'kube-scheduler.crt', 'size': 1078, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644344.8635044})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/kube-scheduler.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644344.8635044, 'owner': 'root', 'path': u'kube-scheduler.crt', 'size': 1078, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644344.8635044})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/sa.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.2625062, 'owner': 'root', 'path': u'sa.key', 'size': 365, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.2625062})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/sa.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.2625062, 'owner': 'root', 'path': u'sa.key', 'size': 365, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.2625062})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/sa.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.2625062, 'owner': 'root', 'path': u'sa.key', 'size': 365, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.2625062})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/sa.pub', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.2665062, 'owner': 'root', 'path': u'sa.pub', 'size': 268, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.2665062})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/sa.pub', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.2665062, 'owner': 'root', 'path': u'sa.pub', 'size': 268, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.2665062})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/sa.pub', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.2665062, 'owner': 'root', 'path': u'sa.pub', 'size': 268, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.2665062})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/sa.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.2715063, 'owner': 'root', 'path': u'sa.csr', 'size': 566, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.2715063})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/sa.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.2715063, 'owner': 'root', 'path': u'sa.csr', 'size': 566, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.2715063})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/sa.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.2715063, 'owner': 'root', 'path': u'sa.csr', 'size': 566, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.2715063})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/sa.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.2855062, 'owner': 'root', 'path': u'sa.crt', 'size': 908, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.2855062})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/sa.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.2855062, 'owner': 'root', 'path': u'sa.crt', 'size': 908, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.2855062})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/sa.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.2855062, 'owner': 'root', 'path': u'sa.crt', 'size': 908, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.2855062})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/admin.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.5785077, 'owner': 'root', 'path': u'admin.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.5785077})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/admin.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.5785077, 'owner': 'root', 'path': u'admin.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.5785077})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/admin.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.5785077, 'owner': 'root', 'path': u'admin.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.5785077})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/admin.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.5855076, 'owner': 'root', 'path': u'admin.csr', 'size': 936, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.5855076})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/admin.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.5855076, 'owner': 'root', 'path': u'admin.csr', 'size': 936, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.5855076})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/admin.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.5855076, 'owner': 'root', 'path': u'admin.csr', 'size': 936, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.5855076})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/admin.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.6055079, 'owner': 'root', 'path': u'admin.crt', 'size': 1107, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.6055079})
changed: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/admin.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.6055079, 'owner': 'root', 'path': u'admin.crt', 'size': 1107, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.6055079})
changed: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/admin.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644345.6055079, 'owner': 'root', 'path': u'admin.crt', 'size': 1107, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644345.6055079})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/etcd/ca.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.2584796, 'owner': 'root', 'path': u'etcd/ca.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.2584796})
ok: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/etcd/ca.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.2584796, 'owner': 'root', 'path': u'etcd/ca.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.2584796})
ok: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/etcd/ca.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.2584796, 'owner': 'root', 'path': u'etcd/ca.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.2584796})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/etcd/ca.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.2654796, 'owner': 'root', 'path': u'etcd/ca.crt', 'size': 1029, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.2654796})
ok: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/etcd/ca.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.2654796, 'owner': 'root', 'path': u'etcd/ca.crt', 'size': 1029, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.2654796})
ok: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/etcd/ca.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644339.2654796, 'owner': 'root', 'path': u'etcd/ca.crt', 'size': 1029, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644339.2654796})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/etcd/server.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644340.6384857, 'owner': 'root', 'path': u'etcd/server.key', 'size': 1679, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644340.6384857})
ok: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/etcd/server.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644340.6384857, 'owner': 'root', 'path': u'etcd/server.key', 'size': 1679, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644340.6384857})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/etcd/server.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644340.6454856, 'owner': 'root', 'path': u'etcd/server.csr', 'size': 895, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644340.6454856})
ok: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/etcd/server.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644340.6384857, 'owner': 'root', 'path': u'etcd/server.key', 'size': 1679, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644340.6384857})
ok: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/etcd/server.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644340.6454856, 'owner': 'root', 'path': u'etcd/server.csr', 'size': 895, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644340.6454856})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/etcd/server.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644340.9004867, 'owner': 'root', 'path': u'etcd/server.crt', 'size': 1212, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644340.9004867})
ok: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/etcd/server.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644340.6454856, 'owner': 'root', 'path': u'etcd/server.csr', 'size': 895, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644340.6454856})
ok: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/etcd/server.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644340.9004867, 'owner': 'root', 'path': u'etcd/server.crt', 'size': 1212, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644340.9004867})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/etcd/peer.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644341.2814884, 'owner': 'root', 'path': u'etcd/peer.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644341.2814884})
ok: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/etcd/server.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644340.9004867, 'owner': 'root', 'path': u'etcd/server.crt', 'size': 1212, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644340.9004867})
ok: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/etcd/peer.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644341.2814884, 'owner': 'root', 'path': u'etcd/peer.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644341.2814884})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/etcd/peer.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644341.2874885, 'owner': 'root', 'path': u'etcd/peer.csr', 'size': 891, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644341.2874885})
ok: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/etcd/peer.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644341.2814884, 'owner': 'root', 'path': u'etcd/peer.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644341.2814884})
ok: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/etcd/peer.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644341.2874885, 'owner': 'root', 'path': u'etcd/peer.csr', 'size': 891, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644341.2874885})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/etcd/peer.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644341.5464897, 'owner': 'root', 'path': u'etcd/peer.crt', 'size': 1208, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644341.5464897})
ok: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/etcd/peer.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644341.2874885, 'owner': 'root', 'path': u'etcd/peer.csr', 'size': 891, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644341.2874885})
ok: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/etcd/peer.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644341.5464897, 'owner': 'root', 'path': u'etcd/peer.crt', 'size': 1208, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644341.5464897})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/etcd/healthcheck-client.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.0434918, 'owner': 'root', 'path': u'etcd/healthcheck-client.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.0434918})
ok: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/etcd/peer.crt', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644341.5464897, 'owner': 'root', 'path': u'etcd/peer.crt', 'size': 1208, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644341.5464897})
ok: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/etcd/healthcheck-client.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.0434918, 'owner': 'root', 'path': u'etcd/healthcheck-client.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.0434918})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/etcd/healthcheck-client.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.050492, 'owner': 'root', 'path': u'etcd/healthcheck-client.csr', 'size': 895, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.050492})
ok: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/etcd/healthcheck-client.key', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.0434918, 'owner': 'root', 'path': u'etcd/healthcheck-client.key', 'size': 1675, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.0434918})
ok: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/etcd/healthcheck-client.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.050492, 'owner': 'root', 'path': u'etcd/healthcheck-client.csr', 'size': 895, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.050492})
ok: [172.16.14.11] => (item={'src': u'/etc/kubernetes/pki/etcd/healthcheck-client.crt', 'group': u'root', 'uid': 0, 'state': u'file', 'gid': 0, 'mode': u'0644', 'mtime': 1585644342.312493, 'owner': u'root', 'path': u'etcd/healthcheck-client.crt', 'size': 1212, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.312493})
ok: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/etcd/healthcheck-client.csr', 'group': u'root', 'uid': 0, 'state': 'file', 'gid': 0, 'mode': '0644', 'mtime': 1585644342.050492, 'owner': 'root', 'path': u'etcd/healthcheck-client.csr', 'size': 895, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.050492})
ok: [172.16.14.12] => (item={'src': u'/etc/kubernetes/pki/etcd/healthcheck-client.crt', 'group': u'root', 'uid': 0, 'state': u'file', 'gid': 0, 'mode': u'0644', 'mtime': 1585644342.312493, 'owner': u'root', 'path': u'etcd/healthcheck-client.crt', 'size': 1212, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.312493})
ok: [172.16.14.13] => (item={'src': u'/etc/kubernetes/pki/etcd/healthcheck-client.crt', 'group': u'root', 'uid': 0, 'state': u'file', 'gid': 0, 'mode': u'0644', 'mtime': 1585644342.312493, 'owner': u'root', 'path': u'etcd/healthcheck-client.crt', 'size': 1212, 'root': u'/etc/kubernetes/pki/', 'ctime': 1585644342.312493})

TASK [master : 配置管理组件的systemd文件] **********************************************************************************************************************
changed: [172.16.14.11] => (item=kube-apiserver.service.j2)
changed: [172.16.14.12] => (item=kube-apiserver.service.j2)
changed: [172.16.14.13] => (item=kube-apiserver.service.j2)
changed: [172.16.14.11] => (item=kube-controller-manager.service.j2)
changed: [172.16.14.12] => (item=kube-controller-manager.service.j2)
changed: [172.16.14.13] => (item=kube-controller-manager.service.j2)
changed: [172.16.14.11] => (item=kube-scheduler.service.j2)
changed: [172.16.14.12] => (item=kube-scheduler.service.j2)
changed: [172.16.14.13] => (item=kube-scheduler.service.j2)

TASK [master : 分发管理组件的kubeconfig] *********************************************************************************************************************
ok: [172.16.14.11] => (item=admin.kubeconfig)
changed: [172.16.14.12] => (item=admin.kubeconfig)
changed: [172.16.14.13] => (item=admin.kubeconfig)
ok: [172.16.14.11] => (item=controller-manager.kubeconfig)
changed: [172.16.14.13] => (item=controller-manager.kubeconfig)
changed: [172.16.14.12] => (item=controller-manager.kubeconfig)
ok: [172.16.14.11] => (item=scheduler.kubeconfig)
changed: [172.16.14.13] => (item=scheduler.kubeconfig)
changed: [172.16.14.12] => (item=scheduler.kubeconfig)

TASK [master : 分发管理组件二进制文件] ***************************************************************************************************************************
ok: [172.16.14.11] => (item=/usr/local/bin/kube-apiserver)
ok: [172.16.14.11] => (item=/usr/local/bin/kube-controller-manager)
ok: [172.16.14.11] => (item=/usr/local/bin/kube-scheduler)
ok: [172.16.14.11] => (item=/usr/local/bin/kubectl)
changed: [172.16.14.12] => (item=/usr/local/bin/kube-apiserver)
changed: [172.16.14.13] => (item=/usr/local/bin/kube-apiserver)
changed: [172.16.14.13] => (item=/usr/local/bin/kube-controller-manager)
changed: [172.16.14.12] => (item=/usr/local/bin/kube-controller-manager)
^@changed: [172.16.14.13] => (item=/usr/local/bin/kube-scheduler)
changed: [172.16.14.12] => (item=/usr/local/bin/kube-scheduler)
changed: [172.16.14.13] => (item=/usr/local/bin/kubectl)
changed: [172.16.14.12] => (item=/usr/local/bin/kubectl)

TASK [master : file] **********************************************************************************************************************************
ok: [172.16.14.11]

TASK [master : copy] **********************************************************************************************************************************
changed: [172.16.14.11] => (item={u'dest': u'~/.kube/config', u'src': u'/etc/kubernetes/admin.kubeconfig'})
changed: [172.16.14.11] => (item={u'dest': u'/etc/kubernetes/', u'src': u'healthz-rbac.yml'})

TASK [master : Set the kubeconfig of the kubectl on all master] ***************************************************************************************
ok: [172.16.14.11]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [master : 设置kubectl] *****************************************************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.13]
changed: [172.16.14.12]

TASK [master : 启动管理组件] ********************************************************************************************************************************
changed: [172.16.14.11] => (item=kube-apiserver)
changed: [172.16.14.12] => (item=kube-apiserver)
changed: [172.16.14.13] => (item=kube-apiserver)
changed: [172.16.14.11] => (item=kube-controller-manager)
changed: [172.16.14.12] => (item=kube-controller-manager)
changed: [172.16.14.13] => (item=kube-controller-manager)
changed: [172.16.14.11] => (item=kube-scheduler)
changed: [172.16.14.12] => (item=kube-scheduler)
changed: [172.16.14.13] => (item=kube-scheduler)

TASK [master : 渲染kube-ep.yml文件] ***********************************************************************************************************************
changed: [172.16.14.11] => (item=kube-ep.yml.j2)

TASK [master : 测试apiserver端口] *************************************************************************************************************************
FAILED - RETRYING: 测试apiserver端口 (10 retries left).
FAILED - RETRYING: 测试apiserver端口 (10 retries left).
FAILED - RETRYING: 测试apiserver端口 (10 retries left).
ok: [172.16.14.13]
ok: [172.16.14.12]
ok: [172.16.14.11]

TASK [master : 等待kubectl能操作集群] ************************************************************************************************************************
FAILED - RETRYING: 等待kubectl能操作集群 (10 retries left).
FAILED - RETRYING: 等待kubectl能操作集群 (9 retries left).
ok: [172.16.14.11 -> 172.16.14.11]

TASK [master : 设置二进制下的管理组件ep和healthz对外暴露] *************************************************************************************************************
changed: [172.16.14.11]

PLAY RECAP ********************************************************************************************************************************************
172.16.14.11               : ok=32   changed=12   unreachable=0    failed=0    skipped=17   rescued=0    ignored=0
172.16.14.12               : ok=27   changed=14   unreachable=0    failed=0    skipped=17   rescued=0    ignored=0
172.16.14.13               : ok=27   changed=14   unreachable=0    failed=0    skipped=17   rescued=0    ignored=0

[root@k8s-m01 Kubernetes-ansible]# ansible-playbook 08-bootstrap.yml

PLAY [localhost] **************************************************************************************************************************************

TASK [bootstrap : 检测bootstrap是否生成] ********************************************************************************************************************
ok: [localhost]

TASK [bootstrap : 配置bootstrap] ************************************************************************************************************************
changed: [localhost]

PLAY RECAP ********************************************************************************************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

[root@k8s-m01 Kubernetes-ansible]# ansible-playbook 09-node.yml

PLAY [localhost] **************************************************************************************************************************************

TASK [stat] *******************************************************************************************************************************************
ok: [localhost]

TASK [fail] *******************************************************************************************************************************************
skipping: [localhost]

PLAY [Allnode] ****************************************************************************************************************************************

TASK [node : include_tasks] ***************************************************************************************************************************
included: /root/Kubernetes-ansible/roles/node/tasks/kubelet.yml for 172.16.14.14, 172.16.14.11, 172.16.14.12, 172.16.14.13

TASK [node : 创建相关目录] **********************************************************************************************************************************
ok: [172.16.14.14] => (item=/etc/kubernetes/pki)
ok: [172.16.14.13] => (item=/etc/kubernetes/pki)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki)
ok: [172.16.14.12] => (item=/etc/kubernetes/pki)
ok: [172.16.14.14] => (item=/etc/kubernetes/manifests)
ok: [172.16.14.12] => (item=/etc/kubernetes/manifests)
ok: [172.16.14.11] => (item=/etc/kubernetes/manifests)
ok: [172.16.14.13] => (item=/etc/kubernetes/manifests)
changed: [172.16.14.14] => (item=/var/lib/kubelet/)
changed: [172.16.14.13] => (item=/var/lib/kubelet/)
changed: [172.16.14.11] => (item=/var/lib/kubelet/)
changed: [172.16.14.12] => (item=/var/lib/kubelet/)
changed: [172.16.14.14] => (item=/opt/cni/bin/)
changed: [172.16.14.13] => (item=/opt/cni/bin/)
changed: [172.16.14.11] => (item=/opt/cni/bin/)
changed: [172.16.14.12] => (item=/opt/cni/bin/)

TASK [node : 删除老旧的kubelet认证文件] ************************************************************************************************************************

TASK [node : 分发cni二进制文件] ******************************************************************************************************************************
changed: [172.16.14.13] => (item=/root/Kubernetes-ansible/cni-plugins-linux-amd64-v0.8.1.tgz)
changed: [172.16.14.12] => (item=/root/Kubernetes-ansible/cni-plugins-linux-amd64-v0.8.1.tgz)
changed: [172.16.14.14] => (item=/root/Kubernetes-ansible/cni-plugins-linux-amd64-v0.8.1.tgz)
changed: [172.16.14.11] => (item=/root/Kubernetes-ansible/cni-plugins-linux-amd64-v0.8.1.tgz)

TASK [node : 分发Kubelet二进制文件] **************************************************************************************************************************
ok: [172.16.14.11] => (item=/usr/local/bin/kubelet)
changed: [172.16.14.12] => (item=/usr/local/bin/kubelet)
changed: [172.16.14.14] => (item=/usr/local/bin/kubelet)
changed: [172.16.14.13] => (item=/usr/local/bin/kubelet)

TASK [node : 创建log目录] *********************************************************************************************************************************
changed: [172.16.14.14]
changed: [172.16.14.11]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [node : 渲染kubelet的logrotate配置文件] *****************************************************************************************************************
changed: [172.16.14.14] => (item=logrotate/kubelet)
changed: [172.16.14.11] => (item=logrotate/kubelet)
changed: [172.16.14.12] => (item=logrotate/kubelet)
changed: [172.16.14.13] => (item=logrotate/kubelet)

TASK [node : 获取docker CgroupDriver值] ******************************************************************************************************************
changed: [172.16.14.12]
changed: [172.16.14.13]
changed: [172.16.14.14]
changed: [172.16.14.11]

TASK [node : 配置kubelet] *******************************************************************************************************************************
changed: [172.16.14.14] => (item={u'dest': u'/lib/systemd/system/', u'src': u'kubelet.service.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/lib/systemd/system/', u'src': u'kubelet.service.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/lib/systemd/system/', u'src': u'kubelet.service.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/lib/systemd/system/', u'src': u'kubelet.service.j2'})
changed: [172.16.14.14] => (item={u'dest': u'/etc/kubernetes/', u'src': u'kubelet-conf.yml.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/etc/kubernetes/', u'src': u'kubelet-conf.yml.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/etc/kubernetes/', u'src': u'kubelet-conf.yml.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/etc/kubernetes/', u'src': u'kubelet-conf.yml.j2'})

TASK [node : 分发kubelet相关证书] ***************************************************************************************************************************
changed: [172.16.14.14] => (item=/etc/kubernetes/pki/ca.crt)
ok: [172.16.14.13] => (item=/etc/kubernetes/pki/ca.crt)
ok: [172.16.14.11] => (item=/etc/kubernetes/pki/ca.crt)
ok: [172.16.14.12] => (item=/etc/kubernetes/pki/ca.crt)
changed: [172.16.14.14] => (item=/etc/kubernetes/bootstrap.kubeconfig)
changed: [172.16.14.13] => (item=/etc/kubernetes/bootstrap.kubeconfig)
changed: [172.16.14.12] => (item=/etc/kubernetes/bootstrap.kubeconfig)
ok: [172.16.14.11] => (item=/etc/kubernetes/bootstrap.kubeconfig)

TASK [node : 开机并启动kubelet] ****************************************************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.14]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [node : 请给master节点上的kubelet打污点] ******************************************************************************************************************
ok: [172.16.14.14] => {
    "msg": "kubectl  taint nodes k8s-m01 k8s-m02 k8s-m03   node-role.kubernetes.io/master=\"\":NoSchedule\n"
}

PLAY RECAP ********************************************************************************************************************************************
172.16.14.11               : ok=10   changed=7    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
172.16.14.12               : ok=10   changed=9    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
172.16.14.13               : ok=10   changed=9    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
172.16.14.14               : ok=11   changed=9    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
localhost                  : ok=1    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

[root@k8s-m01 Kubernetes-ansible]# kubectl get nodes
NAME      STATUS     ROLES    AGE   VERSION
k8s-m01   NotReady   <none>   10s   v1.16.7
k8s-m02   NotReady   <none>   9s    v1.16.7
k8s-m03   NotReady   <none>   21s   v1.16.7
k8s-n01   NotReady   <none>   10s   v1.16.7
[root@k8s-m01 Kubernetes-ansible]#
[root@k8s-m01 Kubernetes-ansible]#
[root@k8s-m01 Kubernetes-ansible]#
[root@k8s-m01 Kubernetes-ansible]# ansible-playbook 10-addon.yml

PLAY [Allnode] ****************************************************************************************************************************************

TASK [CoreAddons : file] ******************************************************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.13]
changed: [172.16.14.12]
changed: [172.16.14.14]

TASK [CoreAddons : 部署kube-proxy] **********************************************************************************************************************
skipping: [172.16.14.14] => (item=kube-proxy.yml.j2)
skipping: [172.16.14.11] => (item=kube-proxy.yml.j2)
skipping: [172.16.14.12] => (item=kube-proxy.yml.j2)
skipping: [172.16.14.13] => (item=kube-proxy.yml.j2)

TASK [CoreAddons : command] ***************************************************************************************************************************
skipping: [172.16.14.14]

TASK [CoreAddons : 部署Kube-proxy] **********************************************************************************************************************
ok: [172.16.14.11]
changed: [172.16.14.14]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [CoreAddons : stat] ******************************************************************************************************************************
ok: [172.16.14.14]
ok: [172.16.14.11]
ok: [172.16.14.12]
ok: [172.16.14.13]

TASK [CoreAddons : 生成kube-proxy的kubeconfig并配置] ********************************************************************************************************
changed: [172.16.14.14]

TASK [CoreAddons : 创建目录/var/log/kubernetes/kube-proxy/logrotate] **************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.14]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [CoreAddons : 分发logrotate配置文件] *******************************************************************************************************************
changed: [172.16.14.11] => (item=logrotate/kube-proxy)
changed: [172.16.14.14] => (item=logrotate/kube-proxy)
changed: [172.16.14.12] => (item=logrotate/kube-proxy)
changed: [172.16.14.13] => (item=logrotate/kube-proxy)

TASK [CoreAddons : 分发kube-proxy.kubeconfig] ***********************************************************************************************************
changed: [172.16.14.14]
changed: [172.16.14.12]
ok: [172.16.14.11]
changed: [172.16.14.13]

TASK [CoreAddons : template] **************************************************************************************************************************
changed: [172.16.14.11] => (item={u'dest': u'/usr/lib/systemd/system/', u'src': u'kube-proxy.service.j2'})
changed: [172.16.14.14] => (item={u'dest': u'/usr/lib/systemd/system/', u'src': u'kube-proxy.service.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/usr/lib/systemd/system/', u'src': u'kube-proxy.service.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/usr/lib/systemd/system/', u'src': u'kube-proxy.service.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/etc/kubernetes/', u'src': u'kube-proxy.conf.j2'})
changed: [172.16.14.14] => (item={u'dest': u'/etc/kubernetes/', u'src': u'kube-proxy.conf.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/etc/kubernetes/', u'src': u'kube-proxy.conf.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/etc/kubernetes/', u'src': u'kube-proxy.conf.j2'})

TASK [CoreAddons : 开机并启动kube-proxy] *******************************************************************************************************************
changed: [172.16.14.11]
changed: [172.16.14.14]
changed: [172.16.14.13]
changed: [172.16.14.12]

TASK [CoreAddons : 渲染kube-flannel.yml文件模板] ************************************************************************************************************
skipping: [172.16.14.14] => (item=kube-flannel.yml.j2)

TASK [CoreAddons : 部署flannel] *************************************************************************************************************************
skipping: [172.16.14.14]

TASK [CoreAddons : 创建相关目录] ****************************************************************************************************************************
changed: [172.16.14.11] => (item=/etc/cni/net.d)
changed: [172.16.14.14] => (item=/etc/cni/net.d)
changed: [172.16.14.12] => (item=/etc/cni/net.d)
changed: [172.16.14.13] => (item=/etc/cni/net.d)
changed: [172.16.14.11] => (item=/run/flannel)
changed: [172.16.14.14] => (item=/run/flannel)
changed: [172.16.14.12] => (item=/run/flannel)
changed: [172.16.14.13] => (item=/run/flannel)
changed: [172.16.14.11] => (item=/etc/kube-flannel/)
changed: [172.16.14.14] => (item=/etc/kube-flannel/)
changed: [172.16.14.12] => (item=/etc/kube-flannel/)
changed: [172.16.14.13] => (item=/etc/kube-flannel/)

TASK [CoreAddons : 分发flanneld二进制文件] *******************************************************************************************************************
ok: [172.16.14.11]
changed: [172.16.14.14]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [CoreAddons : 生成flanneld的kubeconfig] *************************************************************************************************************
changed: [172.16.14.14]

TASK [CoreAddons : 分发flanneld.kubeconfig] *************************************************************************************************************
ok: [172.16.14.11]
changed: [172.16.14.14]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [CoreAddons : template] **************************************************************************************************************************
changed: [172.16.14.14] => (item={u'dest': u'/usr/lib/systemd/system', u'src': u'flanneld.service.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/usr/lib/systemd/system', u'src': u'flanneld.service.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/usr/lib/systemd/system', u'src': u'flanneld.service.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/usr/lib/systemd/system', u'src': u'flanneld.service.j2'})
changed: [172.16.14.14] => (item={u'dest': u'/etc/cni/net.d', u'src': u'10-flannel.conflist.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/etc/cni/net.d', u'src': u'10-flannel.conflist.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/etc/cni/net.d', u'src': u'10-flannel.conflist.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/etc/cni/net.d', u'src': u'10-flannel.conflist.j2'})
changed: [172.16.14.14] => (item={u'dest': u'/etc/kube-flannel', u'src': u'net-conf.json.j2'})
changed: [172.16.14.11] => (item={u'dest': u'/etc/kube-flannel', u'src': u'net-conf.json.j2'})
changed: [172.16.14.13] => (item={u'dest': u'/etc/kube-flannel', u'src': u'net-conf.json.j2'})
changed: [172.16.14.12] => (item={u'dest': u'/etc/kube-flannel', u'src': u'net-conf.json.j2'})

TASK [CoreAddons : 开机并启动flanneld] *********************************************************************************************************************
changed: [172.16.14.14]
changed: [172.16.14.11]
changed: [172.16.14.12]
changed: [172.16.14.13]

TASK [CoreAddons : 渲染coredns,metrics-server文件模板] ******************************************************************************************************
changed: [172.16.14.14 -> 172.16.14.11] => (item=coredns.yml.j2)
changed: [172.16.14.14 -> 172.16.14.11] => (item=metrics-server.yml.j2)

TASK [CoreAddons : 部署coredns,metrics-server] **********************************************************************************************************
changed: [172.16.14.14 -> 172.16.14.11] => (item=coredns.yml)
changed: [172.16.14.14 -> 172.16.14.11] => (item=metrics-server.yml)

PLAY RECAP ********************************************************************************************************************************************
172.16.14.11               : ok=13   changed=8    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
172.16.14.12               : ok=13   changed=12   unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
172.16.14.13               : ok=13   changed=12   unreachable=0    failed=0    skipped=1    rescued=0    ignored=0
172.16.14.14               : ok=17   changed=16   unreachable=0    failed=0    skipped=4    rescued=0    ignored=0
