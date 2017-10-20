Install_nginx_1_12()
{
    if [ ${enable_nginx} == 'n' ]; then
        return
    fi

    Add_run_user
    Install_pcre_8_39
    Install_zlib
    Install_openssl_1_0

    echo 'Nginx version: 1.12.1'
    cd "${cur_dir}/nginx"

    if [ ! -s "${cur_dir}/nginx/nginx-1.12.1.tar.gz" ]; then
        wget -c "http://mirrors.sohu.com/nginx/nginx-1.12.1.tar.gz" 
        # wget -c "https://soft.vpser.net/web/nginx/nginx-1.12.1.tar.gz"
    fi
    tar zxf nginx-1.12.1.tar.gz
    cd nginx-1.12.1
    ./configure --user=www --group=www --prefix=/usr/local/nginx-1.12.1 --with-http_stub_status_module --with-http_ssl_module --with-http_realip_module --with-openssl=../openssl-1.0.2l
    make
    make install
    cd ../
    rm -rf openssl-1.0.2l
    rm -rf nginx-1.12.1
    nginx_dir=/usr/local/nginx-1.12.1
    ln -sf ${nginx_dir}/sbin/nginx /usr/bin/nginx

    Add_iptables_nginx_rule

    mkdir -p /home/wwwroot
    chown -R www:www /home/wwwroot
    mkdir -p /home/wwwlogs
    chmod 777 /home/wwwlogs
    mkdir -p /home/wwwroot/default
    cat >/home/wwwroot/default/index.html<<EOF
nginx test ok!
EOF

    rm -f ${nginx_dir}/conf/nginx.conf
    cp ../install/conf/nginx.conf ${nginx_dir}/conf/nginx.conf
    sed -i "s#/usr/local/nginx/#${nginx_dir}/#g"  ${nginx_dir}/conf/nginx.conf
    cp ../install/conf/enable-php.conf ${nginx_dir}/conf/enable-php.conf
    cp ../install/conf/enable-php5.4.conf ${nginx_dir}/conf/enable-php5.4.conf
    cp ../install/conf/enable-php5.5.conf ${nginx_dir}/conf/enable-php5.4.conf
    cp ../install/conf/enable-php5.6.conf ${nginx_dir}/conf/enable-php5.6.conf
    cp ../install/conf/enable-php7.0.conf ${nginx_dir}/conf/enable-php7.0.conf
    cp ../install/conf/enable-php-pathinfo.conf ${nginx_dir}/conf/enable-php-pathinfo.conf
    cp ../install/conf/pathinfo.conf ${nginx_dir}/conf/pathinfo.conf
    mkdir -p ${nginx_dir}/conf/vhost
    
    cp ../install/init.d/nginx /etc/init.d/nginx
    sed -i "s#^nginx_dir=.*#nginx_dir=\"${nginx_dir}\"#g" /etc/init.d/nginx
    chmod +x /etc/init.d/nginx
    service nginx start

    chkconfig --add nginx
    chkconfig --level 345 nginx on
}

Install_nginx_1_10()
{
    echo 'Nginx version: 1.10.3'
    cd "${cur_dir}/nginx"

    if [ ! -s "${cur_dir}/nginx/nginx-1.10.3.tar.gz" ]; then
        echo 'nginx 1.10.1'
    fi
}

Install_pcre_8_39()
{
    echo 'Pcre version: 8.39'
    cd "${cur_dir}/nginx"
    if [ ! -s "${cur_dir}/nginx/pcre-8.39.tar.bz2" ]; then
         wget -c "https://soft.vpser.net/web/pcre/pcre-8.39.tar.bz2"
    fi
    tar jxf pcre-8.39.tar.bz2
    cd pcre-8.39
    ./configure
    make
    make install
    if [ -s "/lib/libpcre.so.0.0.1" ]; then
        ln -s /lib/libpcre.so.0.0.1 /lib/libpcre.so.1
    fi
    if [ -s "/lib64/libpcre.so.0.0.1" ]; then
        ln -s /lib64/libpcre.so.0.0.1 /lib64/libpcre.so.1
    fi
    cd ../
    rm -rf pcre-8.39
}

Install_zlib()
{
    echo 'Zlib version: 1.2.11'
    cd "${cur_dir}/nginx"
    if [ ! -s "${cur_dir}/nginx/zlib-1.2.11.tar.gz" ]; then
        wget -c "https://nchc.dl.sourceforge.net/project/libpng/zlib/1.2.11/zlib-1.2.11.tar.gz"
    fi
    tar zxf zlib-1.2.11.tar.gz
    cd zlib-1.2.11
    ./configure
    make
    make install
    cd ../
    rm -rf zlib-1.2.11
}

Install_openssl_1_0()
{
    echo 'Openssl version: 1.0.2'
    cd "${cur_dir}/nginx"
    if [ ! -s "${cur_dir}/nginx/openssl-1.0.2l.tar.gz" ]; then
        wget -c "https://soft.vpser.net/lib/openssl/openssl-1.0.2l.tar.gz"
    fi
    if [ ! -d "${cur_dir}/nginx/openssl-1.0.2l" ]; then 
        tar zxf openssl-1.0.2l.tar.gz
    fi
}


Add_run_user()
{
    groupadd www
    useradd -s /sbin/nologin -g www www
}

Add_iptables_nginx_rule()
{
    if [ -s /sbin/iptables ]; then
        /sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
        service iptables save
        service iptables restart
        iptables -nvL
    fi
}

