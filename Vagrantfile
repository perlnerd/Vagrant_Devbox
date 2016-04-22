# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.define "centos" do |centos|
    config.vm.box = "puppetlabs/centos-6.6-64-puppet"
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", 1024]
      vb.name = "Centos-Devbox"
    end
    config.vm.provision "shell", path: "bootstrap_centos.sh"
  end

  config.vm.define "ubuntu" do |ubuntu|
    config.vm.box = "hashicorp/precise64"
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", 1024]
      vb.name = "Ubuntu-Devbox"
    end
    config.vm.provision "shell", path: "bootstrap_ubuntu.sh"
  end

    config.vm.hostname = "vigorate-dev"
    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "public_network", type: "dhcp"
    config.vm.network "private_network", type: "dhcp"
    #config.vm.network :private_network, ip: "192.168.56.126"
    config.vm.synced_folder "../", "/github"  , type: "nfs"
    config.vm.box_check_update = false
    config.vm.provider "virtualbox" do |vb|
      # Display the VirtualBox GUI when booting the machine
      vb.gui = false
    end
end
