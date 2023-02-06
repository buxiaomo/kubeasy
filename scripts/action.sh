#!/bin/bash
echo '-------------------------------------------------------------------------------------'
echo '                  ____  __.    ___.                                                 '
echo '                 |    |/ _|__ _\_ |__   ____ _____    _________.__.                 '
echo '                 |      < |  |  \ __ \_/ __ \\__  \  /  ___<   |  |                 '
echo '                 |    |  \|  |  / \_\ \  ___/ / __ \_\___ \ \___  |                 '
echo '                 |____|__ \____/|___  /\___  >____  /____  >/ ____|                 '
echo '                         \/         \/     \/     \/     \/ \/                      '
echo '-------------------------------------------------------------------------------------'
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/root/bin"

ARCH=$(uname -m)
if [ ${ARCH} != "aarch64" ] && [ ${ARCH} != "x86_64" ]; then
  echo -e "${ARCH} architecture is not supported!"
  exit 0
fi
ANSIBLE_ENV="-e PROJECT_NAME=${PROJECT_NAME} -e PROJECT_ENV=${PROJECT_ENV} -e DOWNLOAD_WAY=${DOWNLOAD_WAY} -e KUBE_RUNTIME=${KUBE_RUNTIME} -e KUBE_VERSION=${KUBE_VERSION} -e KUBE_NETWORK=${KUBE_NETWORK} -e ETCD_VERSION=${ETCD_VERSION} -e CNI_VERSION=${CNI_VERSION}"

echo -e "Project name: \033[32m${PROJECT_NAME}\033[0m\tProject env: \033[32m${PROJECT_ENV}\033[0m"
echo -e "Binary download mode: \t\t\033[32m${DOWNLOAD_WAY}\033[0m"
echo -e "Kubernetes runtime mode: \t\033[32m${KUBE_RUNTIME}\033[0m"
echo -e "Kubernetes version: \t\t\033[32m${KUBE_VERSION}\033[0m"
echo -e "Kubernetes network: \t\t\033[32m${KUBE_NETWORK}\033[0m"
echo -e "Etcd version: \t\t\t\033[32m${ETCD_VERSION}\033[0m"

case ${KUBE_RUNTIME} in
"docker")
  echo -e "Docker version: \t\t\033[32m${DOCKER_VERSION}\033[0m"
  ANSIBLE_ENV="${ANSIBLE_ENV} -e DOCKER_VERSION=${DOCKER_VERSION}"
  ;;
"containerd")
  echo -e "Containerd version: \t\t\033[32m${CONTAINERD_VERSION}\033[0m"
  echo -e "Runc version: \t\t\t\033[32m${RUNC_VERSION}\033[0m"
  echo -e "Crictl version: \t\t\033[32m${CRICTL_VERSION}\033[0m"
  ANSIBLE_ENV="${ANSIBLE_ENV} -e CONTAINERD_VERSION=${CONTAINERD_VERSION} -e RUNC_VERSION=${RUNC_VERSION} -e CRICTL_VERSION=${CRICTL_VERSION}"
  ;;
*)
  echo "Unknown runtime!!!"
  exit 0
  ;;
esac
echo -e "CNI version: \t\t\t\033[32m${CNI_VERSION}\033[0m"

if [ ${REGISTRY_URL} ]; then
  echo -e "Private registry: \t\t\033[32m${REGISTRY_URL}\033[0m"
  ANSIBLE_ENV="${ANSIBLE_ENV} -e REGISTRY_URL=${REGISTRY_URL}"
fi

if [ ${PKI_URL} ]; then
  echo -e "PKI Url: \t\t\t\033[32m${PKI_URL}\033[0m"
  ANSIBLE_ENV="${ANSIBLE_ENV} -e PKI_URL=${PKI_URL}"
fi

if [ ${DOWNLOAD_WAY} == "nexus" ]; then
  if [[ ${NEXUS_DOMAIN_NAME} == "" || ${NEXUS_REPOSITORY} == "" ]]; then
    echo -e "\033[31mNexus parameter error, please set NEXUS_DOMAIN_NAME, NEXUS_REPOSITORY! \033[0m "
    exit 1
  else
    echo '-------------------------------------------------------------------------------------'
    echo -e "Nexus Url: \t\t\t\033[32m${NEXUS_DOMAIN_NAME}\033[0m"
    echo -e "Nexus repository: \t\t\033[32m${NEXUS_REPOSITORY}\033[0m"
    ANSIBLE_ENV="${ANSIBLE_ENV} -e NEXUS_DOMAIN_NAME=${NEXUS_DOMAIN_NAME} -e NEXUS_REPOSITORY=${NEXUS_REPOSITORY}"
    if [[ ${NEXUS_USERNAME} != "" || ${NEXUS_PASSWORD} != "" ]]; then
      echo -e "Nexus username: \t\t\033[32m${NEXUS_USERNAME}\033[0m"
      echo -e "Nexus password: \t\t\033[32m******\033[0m"
      ANSIBLE_ENV="${ANSIBLE_ENV} -e NEXUS_USERNAME=${NEXUS_USERNAME} -e NEXUS_PASSWORD=${NEXUS_PASSWORD}"
    fi
    echo '-------------------------------------------------------------------------------------'
  fi
fi

echo
echo -e "\033[32mPress any key to install...or Press Ctrl+c to cancel\033[0m"
OLDCONFIG=`stty -g`
stty -icanon -echo min 1 time 0
dd count=1 2>/dev/null
stty ${OLDCONFIG}

case $1 in
"deploy")
  if [ $(git rev-parse --abbrev-ref HEAD) == 'main' ]; then
    echo -e "\033[31mMessage: main branch is develop, Please do not use in production.\033[0m"
  else
    branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "v${KUBE_VERSION:0:4}" != ${branch} ]; then
      echo -e "\033[31m* The current branch is: ${branch}\033[0m"
      echo -e "\033[31m* You want to deploy v${KUBE_VERSION:0:4}, please run follow command and try again\033[0m"
      echo -e "\033[31mgit checkout v${KUBE_VERSION:0:4}\033[0m"
      exit 1
    fi
  fi
  start=$(date +%s)
  ansible-playbook -i ./inventory/${PROJECT_NAME}-${PROJECT_ENV}.ini ./deploy.yml -e KUBE_ACTION="deploy" ${ANSIBLE_ENV}
  if [ $? -eq 0 ]; then
    end=$(date +%s)
    echo -e "\033[32mDeploy kubernetes is done, execute commands is $((end - start)) seconds, please run 'kubectl get po -A' to check the pod status.\033[0m"
  fi
  ;;
"scale")
  declare -A HOST_LIST
  for host in $(ansible-inventory -i ./inventory/${PROJECT_NAME}-${PROJECT_ENV}.ini --list 2>/dev/null | jq -r .worker.hosts[]); do
    if [ ! -f ~/.ansible/ansible_fact_cache/${host} ]; then
      HOST_LIST[${host}]=${host}
    fi
  done
  if [ ${#HOST_LIST[*]} -eq 0 ]; then
    echo -e "\033[32mNo new machines.\033[0m"
    exit 0
  fi
  start=$(date +%s)
  ansible-playbook -i ./inventory/${PROJECT_NAME}-${PROJECT_ENV}.ini ./scale.yml --limit $(echo ${HOST_LIST[@]} | sed 's/ /,/g') -e KUBE_ACTION="scale" ${ANSIBLE_ENV}
  if [ $? -eq 0 ]; then
    end=$(date +%s)
    echo -e "\033[32mScale kubernetes is done, execute commands is $((end - start)) seconds, please run 'kubectl get no -o wide' to check the node status.\033[0m"
  else
    for element in ${HOST_LIST[@]}; do
      rm -rf ~/.ansible/ansible_fact_cache/${element}
    done
  fi
  ;;
"upgrade")
  start=$(date +%s)
  ansible-playbook -i ./inventory/${PROJECT_NAME}-${PROJECT_ENV}.ini ./upgrade.yml -e KUBE_ACTION="upgrade" ${ANSIBLE_ENV} --tags upgrade
  if [ $? -eq 0 ]; then
    end=$(date +%s)
    echo -e "\033[32mUpgrade kubernetes is done, execute commands is $((end - start)) seconds, please run 'kubectl get no -o wide' to check the node version status.\033[0m"
  fi
  ;;
"renew")
  start=$(date +%s)
  ansible-playbook -i ./inventory/${PROJECT_NAME}-${PROJECT_ENV}.ini ./renew.yml -e KUBE_ACTION="renew" ${ANSIBLE_ENV} -e expired=true --tags renew
  if [ $? -eq 0 ]; then
    end=$(date +%s)
    echo -e "\033[32mRotate kubernetes certificates is done, execute commands is $((end - start)) seconds, please run 'kubectl get cs' on all master to check the component status.\033[0m"
  fi
  ;;
"update")
  start=$(date +%s)
  ansible-playbook -i ./inventory/${PROJECT_NAME}-${PROJECT_ENV}.ini ./update.yml -e KUBE_ACTION="update" ${ANSIBLE_ENV} --tags update
  if [ $? -eq 0 ]; then
    end=$(date +%s)
    echo -e "\033[32mUpdate kubernetes is done, execute commands is $((end - start)) seconds, please run 'kubectl get no' on all master to check the node status.\033[0m"
  fi
  ;;
*)
  echo "Unknown action!!!"
  ;;
esac
