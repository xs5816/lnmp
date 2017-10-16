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

# 初始化, 安装基本的软件
Init_start

# 安装nginx
Install_nginx_1_12

# 安装mysql
Install_mysql_5_5

# 安装php
Install_pre_php     # 安装php依赖软件
Install_php_54
Install_php_55
Install_php_56
Install_php_70

