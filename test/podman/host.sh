#!/bin/bash
master01=$(podman inspect master01 | jq .[].NetworkSettings.Networks.kube.IPAddress -r)
master02=$(podman inspect master02 | jq .[].NetworkSettings.Networks.kube.IPAddress -r)
master03=$(podman inspect master03 | jq .[].NetworkSettings.Networks.kube.IPAddress -r)
worker01=$(podman inspect worker01 | jq .[].NetworkSettings.Networks.kube.IPAddress -r)

cat > hosts <<EOF
[master]
${master01} nodename=master01
${master02} nodename=master02
${master03} nodename=master03

[worker]
${worker01} nodename=worker01

[kubernetes:children]
master
worker
EOF