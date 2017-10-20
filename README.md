# lnmp
自己定制的环境安装脚本  
测试通过的环境 centos6.9, centos7可能会有些问题  
进入install目录  
```bash
chmod +x install.sh
./install.sh
```

适用于本地测试，不适用于生产环境，参数没有经过调优  
同时运行多个版本的php, 不同版本监听不同的端口  
php5.4 9000端口  
php5.5 9001端口  
php5.6 9002端口  
php7.0 9003端口  

4个版本的php均做成了服务，默认开机启动，对应的命令:  
service php-fpm54 {start|stop|force-quit|restart|reload|status}  
service php-fpm55 {start|stop|force-quit|restart|reload|status}  
service php-fpm56 {start|stop|force-quit|restart|reload|status}  
service php-fpm70 {start|stop|force-quit|restart|reload|status}  

nginx服务命令  
service nginx {start|stop|status|restart|condrestart|try-restart|reload|force-reload|configtest}

mysql服务命令  
service mysql {start|stop|restart|reload|force-reload|status}

此脚本根据以前的写的一些安装文档整理而成，参考了一下lnmp
