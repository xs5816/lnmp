Install_pre_php()
{
    Install_libxml2
    Install_libiconv
    Install_libmcrypt
    Install_mhash
    Install_mcrypt
    Install_curl
    Install_other
}

Install_php_54()
{
    # Install_pre_php

    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/php-5.4.22.tar.gz" ]; then 
        wget -c "http://mirrors.sohu.com/php/php-5.4.22.tar.gz"
    fi
    tar zxf php-5.4.22.tar.gz
    cd php-5.4.22
    ./configure --prefix=/usr/local/php54 \
    --with-config-file-path=/usr/local/php54/etc \
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
    --with-png-dir 
    make
    make install
    cp php.ini-development /usr/local/php54/etc/php.ini
    cp /usr/local/php54/etc/php-fpm.conf.default /usr/local/php54/etc/php-fpm.conf
    cp ./sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm54
    chmod +x /etc/init.d/php-fpm54
    chkconfig --add php-fpm54
    chkconfig --level 345 php-fpm54 on
    chkconfig --list | grep php-fpm
    service php-fpm54 start

    cd ../
    rm -rf php-5.4.22 

    php_local=php54
    Install_redis_ext
    Install_memcached_ext
    Install_swoole_ext
}

#安装php5.5 
Install_php_55()
{
    echo 'php5.5'
    # Install_pre_php

    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/php-5.5.38.tar.bz2" ]; then 
        wget -c "http://mirrors.sohu.com/php/php-5.5.38.tar.bz2"
    fi
    tar jxf php-5.5.38.tar.bz2
    cd php-5.5.38
    ./configure --prefix=/usr/local/php55 \
    --with-config-file-path=/usr/local/php55/etc \
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
    --with-png-dir 
    make
    make install
    cp php.ini-development /usr/local/php55/etc/php.ini
    cp /usr/local/php55/etc/php-fpm.conf.default /usr/local/php55/etc/php-fpm.conf
    sed -i "s#9000#9001#g" /usr/local/php55/etc/php-fpm.conf
    cp ./sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm55
    chmod +x /etc/init.d/php-fpm55
    chkconfig --add php-fpm55
    chkconfig --level 345 php-fpm55 on
    chkconfig --list | grep php-fpm
    service php-fpm55 start

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
    echo 'php5.6'
    # Install_pre_php

    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/php-5.6.31.tar.gz" ]; then 
        wget -c "http://mirrors.sohu.com/php/php-5.6.31.tar.gz"
    fi
    tar zxf php-5.6.31.tar.gz
    cd php-5.6.31
    ./configure --prefix=/usr/local/php56 \
    --with-config-file-path=/usr/local/php56/etc \
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
    --with-png-dir 
    make
    make install
    cp php.ini-development /usr/local/php56/etc/php.ini
    cp /usr/local/php56/etc/php-fpm.conf.default /usr/local/php56/etc/php-fpm.conf
    sed -i "s#9000#9002#g" /usr/local/php56/etc/php-fpm.conf
    cp ./sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm56
    chmod +x /etc/init.d/php-fpm56
    chkconfig --add php-fpm56
    chkconfig --level 345 php-fpm56 on
    chkconfig --list | grep php-fpm
    service php-fpm56 start

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
    echo 'php7.0'
    #Install_other

    cd ${cur_dir}/php
    if [ ! -s "${cur_dir}/php/php-7.0.23.tar.gz" ]; then 
        wget -c "http://mirrors.sohu.com/php/php-7.0.23.tar.gz"
    fi
    tar zxf php-7.0.23.tar.gz
    cd php-7.0.23
    ./configure --prefix=/usr/local/php70 \
    --with-config-file-path=/usr/local/php70/etc \
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
    --with-png-dir 
    make
    make install
    cp php.ini-development /usr/local/php70/etc/php.ini
    cp /usr/local/php70/etc/php-fpm.conf.default /usr/local/php70/etc/php-fpm.conf
    cp /usr/local/php70/etc/php-fpm.d/www.conf.default /usr/local/php70/etc/php-fpm.d/www.conf
    sed -i "s#9000#9003#g" /usr/local/php70/etc/php-fpm.d/www.conf
    cp ./sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm70
    chmod +x /etc/init.d/php-fpm70
    chkconfig --add php-fpm70
    chkconfig --level 345 php-fpm70 on
    chkconfig --list | grep php-fpm
    service php-fpm70 start

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
    echo 'redis'
    echo ${php_local}
}

Install_memcached_ext()
{
    echo 'memcached'
    echo ${php_local}
}

Install_swoole_ext()
{
    echo 'swoole'
    echo ${php_local}
}


