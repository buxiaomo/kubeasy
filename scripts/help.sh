#!/bin/bash
echo '-------------------------------------------------------------------------------------'
echo '                  ____  __.    ___.                                                 '
echo '                 |    |/ _|__ _\_ |__   ____ _____    _________.__.                 '
echo '                 |      < |  |  \ __ \_/ __ \\__  \  /  ___<   |  |                 '
echo '                 |    |  \|  |  / \_\ \  ___/ / __ \_\___ \ \___  |                 '
echo '                 |____|__ \____/|___  /\___  >____  /____  >/ ____|                 '
echo '                         \/         \/     \/     \/     \/ \/                      '
echo '-------------------------------------------------------------------------------------'
echo '    kubeasy is an easy tool for deploying kubernetes, you can run the'
echo 'following commands to deploy or manage the cluster.'
echo ''
echo 'Available Commands:'
echo -e 'make prepare\t\tIf the file exists, copy the file to each role. This command requires the kubeasy-binary or kubeasy-registry file
make runtime\t\twill install the ansible runtime environment
make hosts\t\twill edit ansible inventory file
make deploy\t\twill install kubernetes components
make scale\t\twill expansion worker node
make renew\t\twill rotate kubernetes certificates
make update\t\twill update kubernetes configuration
make upgrade\t\twill upgrade kubernetes to new version
make check\t\twill check basic cluster functions, need running on master node
make e2e\t\twill e2e test, need running on master node'
echo ''
echo -e 'Global argument: 
PROJECT_NAME\t\tMulti-project Support. default: kubeasy
PROJECT_ENV\t\tMulti-project Support. default: dev
KUBE_VERSION\t\tKubernetes version
KUBE_RUNTIME\t\tContainer runtime. default: docker, choose: docker or containerd
KUBE_NETWORK\t\tContainer network. default: flannel, choose: flannel, calico, canal
REGISTRY_URL\t\tDocker registry address in an offline environment
DOWNLOAD_WAY\t\tDownload the way, will try local file. choose: official or nexus
NEXUS_DOMAIN_NAME\tUsed when DOWNLOAD_WAY is nexus
NEXUS_REPOSITORY\tUsed when DOWNLOAD_WAY is nexus
NEXUS_USERNAME\t\tUsed when DOWNLOAD_WAY is nexus
NEXUS_PASSWORD\t\tUsed when DOWNLOAD_WAY is nexus'
