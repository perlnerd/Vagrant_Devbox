#!/usr/bin/env bash
source /vagrant/config_ubuntu.sh
##
#  configure apt to use rabbitMQ repo  
##

sudo bash -c "echo 'deb http://ubuntu.ss/vendors binary/' >> /etc/apt/sources.list"

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
  ${SENDBOX_WORK_DIR}/${SENDBOX_OUTFILE_DIR}/** rw,
  ${GREENARROW_WORK_DIR}/${SEND_DATA_DIR}/** rw,
  ${GREENARROW_WORK_DIR}/${SEND_DATA_DIR}/** rw,
  /home/${SERVER_USERNAME}/** r,
  /${SERVER_USERNAME}/** r,
EOF"
#Restart apparmor
sudo service apparmor restart

echo Adding aliases to .bashrc
echo "alias reloadhttpd=\"echo 'Reloading Apache' && sudo cp /github/vagrant-devbox/httpd.conf /etc/httpd/conf/httpd.conf && sudo apachectl restart\""\
 >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc

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
