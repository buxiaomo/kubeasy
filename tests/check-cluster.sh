#!/bin/bash
set -e

echo -e "\033[32m-> Deploy test service...\033[0m"
kubectl apply -f ./tests/manifests/check-cluster.yaml -f ./tests/manifests/dnsutils.yaml

kubectl -n test01 rollout status daemonset/nginx01
kubectl -n test02 rollout status daemonset/nginx02
kubectl -n default rollout status daemonset/dnsutils

echo -e "\033[32m-> Check Cluster DNS...\033[0m"
SVC01=$(kubectl get svc -n test01 --selector=app=nginx01 -o jsonpath='{.items[0].metadata.name}')
SVC02=$(kubectl get svc -n test02 --selector=app=nginx02 -o jsonpath='{.items[0].metadata.name}')
for pod in $(kubectl get po --selector=app=dnsutils -o jsonpath='{.items[*].metadata.name}');
do
  kubectl exec -it ${pod} -- nslookup kubernetes
  kubectl exec -it ${pod} -- nslookup ${SVC01}.test01
  kubectl exec -it ${pod} -- nslookup ${SVC02}.test02
done

echo -e "\033[32m-> Check the Pod IP connectivity of each node...\033[0m"
for node in $(kubectl get node -o jsonpath='{.items[*].status.addresses[0].address}');
do
  echo -e "\033[32m-----------------------------Node: ${node}-----------------------------\033[0m"
  for podip in $(kubectl get pod -n test01 --selector=app=nginx01 -o jsonpath='{.items[*].status.podIP}');
  do
    ssh -o StrictHostKeyChecking=no ${node} "ping -w 3 -c 1 ${podip}"
  done
  echo
done

echo -e "\033[32m-> Check service IP and port accessibility...\033[0m"
clusterIP=$(kubectl get svc -n test01 --selector=app=nginx01 -o jsonpath='{.items[0].spec.clusterIP}')
targetPort=$(kubectl get svc -n test01 --selector=app=nginx01 -o jsonpath='{.items[0].spec.ports[].targetPort}')
for node in $(kubectl get node -o jsonpath='{.items[*].status.addresses[0].address}');
do
  status=$(ssh -o StrictHostKeyChecking=no ${node} "curl -s -o /dev/null -w %{http_code} http://${clusterIP}:${targetPort}")
  echo -e "Node: ${node}\t Status: ${status}"
done

echo -e "\033[32m-> Check the NodePort accessibility of the service...\033[0m"
nodePort=$(kubectl get svc -n test01 --selector=app=nginx01 -o jsonpath='{.items[0].spec.ports[].nodePort}')
for node in $(kubectl get node -o jsonpath='{.items[*].status.addresses[0].address}');
do
  status=$(curl -s -o /dev/null -w %{http_code} http://${node}:${nodePort})
  echo -e "Node: ${node}\t Status: ${status}"
done

echo -e "\033[32m-> Clean up...\033[0m"
kubectl delete -f ./tests/manifests/check-cluster.yaml -f ./tests/manifests/dnsutils.yaml