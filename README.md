# lnmp
自己定制的环境安装脚本  
测试通过的环境 centos6.9, centos7未测试，可能会有些问题  

```bash
yum install -y screen
screen -S lnmp
chmod +x install.sh
./install.sh

# 查看screen列表
screen -ls
# 这里有screen的id

# 恢复screen
screen -r [screen_id]

# 退出screen
exit
```

主要安装的软件
```
nginx1.12.1
mysql5.5.56
php5.4.22
php5.5.38
php5.6.31
php7.0.23
php_redis扩展
php_memcached扩展
swoole扩展
redis3.2.6
```

适用于本地测试，不适用于生产环境，参数没有经过调优  
同时运行多个版本的php, 不同版本监听不同的端口  
php5.4 9000端口  
php5.5 9001端口  
php5.6 9002端口  
php7.0 9003端口  

> php服务命令 
`service php-fpm54 {start|stop|force-quit|restart|reload|status}`  
`service php-fpm55 {start|stop|force-quit|restart|reload|status}`  
`service php-fpm56 {start|stop|force-quit|restart|reload|status}`  
`service php-fpm70 {start|stop|force-quit|restart|reload|status}`  

> nginx服务命令  
`service nginx {start|stop|status|restart|condrestart|try-restart|reload|force-reload|configtest}`

> mysql服务命令  
`service mysql {start|stop|restart|reload|force-reload|status}`

此脚本根据以前的写的一些安装文档整理而成，参考了一下lnmp
