RUNTIME := "ubuntu:16.04-systemd"

build:
	@podman build -t centos:7-systemd ./centos-7/.
	@podman build -t ubuntu:16.04-systemd ./ubuntu-16.04/.
	@podman build -t ubuntu:18.04-systemd ./ubuntu-18.04/.
	@podman build -t ansible:systemd ./ansible/.

run:
	@[ -d ./ssh ] || mkdir -p ssh
	@[ -f ./ssh/id_rsa ] || ssh-keygen -t rsa -P "" -f ./ssh/id_rsa
	@[ -f ./ssh/authorized_keys ] || cp ./ssh/id_rsa.pub ./ssh/authorized_keys
	@podman network create kube || true
	@podman run -d --name ansible --network kube --privileged --hostname ansible -v ./ssh:/root/.ssh ansible:systemd
	@podman run -d --name master01 --network kube --privileged --hostname master01 -v ./ssh:/root/.ssh $(RUNTIME)
	@podman run -d --name master02 --network kube --privileged --hostname master02 -v ./ssh:/root/.ssh $(RUNTIME)
	@podman run -d --name master03 --network kube --privileged --hostname master03 -v ./ssh:/root/.ssh $(RUNTIME)
	@podman run -d --name worker01 --network kube --privileged --hostname worker01 -v ./ssh:/root/.ssh $(RUNTIME)

clean:
	@podman rm -f master01 || true
	@podman rm -f master02 || true
	@podman rm -f master03 || true
	@podman rm -f worker01 || true
	@podman rm -f ansible || true
	@podman network rm kube || true

test:
	@./host.sh
	@podman exec -it ansible apt install git make -y
	@podman exec -it ansible git clone https://github.com/buxiaomo/kube-ansible.git /usr/local/src/kube-ansible
	@podman cp all.yml ansible:/usr/local/src/kube-ansible/group_vars/all.yml
	@podman cp hosts ansible:/usr/local/src/kube-ansible/inventory/hosts
	@podman exec -it -w /usr/local/src/kube-ansible ansible make