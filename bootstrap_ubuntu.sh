#!/usr/bin/env bash
DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< 'mysql-server mysql-server/root_password password pass'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password pass'
source /vagrant/config_ubuntu.sh
##
#  configure apt to use rabbitMQ repo  
##  
echo 'deb http://www.rabbitmq.com/debian/ testing main' | sudo tee /etc/apt/sources.list.d/rabbitmq.list
echo 'deb http://packages.erlang-solutions.com/debian precise contrib' | sudo tee /etc/apt/sources.list.d/erlang.list
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
wget -O- http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -

##
# Install required software
##
echo "Installing required software...."
for i in "${SOFTWARE_LIST[@]}"; do
echo "$i"
eval "$i"
done

##
# Create/modify/move config files and necessary directories
##
sudo cp /etc/joe/joerc /home/${SERVER_USERNAME}/.joerc
sudo chown ${SERVER_USERNAME}:${SERVER_USERNAME} /home/${SERVER_USERNAME}/.joerc 
sudo bash -c "echo '-nobackups' >> /home/${SERVER_USERNAME}/.joerc"

#set php error log location in php.ini and touch file.
sudo bash -c "echo 'error_log = ${PHP_ERROR_LOG}' >> ${PHP_INI_FILE}";
sudo touch ${PHP_ERROR_LOG};
sudo chown ${SERVER_USERNAME} ${PHP_ERROR_LOG};

#set php5-fpm listen to a socket
sudo bash -c "cat >> ${PHP_FPM_FILE} <<EOF
listen= /var/run/php5-fpm.sock
listen.owner = www-data
listen.group = www-data
listen.mode = 0660
EOF"

IPADDRESS=$(ip addr | grep 'state UP' -A2 | tail -n5 | head -n1 | awk '{print $2}' | cut -f1 -d'/');

#Configure apparmor to allow you to write to /${SENDBOX_OUTFILES_DIR} with mysql
sudo bash -c "cat > ${APPARMOR_MYSQLD_FILE} <<EOF
  /home/${SERVER_USERNAME}/** r,
  /${SERVER_USERNAME}/** r,
EOF"
#Restart apparmor
sudo service apparmor restart

echo Adding aliases to .bashrc
echo "alias reloadhttpd=\"echo 'Reloading Apache' && sudo cp /github/vagrant-devbox/httpd.conf /etc/httpd/conf/httpd.conf && sudo apachectl restart\""\
 >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc


echo 'Linking /OS to /home/vagrant/Sites/os'
mkdir ~vagrant/Sites && chown vagrant:vagrant ~vagrant/Sites
ln -s /OS ~vagrant/Sites/os

echo "vagrant:vagrant"|sudo chpasswd

sudo service php5-fpm restart;

#sudo rabbitmq-plugins enable rabbitmq_management;
#sudo service rabbitmq-server restart;
#sudo rabbitmqctl add_user vagrant_admin brew4.haloes;
#sudo rabbitmqctl set_user_tags vagrant_admin administrator;
#sudo rabbitmqctl set_permissions -p / vagrant_admin ".*" ".*" ".*";

echo "Copying and activating nginx config"
sudo cp /vagrant/os.nginx /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/os.nginx /etc/nginx/sites-enabled/os.nginx

echo "Enabling query log in mysql"
sudo cp /vagrant/data/my.cnf /etc/mysql/my.cnf
sudo service mysql restart
sudo service nginx restart

mysql -u root -ppass -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY PASSWORD '*196BDEDE2AE4F84CA44C47D54D78478C7E2BD7B7' WITH GRANT OPTION"
cat <<EOF
############################################
Your Virtual Development Machine is
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
u: vagrant_admin
p: brew4.haloes

Edit the local httpd.conf and then run
'reloadhttpd' to install the new config
and restart apache
############################################
EOF
