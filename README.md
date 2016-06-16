Vigorate Development Virtual Machine
====================================

### Install:

To use this virtual machine you need the following software installed:
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [Virtual Box](https://www.virtualbox.org/wiki/Downloads)


### Clone this repo to the location of your choice:

`git clone git@github.com:perlnerd/Vagrant_Devbox.git`

### Boot the VM:

`$ cd Vagrant_Devbox`
`$ vagrant up`

### Use the VM:

connect via SSH using vagrant:

`$ vagrant ssh`

### hosts file entries

You will use your local web browser to access development versions of the various web apps you build.

When you create a virtual host on the VM, you will also need to add an entry to your local hosts file pointing that hostname to your VM's IP Address.

Your VM's IP address will be printed in the message at the end of the provision process.  You can also find the VM's IP Address by running `ifconfig eth1' on the VM.

To your `/etc/hosts` add:

```
YOUR.VM.IP  os.dev
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

