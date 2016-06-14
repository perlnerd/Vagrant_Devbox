#!/dev/null
###########################################
#
# Modify the settings below to reflect the 
# desired file locations and pre-installed 
# software.
#
###########################################
SERVER_USERNAME='vagrant'

PHP_ERROR_LOG='/var/log/php_errors.log'
PHP_INI_FILE='/etc/php5/cli/php.ini'
PHP_FPM_FILE='/etc/php5/fpm/pool.d/www.conf'
MYSQL_USER='mysql'
NGINX_USER='www-data'
NGINX_PORT='80'
NGINX_ROOT='/opt/sendbox'
NGINX_SITES_AVAILABLE="/etc/nginx/sites-available"
NGINX_SITES_ENABLED="/etc/nginx/sites-enabled"
NGINX_EXPORTS="${NGINX_ROOT}/www/exports"
NGINX_DEFAULT_CONFIG="$NGINX_SITES_AVAILABLE/default"
NGINX_NEW_CONFIG_FILE='/vagrant/data/default.nginx'
APPARMOR_MYSQLD_FILE='/etc/apparmor.d/local/usr.sbin.mysqld'
RABBITMQADMIN="/vagrant/data/rabbitmqadmin"
RABBITMQADMIN_CP_TO="/usr/local/bin/rabbitmqadmin"
SERVER_USERNAME='vagrant'

#variable containing software to be installed using apt-get
SOFTWARE_LIST=( "apt-get -qq update" 
"apt-get -qq -y install mysql-server" 
"apt-get -qq -y install mysql-client" 
"apt-get install -qq -y php5-cli" 
"apt-get install -qq -y php5-mysql"
"apt-get install -qq -y joe" 
"apt-get install -qq -y vim" 
"apt-get install -qq -y sqlite3" 
"apt-get install -qq -y php5-sqlite" 
"apt-get install -qq -y php5-fpm"
"apt-get install -qq -y php5-cgi"
"apt-get install -qq -y screen"
"apt-get install -qq -y nginx"
#"apt-get install -qq -y erlang"
#"apt-get install -qq -y erlang-nox"
#"apt-get install -qq -y --force-yes rabbitmq-server"
"apt-get install -qq -y curl"
"apt-get install -qq -y links"
"apt-get install -qq -y php5-curl"
"apt-get install -qq -y php5-imap"
"apt-get install -y memcached"
"apt-get install -y php5-memcached"
);

####################################################################################
#
# End of config
#
####################################################################################