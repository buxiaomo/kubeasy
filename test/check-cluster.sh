#!/bin/bash
set -e

echo -e "\033[32m-> Deploy test service...\033[0m"
kubectl apply -f check-cluster.yaml -f dnsutils.yaml

CHECK_POD_LIST="app=nginx01 app=nginx02 app=dnsutils"
for pod in ${CHECK_POD_LIST};do
  retry_times=0
  RETRY=120
  while [ "$retry_times" -lt $RETRY ]; do
    desiredNumberScheduled=$(kubectl -n default get daemonset --selector=${pod} -o jsonpath='{ .items[0].status.desiredNumberScheduled }')
    numberReady=$(kubectl -n default get daemonset --selector=${pod} -o jsonpath='{ .items[0].status.numberReady }')
    if [ "${desiredNumberScheduled}" == "${numberReady}" ];then
      break
    else
      echo -e "\033[32m-> Waiting for the resources(${pod}) ready - ${retry_times}...\033[0m"
      retry_times=$((retry_times+1))
      sleep 1
    fi

    # if [ "$(check_pod_ready 'default' ${pod})" -eq 0 ];then
    #   break
    # else
    #   echo -e "\033[32m-> Waiting for the resources(${pod}) ready - ${retry_times}...\033[0m"
    #   retry_times=$((retry_times+1))
    #   sleep 1
    # fi
  done
  if [ $retry_times -ge 120 ];then
    echo -e "\033[31m-> Waiting for a resource ready timeout, exit.\033[0m"
    exit 1
  fi
done

echo -e "\033[32m-> Check Cluster DNS...\033[0m"
SVC01=$(kubectl get svc --selector=app=nginx01 -o jsonpath='{.items[0].metadata.name}')
SVC02=$(kubectl get svc --selector=app=nginx02 -o jsonpath='{.items[0].metadata.name}')
for pod in $(kubectl get po --selector=app=dnsutils -o jsonpath='{.items[*].metadata.name}');
do
  kubectl exec -it ${pod} -- nslookup kubernetes
  kubectl exec -it ${pod} -- nslookup ${SVC01}
  kubectl exec -it ${pod} -- nslookup ${SVC02}
done

echo -e "\033[32m-> Check the Pod IP connectivity of each node...\033[0m"
for node in $(kubectl get node -o jsonpath='{.items[*].status.addresses[0].address}');
do
  echo -e "\033[32m-----------------------------Node: ${node}-----------------------------\033[0m"
  for podip in $(kubectl get pod --selector=app=nginx01 -o jsonpath='{.items[*].status.podIP}');
  do
    ssh ${node} "ping -c 1 ${podip}"
  done
  echo
done

echo -e "\033[32m-> Check service IP and port accessibility...\033[0m"
clusterIP=$(kubectl get svc --selector=app=nginx01 -o jsonpath='{.items[0].spec.clusterIP}')
targetPort=$(kubectl get svc --selector=app=nginx01 -o jsonpath='{.items[0].spec.ports[].targetPort}')
for node in $(kubectl get node -o jsonpath='{.items[*].status.addresses[0].address}');
do
  status=$(ssh ${node} "curl -s -o /dev/null -w %{http_code} http://${clusterIP}:${targetPort}")
  echo -e "Node: ${node}\t Status: ${status}"
done

echo -e "\033[32m-> Check the NodePort accessibility of the service...\033[0m"
nodePort=$(kubectl get svc --selector=app=nginx01 -o jsonpath='{.items[0].spec.ports[].nodePort}')
for node in $(kubectl get node -o jsonpath='{.items[*].status.addresses[0].address}');
do
  status=$(curl -s -o /dev/null -w %{http_code} http://${node}:${nodePort})
  echo -e "Node: ${node}\t Status: ${status}"
done

echo -e "\033[32m-> Clean up...\033[0m"
kubectl delete -f check-cluster.yaml -f dnsutils.yaml