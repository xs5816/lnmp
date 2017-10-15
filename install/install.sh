#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH

# 检查是否是root用户
if [ $(id -u) != "0" ]; then
	echo "Error: not is root user!"
	exit 1
fi

cur_dir=$(dirname $(pwd))
echo "程序根目录: ${cur_dir}"


. def.conf
. function.sh
. include/nginx.sh
. include/mysql.sh
. include/php.sh
. include/apache.sh
. include/redis.sh
. include/memcached.sh
. include/go.sh
. include/node.sh
. include/sphinx.sh


Init_start
Install_nginx_1_12
Install_mysql_5_5
Install_php_54
Install_php_55
Install_php_56
Install_php_70
