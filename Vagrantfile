# -*- mode: ruby -*-
# vi: set ft=ruby :
# https://app.vagrantup.com/ubuntu/boxes/focal64

# ssh -i .ssh/id_rsa root@192.168.56.11

VAGRANTFILE_API_VERSION = "2"

cluster = {
  "worker01" => { :ip => "192.168.56.12", :cpus => 4, :mem => 4096 },
  "worker02" => { :ip => "192.168.56.13", :cpus => 4, :mem => 4096 },
  "master01" => { :ip => "192.168.56.11", :cpus => 4, :mem => 4096 },
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  cluster.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |cfg|
      cfg.vm.provider :virtualbox do |vb, override|
        config.vm.box = "ubuntu/focal64"
        config.vm.box_version = "20230119.0.0"
        override.vm.network :private_network, ip: "#{info[:ip]}"
        override.vm.hostname = hostname
        vb.name = hostname
        vb.customize ["modifyvm", :id, "--memory", info[:mem], "--cpus", info[:cpus], "--hwvirtex", "on"]
      end
      cfg.vm.provision "shell", inline: <<-SHELL
        set -x

        sudo cloud-init status --wait

        sudo mkdir -p ${HOME}/.ssh
        sudo cp /vagrant/.ssh/id_rsa ${HOME}/.ssh/id_rsa
        sudo cp /vagrant/.ssh/id_rsa.pub ${HOME}/.ssh/id_rsa.pub
	      sudo cp /vagrant/.ssh/id_rsa.pub ${HOME}/.ssh/authorized_keys
        sudo chown -R vagrant:vagrant ${HOME}/.ssh

        sudo mkdir -p /root/.ssh
        sudo cp /vagrant/.ssh/id_rsa /root/.ssh/id_rsa
	      sudo cp /vagrant/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub
        sudo cp /vagrant/.ssh/id_rsa.pub /root/.ssh/authorized_keys
        sudo chown -R root:root /root/.ssh

        sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
        sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list

        if [ $(hostname) == 'master01' ];then
          sudo apt-get clean
          sudo apt-get update
          sudo apt-get install make -y
          sudo git config --global --add safe.directory /vagrant
          pushd /vagrant >/dev/null 2>&1
            sudo make runtime
            sudo pip3 install pyOpenSSL --upgrade
            sudo make prepare
            sudo make deploy REGISTRY_URL=http://192.168.56.11:5000 KUBE_NETWORK=calico
            # kubectl get no -o wide
            # kubectl get po -o wide -A
		      popd >/dev/null 2>&1
        fi
      SHELL
    end
  end
end