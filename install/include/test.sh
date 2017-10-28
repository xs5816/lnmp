# 查看iptables允许的tcp列表
iptables -nvL | grep tcp

# 查看监听的端口
netstat -ntupl | grep -E 'nginx|mysqld|php-fpm|redis|memcached'


