Install_pre_php()
{
    if [[ ${enable_php54} == 'n'  && ${enable_php55} == 'n' && ${enable_php56} == 'n' && ${enable_php70} == 'n' ]];then
        return
    fi
    Install_libxml2
    Install_libiconv
    Install_libmcrypt
    Install_mhash
    Install_mcrypt
    Install_curl
    Install_re2c
    Install_other
}

Install_php_54()
{
    # Install_pre_php

    if [ ${enable_php54} == 'n' ]; then
        return
    fi
    php_dir=/usr/local/php54
    if [ -d ${php_dir} ]; then
        return
    fi
    service_name=php-fpm54

    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/php-5.4.22.tar.gz" ]; then 
        wget -c "http://mirrors.sohu.com/php/php-5.4.22.tar.gz"
    fi
    tar zxf php-5.4.22.tar.gz
    cd php-5.4.22
    ./configure --prefix=${php_dir} \
    --with-config-file-path=${php_dir}/etc \
    --with-config-file-scan-dir=${php_dir}/etc/conf.d \
    --with-fpm-user=www \
    --with-fpm-group=www \
    --enable-inline-optimization \
    --disable-debug \
    --disable-rpath \
    --enable-shared \
    --enable-opcache \
    --enable-fpm \
    --with-libdir=/usr/lib \
    --with-iconv-dir=/usr/local/libiconv \
    --with-mysql=mysqlnd \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --with-gettext \
    --enable-mbstring \
    --with-iconv \
    --with-mhash \
    --with-openssl \
    --enable-bcmath \
    --enable-soap \
    --with-libxml-dir \
    --enable-pcntl \
    --enable-shmop \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --enable-sockets \
    --with-curl=/usr/local/curl-7.51 \
    --with-gd \
    --with-freetype-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib 
    make
    make install
    ln -sf ${php_dir}/bin/php /usr/bin/php54
    ln -sf /usr/bin/php54 /usr/bin/php
    cp php.ini-development ${php_dir}/etc/php.ini
    cp ${php_dir}/etc/php-fpm.conf.default ${php_dir}/etc/php-fpm.conf
    mkdir -p ${php_dir}/etc/conf.d/
    cp ./sapi/fpm/init.d.php-fpm /etc/init.d/${service_name}
    chmod +x /etc/init.d/${service_name}
    chkconfig --add ${service_name}
    chkconfig --level 345 ${service_name} on
    chkconfig --list | grep php-fpm
    service ${service_name} start

    cd ../
    rm -rf php-5.4.22 

    php_local=php54
    Install_redis_ext
    Install_memcached_ext
    #Install_swoole_ext
}

#安装php5.5 
Install_php_55()
{
    if [ ${enable_php55} == 'n' ]; then
        return
    fi
    php_dir=/usr/local/php55
    if [ -d ${php_dir} ]; then
        return
    fi
    service_name=php-fpm55

    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/php-5.5.38.tar.bz2" ]; then 
        wget -c "http://mirrors.sohu.com/php/php-5.5.38.tar.bz2"
    fi
    tar jxf php-5.5.38.tar.bz2
    cd php-5.5.38
    ./configure --prefix=${php_dir} \
    --with-config-file-path=${php_dir}/etc \
    --with-config-file-scan-dir=${php_dir}/etc/conf.d \
    --with-fpm-user=www \
    --with-fpm-group=www \
    --enable-inline-optimization \
    --disable-debug \
    --disable-rpath \
    --enable-shared \
    --enable-opcache \
    --enable-fpm \
    --with-libdir=/usr/lib \
    --with-iconv-dir=/usr/local/libiconv \
    --with-mysql=mysqlnd \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --with-gettext \
    --enable-mbstring \
    --with-iconv \
    --with-mhash \
    --with-openssl \
    --enable-bcmath \
    --enable-soap \
    --with-libxml-dir \
    --enable-pcntl \
    --enable-shmop \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --enable-sockets \
    --with-curl=/usr/local/curl-7.51 \
    --with-gd \
    --with-freetype-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib 
    make
    make install
    ln -sf ${php_dir}/bin/php /usr/bin/php55
    ln -sf /usr/bin/php55 /usr/bin/php
    cp php.ini-development ${php_dir}/etc/php.ini
    cp ${php_dir}/etc/php-fpm.conf.default ${php_dir}/etc/php-fpm.conf
    sed -i "s#9000#9001#g" ${php_dir}/etc/php-fpm.conf
    mkdir -p ${php_dir}/etc/conf.d/
    cp ./sapi/fpm/init.d.php-fpm /etc/init.d/${service_name}
    chmod +x /etc/init.d/${service_name}
    chkconfig --add ${service_name}
    chkconfig --level 345 ${service_name} on
    chkconfig --list | grep php-fpm
    service ${service_name} start

    cd ../
    rm -rf php-5.5.38 

    php_local=php55
    Install_redis_ext
    Install_memcached_ext
    Install_swoole_ext
}

# 安装php5.6
Install_php_56()
{
    if [ ${enable_php56} == 'y' ]; then
        return
    fi  
    php_dir=/usr/local/php56
    if [ -d ${php_dir} ]; then
        return
    fi
    service_name=php-fpm56
    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/php-5.6.31.tar.gz" ]; then 
        wget -c "http://mirrors.sohu.com/php/php-5.6.31.tar.gz"
    fi
    tar zxf php-5.6.31.tar.gz
    cd php-5.6.31
    ./configure --prefix=${php_dir} \
    --with-config-file-path=${php_dir}/etc \
    --with-config-file-scan-dir=${php_dir}/etc/conf.d \
    --with-fpm-user=www \
    --with-fpm-group=www \
    --enable-inline-optimization \
    --disable-debug \
    --disable-rpath \
    --enable-shared \
    --enable-opcache \
    --enable-fpm \
    --with-libdir=/usr/lib \
    --with-iconv-dir=/usr/local/libiconv \
    --with-mysql=mysqlnd \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --with-gettext \
    --enable-mbstring \
    --with-iconv \
    --with-mhash \
    --with-openssl \
    --enable-bcmath \
    --enable-soap \
    --with-libxml-dir \
    --enable-pcntl \
    --enable-shmop \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --enable-sockets \
    --with-curl=/usr/local/curl-7.51 \
    --with-gd \
    --with-freetype-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib 
    make
    make install
    ln -sf ${php_dir}/bin/php /usr/bin/php56
    ln -sf /usr/bin/php56 /usr/bin/php
    cp php.ini-development ${php_dir}/etc/php.ini
    cp /usr/local/php56/etc/php-fpm.conf.default ${php_dir}/etc/php-fpm.conf
    sed -i "s#9000#9002#g" ${php_dir}/etc/php-fpm.conf
    mkdir -p ${php_dir}/etc/conf.d/
    cp ./sapi/fpm/init.d.php-fpm /etc/init.d/${service_name}
    chmod +x /etc/init.d/${service_name}
    chkconfig --add ${service_name}
    chkconfig --level 345 ${service_name} on
    chkconfig --list | grep php-fpm
    service ${service_name} start

    cd ../
    rm -rf php-5.6.31 

    php_local=php56
    Install_redis_ext
    Install_memcached_ext
    Install_swoole_ext
}

#安装php7.0 
Install_php_70()
{
    if [ ${enable_70} == 'n' ]; then
        return
    fi
    php_dir=/usr/local/php70
    if [ -d ${php_dir} ]; then
        return
    fi
    service_name=php-fpm70
    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/php-7.0.23.tar.gz" ]; then 
        wget -c "http://mirrors.sohu.com/php/php-7.0.23.tar.gz"
    fi
    tar zxf php-7.0.23.tar.gz
    cd php-7.0.23
    ./configure --prefix=${php_dir} \
    --with-config-file-path=${php_dir}/etc \
    --with-config-file-scan-dir=${php_dir}/etc/conf.d \
    --with-fpm-user=www \
    --with-fpm-group=www \
    --enable-inline-optimization \
    --disable-debug \
    --disable-rpath \
    --enable-shared \
    --enable-opcache \
    --enable-fpm \
    --with-libdir=/usr/lib \
    --with-iconv-dir=/usr/local/libiconv \
    --with-mysql=mysqlnd \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --with-gettext \
    --enable-mbstring \
    --with-iconv \
    --with-mhash \
    --with-openssl \
    --enable-bcmath \
    --enable-soap \
    --with-libxml-dir \
    --enable-pcntl \
    --enable-shmop \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --enable-sockets \
    --with-curl=/usr/local/curl-7.51 \
    --with-gd \
    --with-freetype-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-zlib 
    make
    make install
    ln -sf ${php_dir}/bin/php /usr/bin/php70
    ln -sf /usr/bin/php70 /usr/bin/php
    cp php.ini-development ${php_dir}/etc/php.ini
    cp ${php_dir}/etc/php-fpm.conf.default ${php_dir}/etc/php-fpm.conf
    cp ${php_dir}/etc/php-fpm.d/www.conf.default ${php_dir}/etc/php-fpm.d/www.conf
    sed -i "s#9000#9003#g" ${php_dir}/etc/php-fpm.d/www.conf
    mkdir -p ${php_dir}/etc/conf.d/
    cp ./sapi/fpm/init.d.php-fpm /etc/init.d/${service_name}
    chmod +x /etc/init.d/${service_name}
    chkconfig --add ${service_name}
    chkconfig --level 345 ${service_name} on
    chkconfig --list | grep php-fpm
    service ${service_name} start

    cd ../
    rm -rf php-7.0.23 

    php_local=php70
    Install_redis_ext
    Install_memcached_ext
    Install_swoole_ext
}

Install_libxml2()
{
    yum install -y libxml2 libxml2-devel
}

Install_libiconv()
{
    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/libiconv-1.14.tar.gz" ]; then
        wget -c "https://soft.vpser.net/web/libiconv/libiconv-1.14.tar.gz"
    fi
    tar zxf libiconv-1.14.tar.gz
    cd libiconv-1.14
    ./configure --prefix=/usr/local/libiconv --enable-static
    make
    make install
    cd ../
    rm -rf libiconv-1.14
}

Install_libmcrypt()
{
    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/libmcrypt-2.5.8.tar.gz" ]; then
        wget -c "https://soft.vpser.net/web/libmcrypt/libmcrypt-2.5.8.tar.gz"
    fi
    tar zxf libmcrypt-2.5.8.tar.gz
    cd libmcrypt-2.5.8
    ./configure
    make
    make install

    /sbin/ldconfig
    cd libltdl/
    ./configure -enable-ltdl-install
    make
    make install

    ln -sf /usr/local/lib/libmcrypt.la          /usr/lib/libmcrypt.la
    ln -sf /usr/local/lib/libmcrypt.so          /usr/lib/libmcrypt.so
    ln -sf /usr/local/lib/libmcrypt.so.4        /usr/lib/libmcrypt.so.4
    ln -sf /usr/local/lib/libmcrypt.so.4.4.8    /usr/lib/libmcrypt.so.4.4.8
    ldconfig
    cd ../../
    rm -rf libmcrypt-2.5.8
}

Install_mhash()
{
    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/mhash-0.9.9.9.tar.bz2" ]; then
        wget -c "https://soft.vpser.net/web/mhash/mhash-0.9.9.9.tar.bz2"
    fi
    tar jxf mhash-0.9.9.9.tar.bz2
    cd mhash-0.9.9.9
    ./configure
    make
    make install
    ln -sf /usr/local/lib/libmhash.a        /usr/lib/libmhash.a
    ln -sf /usr/local/lib/libmhash.la       /usr/lib/libmhash.la
    ln -sf /usr/local/lib/libmhash.so       /usr/lib/libmhash.so
    ln -sf /usr/local/lib/libmhash.so.2     /usr/lib/libmhash.so.2
    ln -sf /usr/local/lib/libmhash.so.2.0.1 /usr/lib/libmhash.so.2.0.1
    ldconfig
    cd ../
    rm -rf mhash-0.9.9.9
}

Install_mcrypt()
{
    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/mcrypt-2.6.8.tar.gz" ]; then
        wget -c "https://soft.vpser.net/web/mcrypt/mcrypt-2.6.8.tar.gz"
    fi
    tar zxf mcrypt-2.6.8.tar.gz
    cd mcrypt-2.6.8
    ./configure
    make
    make install
    cd ../
    rm -rf mcrypt-2.6.8
}

Install_curl()
{
    cd ${cur_dir}/php
    yum install -y c-ares c-ares-devel
    if [ ! -s "${cur_dir}/php/curl-7.51.0.tar.bz2" ]; then
        wget -c "https://soft.vpser.net/lib/curl/curl-7.51.0.tar.bz2"
    fi
    tar jxf curl-7.51.0.tar.bz2
    cd curl-7.51.0
    ./configure --prefix=/usr/local/curl-7.51 --enable-ares --without-nss --with-ssl
    make
    make install
    cd ../
    rm -rf curl-7.51.0
}

Install_re2c()
{
    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/re2c-0.16.tar.gz" ]; then
        wget -c "https://sourceforge.net/projects/re2c/files/0.16/re2c-0.16.tar.gz"
    fi
    tar zxf re2c-0.16.tar.gz
    cd re2c-0.16
    ./configure
    make
    make install
    cd ../
    rm -rf re2c-0.16
}

Install_other()
{
    yum install -y openssl openssl-devel
    yum install -y autoconf
    yum install -y libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel
    if [ `grep -L '/usr/local/lib'   '/etc/ld.so.conf' ` ]; then
        echo "/usr/local/lib" >> /etc/ld.so.conf
    fi
    ldconfig
}

Install_redis_ext()
{
    if [ ${enable_php_redis} == 'n' ]; then
        return
    fi
    # 版本兼容: 5.4 5.5 5.6 7.0
    cd ${cur_dir}/redis
    if [ ! -s "${cur_dir}/redis/phpredis-3.1.3.zip" ]; then
        wget -c "https://github.com/phpredis/phpredis/archive/3.1.3.zip"
        mv 3.1.3.zip phpredis-3.1.3.zip
    fi
    unzip -q phpredis-3.1.3.zip
    cd phpredis-3.1.3
    ${php_dir}/bin/phpize
    ./configure --with-php-config=${php_dir}/bin/php-config
    make
    make install
    cat >${php_dir}/etc/conf.d/redis_ext.ini<<EOF
extension=redis.so
EOF
    cd ../
    rm -rf phpredis-3.1.3
}

Install_memcached_ext()
{
    if [ ${enable_php_memcached} == 'n' ]; then
        return
    fi
    # 版本兼容: 2.x支持5.2 -5.6  3.x支持7.0-7.1
    cd ${cur_dir}/memcached
    if [ ! -s "${cur_dir}/memcached/libmemcached-1.0.18.tar.gz" ];then
        wget -c "https://launchpad.net/libmemcached/1.0/1.0.18/+download/libmemcached-1.0.18.tar.gz"
    fi
    if [ ! -d '/usr/local/libmemcached-1.0.18' ]; then
        yum install -y cyrus-sasl-devel
        tar zxf libmemcached-1.0.18.tar.gz
        cd libmemcached-1.0.18
        ./configure --prefix=/usr/local/libmemcached-1.0.18 --with-memcached
        make
        make install
        cd ../
        rm -rf libmemcached-1.0.18
    fi

    if [[ "${php_local}" = "php54" || "${php_local}" = "php55" || "${php_local}" = "php56" ]]; then
        if [ ! -s "${cur_dir}/memcached/php-memcached-2.2.0.tar.gz" ]; then
            wget -c "https://github.com/php-memcached-dev/php-memcached/archive/2.2.0.tar.gz"
            mv 2.2.0.tar.gz php-memcached-2.2.0.tar.gz
        fi
        tar zxf php-memcached-2.2.0.tar.gz
        cd php-memcached-2.2.0
        ${php_dir}/bin/phpize
        ./configure --with-php-config=${php_dir}/bin/php-config --with-libmemcached-dir=/usr/local/libmemcached-1.0.18 --enable-memcached
        make
        make install
    cat >${php_dir}/etc/conf.d/memcached_ext.ini<<EOF
extension=memcached.so
EOF
        cd ../
        rm -rf php-memcached-2.2.0
    elif [ "${php_local}" = "php70" ]; then
        if [ ! -s "${cur_dir}/memcached/php-memcached-3.0.2.tar.gz" ]; then
            wget -c "https://github.com/php-memcached-dev/php-memcached/archive/v3.0.2.tar.gz"
            mv v3.0.2.tar.gz php-memcached-3.0.2.tar.gz
        fi
        tar zxf php-memcached-3.0.2.tar.gz
        cd php-memcached-3.0.2
        ${php_dir}/bin/phpize
        ./configure --with-php-config=${php_dir}/bin/php-config --with-libmemcached-dir=/usr/local/libmemcached-1.0.18 --enable-memcached
        make
        make install
    cat >${php_dir}/etc/conf.d/memcached_ext.ini<<EOF
extension=memcached.so
EOF
        cd ../
        rm -rf php-memcached-3.0.2
    fi 
}

Install_swoole_ext()
{
    if [ ${enable_php_swoole} == 'n' ]; then
        return
    fi
    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/swoole-src-2.0.5.tar.gz" ];then
        wget -c "https://github.com/swoole/swoole-src/archive/v2.0.5.tar.gz"
        mv v2.0.5.tar.gz swoole-src-2.0.5.tar.gz 
    fi
    tar zxf swoole-src-2.0.5.tar.gz
    cd swoole-src-2.0.5
    ${php_dir}/bin/phpize
    ./configure --with-php-config=${php_dir}/bin/php-config
    make
    make install
    cat >${php_dir}/etc/conf.d/swoole_ext.ini<<EOF
extension=swoole.so
EOF
    cd ../
    rm -rf swoole-src-2.0.5

}


