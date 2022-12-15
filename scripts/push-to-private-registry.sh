#!/bin/bash
# ./push-to-private-registry.sh -h 172.16.2.11 -r infra -u admin -p admin
help() {
  echo "Usage:"
  echo "$0 -h host -u username -p password [-r repository ]"
  echo "Description:"
  echo "host, harbor url."
  echo "repository, harbor repository name."
  echo "username, harbor username."
  echo "password, harbor password."
  exit -1
}

while getopts "h:r:u:p:" opt_name; do
  case $opt_name in
  h)
    export host=$OPTARG
    ;;
  r)
    export repo=$OPTARG
    ;;
  u)
    export username=$OPTARG
    ;;
  p)
    export password=$OPTARG
    ;;
  ?)
    help
    ;;
  esac
done

set -e
if [ -n ${username} ] || [ -n ${password} ]; then
  echo ${password} | docker login --username ${username} --password-stdin ${host} >/dev/null
fi

for r in $(curl -s 127.0.0.1:5000/v2/_catalog | jq -r .repositories[]); do
  for t in $(curl -s 127.0.0.1:5000/v2/${r}/tags/list | jq -r .tags[]); do
    if [ "$repo" == "" ]; then
      export toHarbor=${host}/${r}:${t}
    else
      export toHarbor=${host}/${repo}/${r}:${t}
    fi
    echo "[message] pull 127.0.0.1:5000/${r}:${t}"
    docker pull 127.0.0.1:5000/${r}:${t} >/dev/null

    echo "[message] rename 127.0.0.1:5000/${r}:${t} -> ${toHarbor}"
    docker tag 127.0.0.1:5000/${r}:${t} ${toHarbor} >/dev/null

    echo "[message] push ${toHarbor}"
    docker push ${toHarbor} >/dev/null

    echo "[message] clean ${toHarbor}"
    docker rmi --force 127.0.0.1:5000/${r}:${t} ${toHarbor} >/dev/null
    echo ""
  done
done
