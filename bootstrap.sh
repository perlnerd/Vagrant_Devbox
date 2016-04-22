#!/usr/bin/env bash
source /vagrant/config.sh

echo "Configuring additional software repos"
echo ' '
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
wget http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
rpm -Uvh erlang-solutions-1.0-1.noarch.rpm

##
# Install required software
##
echo "Installing required packages...."
for i in "${SOFTWARE_LIST[@]}"; do
echo "$i"
eval "$i"
done
echo "Finished installing packages"

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /github/development /var/www
fi
echo ' '
echo "configuring daemons to start on boot....."
for i in mysqld httpd rabbitmq\-server; do sudo chkconfig --level 234 $i on; done

cp /vagrant/httpd.conf /etc/httpd/conf/httpd.conf
cp /vagrant/php.ini /etc/php.ini
cp /vagrant/hosts /etc/hosts

# build new ssh2 module for php
pecl install -f ssh2
echo extension=ssh2.so > /etc/php.d/ssh2.ini

init 3
echo 'Waiting for daemons to start.....'
sleep 10
rabbitmq-plugins enable rabbitmq_management;
rabbitmqctl add_user vigorate_admin brew4.haloes;
rabbitmqctl set_user_tags vigorate_admin administrator;
rabbitmqctl set_permissions -p / vigorate_admin ".*" ".*" ".*";

echo 'Opening port 80 in ip_tables'
sudo iptables -I INPUT 5 -p tcp -m tcp --dport 80 -j ACCEPT
echo 'Opening port 15672 for RabbitMQ GUI'
sudo iptables -I INPUT 5 -p tcp -m tcp --dport 15672 -j ACCEPT
sudo /etc/init.d/iptables save

IPADDRESS=$(ip addr | grep 'state UP' -A2 | tail -n5 | head -n1 | awk '{print $2}' | cut -f1 -d'/');

echo Adding aliases to .bashrc
echo "alias reloadhttpd=\"echo 'Reloading Apache' && sudo cp /github/vagrant-devbox/httpd.conf /etc/httpd/conf/httpd.conf && sudo apachectl restart\""\
 >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc

echo Adding .gnupg
cp -Rp /vagrant/dot_gnupg /home/vagrant/.gnupg

echo 'Linking /github to /home/vagrant/github'
ln -s /github /home/vagrant/github

echo "vagrant:vagrant"|sudo chpasswd

cat <<EOF
############################################
Your Vigorate Virtual Development Machine is
now configured.

The VM's IP address is ${IPADDRESS}

Enter 'vagrant ssh' at the command prompt
to connect via ssh.

To connect to the default website via http
point you browser at:
http://localhost:8080/

See /etc/httpd/conf/httpd.conf for example
Virtual Host entries.

RabbitMQ GUI is at http://${IPADDRESS}:15672
u: vigorate_admin
p: brew4.haloes

Edit the local httpd.conf and then run
'reloadhttpd' to install the new config
and restart apache
############################################
EOF
