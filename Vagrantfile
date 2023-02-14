# -*- mode: ruby -*-
# vi: set ft=ruby :

# ssh -i .ssh/id_rsa root@192.168.56.10

# Set the .env file and install the necessary plug-ins
# $ vagrant plugin install vagrant-env
# $ cat .env
# BOX=buxiaomo/fedora
# BOX_VERSION=36.0.20230214
# KUBE_VERSION=1.24.10
# KUBE_NETWORK=calico

VAGRANTFILE_API_VERSION = "2"

cluster = {
  "worker01" => { :ip => "192.168.56.11", :cpus => 4, :mem => 4096 },
  "worker02" => { :ip => "192.168.56.12", :cpus => 4, :mem => 4096 },
  "master01" => { :ip => "192.168.56.10", :cpus => 4, :mem => 4096 },
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.env.enable
  cluster.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |cfg|
      cfg.vm.provider :virtualbox do |vb, override|
        config.vm.box = ENV['BOX']
        config.vm.box_version = ENV['BOX_VERSION']
        override.vm.network :private_network, ip: "#{info[:ip]}"
        override.vm.hostname = hostname
        vb.name = hostname
        vb.cpus = info[:cpus]
        vb.memory = info[:mem]
      end
      cfg.vm.provision "shell" do |s|
        s.path = "./tests/prepare.sh"
        s.args = [ ENV['KUBE_VERSION'], ENV['KUBE_NETWORK'], "vagrant" ]
      end
    end
  end
end