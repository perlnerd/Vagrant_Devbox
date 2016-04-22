#!/dev/null
###########################################
#
# Modify the settings below to reflect the
# desired file locations and pre-installed
# software.
#
###########################################
SERVER_USERNAME='vagrant'
YUM_CMD='sudo yum -y -q install'

SOFTWARE_LIST=("${YUM_CMD} epel-release"
"${YUM_CMD} joe"
"${YUM_CMD} bind-utils"
"${YUM_CMD} links"
"${YUM_CMD} httpd"
"${YUM_CMD} php"
"${YUM_CMD} php-pear"
"${YUM_CMD} php-gd"
"${YUM_CMD} php-mysql"
"${YUM_CMD} php-soap"
"${YUM_CMD} php-xml"
"${YUM_CMD} ftp"
"${YUM_CMD} git"
"${YUM_CMD} mailx"
"${YUM_CMD} mysql-server"
"${YUM_CMD} screen"
"${YUM_CMD} sqlite"
"${YUM_CMD} unzip"
"${YUM_CMD} wget"
"${YUM_CMD} erlang"
"${YUM_CMD} rabbitmq-server"
"${YUM_CMD} man-pages"
"${YUM_CMD} man"
"${YUM_CMD} gcc"
"${YUM_CMD} php-devel"
"${YUM_CMD} php-pear"
"${YUM_CMD} libssh2"
"${YUM_CMD} libssh2-devel"
);
