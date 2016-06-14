# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provider "virtualbox" do |vb|
  #    Display the VirtualBox GUI when booting the machine
    vb.gui = false
     # Customize the amount of memory on the VM:
    vb.memory = "1024"
    vb.name = "Ubuntu-Devbox"
  end

  config.vm.provision "shell", path: "bootstrap_ubuntu.sh"
  config.vm.hostname = "ubuntu-dev"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "public_network", type: "dhcp", :public_network => "en0"
  config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder "~/Sites/os", "/OS", owner: "www-data", group: "www-data"
  config.vm.box_check_update = false
end
