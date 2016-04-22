Vigorate Development Virtual Machine
====================================

### Install:

To use this virtual machine you need the following software installed:
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
* [Git Bash](https://git-for-windows.github.io/index.html) is also a good idea on a Windows client

### Install Vagrant NFS plugin on your host:

`vagrant plugin install vagrant-winnfsd`

### Clone this repo to the location of your choice:

`git clone git@github.com:vigoratedigitalservices/vagrant-devbox.git`

### Boot the VM:

`$ cd vagrant-devbox`
`$ vagrant up`

### Use the VM:

connect via SSH using vagrant:

`$ vagrant ssh`

### Apache Virtual Host Config

There is a httpd.conf file in the root of the repo.  You can add virtual host entries and any other config changes to this file in your favourite IDE/editor.  Once edited and saved, run `apachereload` on the VM to install the httpd.conf and restart apache.

### hosts file entries

You will use your local web browser to access development versions of the various web apps you build.

When you create a virtual host on the VM, you will also need to add an entry to your local hosts file pointing that hostanme to your VM's IP Address.

Your VM's IP address will be printed in the message at the end of the provision process.  You can also find the VM's IP Address by running `ifconfig eth1' on the VM.

A hosts file `C:\Windows\System32\drivers\etc\hosts` would have an an entry like the following if you created a virtual host on the VM with the `ServerName` `dev.labclosures.dcm10.com` on your VM with the IP Address of `192.168.1.18`

```
192.168.1.18  dev.labclosures.dcm10.com
```

### Extras:

You may want to add the following to your .bashrc (if you are using git bash)

```
alias vup="cd ~/Documents/GitHub/vagrant-devbox && vagrant up && cd -"
alias vssh="cd ~/Documents/GitHub/vagrant-devbox && vagrant ssh && cd -";
alias vdestroy="cd ~/Documents/GitHub/vagrant-devbox && vagrant destroy && cd -";
alias vhalt="cd ~/Documents/GitHub/vagrant-devbox && vagrant halt && cd -";
alias vreboot="cd ~/Documents/GitHub/vagrant-devbox && vagrant reload && cd -";
alias vprovision="cd ~/Documents/GitHub/vagrant-devbox && vagrant provision && cd -";
```

