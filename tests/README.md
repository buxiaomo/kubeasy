# tests

## Code compatibility testing

This Vagrantfile is used to test the compatibility of deploying K8S on various systems. Follow these steps to test

```
# Creating an ssh key
mkdir -p .ssh
ssh-keygen -t RSA -N '' -f .ssh/id_rsa

# Set the version and install the necessary plug-ins
echo 'KUBE_VERSION=v1.23
KUBE_NETWORK=calico' > .env
vagrant plugin install vagrant-env

# Starting VM
vagrant up
```