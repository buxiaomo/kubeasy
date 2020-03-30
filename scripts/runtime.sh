#!/bin/bash
apt install make -y
yes '' | apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install ansible -y