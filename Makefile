SHELL := /bin/bash
GIT_SHA = $(shell git log --pretty=oneline | head -n1 | cut -c1-8)
SHASUM = $(shell test `uname` == 'Darwin' && echo shasum -a 256 || echo sha256sum)

install:
	@ansible-playbook -i hosts install.yml

uninstall:
	@ansible-playbook uninstall.yml

upgrade:
	@ansible-playbook upgrade.yml

download:
	@scripts/download.sh

runtime:
	@scripts/runtime.sh

check:
	@ansible -i hosts all -m ping
	@ping -c 3 $(awk -F "=" "/^VIP/{print \$2}" hosts) 2> /dev/null