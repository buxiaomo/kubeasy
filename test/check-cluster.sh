#!/bin/bash
set -e

check_pod_ready() {
  NAMESPACE=$1
  SELECTOR=$2
  kubectl -n ${NAMESPACE} get po \
  --selector=${SELECTOR} \
  -o jsonpath='{.items[*].status.phase}' | grep Running >/dev/null 2>&1
  echo $?
}

echo -e "\033[32mDeploy test service...\033[0m"
kubectl apply -f test.yaml

echo -e "\033[32mWait resources ready...\033[0m"
CHECK_POD_LIST="app=nginx01 app=nginx02"
for pod in ${CHECK_POD_LIST};do
  retry_times=0
  RETRY=60
  while [ "$retry_times" -lt $RETRY ]; do
      if [ "$(check_pod_ready test ${pod})" -eq 0 ];then
        break
      else
        retry_times=$((retry_times+1))
        sleep 1
      fi
  done
done

SVC01=$(kubectl get svc --selector=app=nginx01 -n test -o jsonpath='{.items[0].metadata.name}')
POD01=$(kubectl get po --selector=app=nginx01 -n test -o jsonpath='{.items[0].metadata.name}')

SVC02=$(kubectl get svc --selector=app=nginx02 -n test -o jsonpath='{.items[0].metadata.name}')
POD02=$(kubectl get po --selector=app=nginx02 -n test -o jsonpath='{.items[0].metadata.name}')

echo -e "\033[32mCheck Cluster DNS...\033[0m"
kubectl exec -it -n test ${POD01} -- nslookup ${SVC01}
kubectl exec -it -n test ${POD01} -- nslookup ${SVC02}

kubectl exec -it -n test ${POD02} -- nslookup ${SVC01}
kubectl exec -it -n test ${POD02} -- nslookup ${SVC02}

echo -e "\033[32mCheck Cluster Network...\033[0m"
kubectl exec -it -n test ${POD01} -- wget http://${SVC01} -O /dev/null
kubectl exec -it -n test ${POD01} -- wget http://${SVC02} -O /dev/null

kubectl exec -it -n test ${POD02} -- wget http://${SVC01} -O /dev/null
kubectl exec -it -n test ${POD02} -- wget http://${SVC02} -O /dev/null

echo -e "\033[32mCheck Cluster nodePort...\033[0m"
nodePort=$(kubectl get svc --selector=app=nginx01 -n test -o jsonpath='{.items[0].spec.ports[].nodePort}')
for node in $(kubectl get node -o jsonpath='{.items[*].status.addresses[0].address}');
do
  curl http://${node}:${nodePort} -o /tmp/index.html
done

echo -e "\033[32mClean up...\033[0m"
kubectl delete -f test.yaml