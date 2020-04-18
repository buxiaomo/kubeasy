#!/bin/bash
kubectl apply -f test.yaml
SVC01=$(kubectl get svc --selector=app=nginx01 -n test -o jsonpath='{.items[0].metadata.name}')
POD01=$(kubectl get po --selector=app=nginx01 -n test -o jsonpath='{.items[0].metadata.name}')

SVC02=$(kubectl get svc --selector=app=nginx02 -n test -o jsonpath='{.items[0].metadata.name}')
POD02=$(kubectl get po --selector=app=nginx02 -n test -o jsonpath='{.items[0].metadata.name}')

kubectl exec -it -n test ${POD01} -- nslookup ${SVC01}
kubectl exec -it -n test ${POD01} -- nslookup ${SVC02}

kubectl exec -it -n test ${POD02} -- nslookup ${SVC01}
kubectl exec -it -n test ${POD02} -- nslookup ${SVC02}

kubectl exec -it -n test ${POD01} -- wget http://${SVC01} -O /dev/null
kubectl exec -it -n test ${POD01} -- wget http://${SVC02} -O /dev/null

kubectl exec -it -n test ${POD02} -- wget http://${SVC01} -O /dev/null
kubectl exec -it -n test ${POD02} -- wget http://${SVC02} -O /dev/null

kubectl delete -f test.yaml