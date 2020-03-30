#!/bin/bash
apt install make curl -y
yes '' | apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible -y