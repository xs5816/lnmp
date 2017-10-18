Install_mysql_5_5()
{
    Install_pre_mysql
    Add_run_mysql
    Install_boost

    cd ${cur_dir}/mysql
    if [ ! -s "${cur_dir}/mysql/mysql-5.5.56.tar.gz" ]; then
        wget -c "https://soft.vpser.net/datebase/mysql/mysql-5.5.56.tar.gz"
    fi 
    tar zxf mysql-5.5.56.tar.gz
    cd mysql-5.5.56
    mkdir -p /data/mysql
    cmake . \
    -DCMAKE_INSTALL_PREFIX=/usr/local/mysql-5.5.56 \
    -DMYSQL_DATADIR=/data/mysql \
    -DWITH_BOOST=../boost_1_59_0 \
    -DSYSCONFDIR=/etc \
    -DWITH_INNOBASE_STORAGE_ENGINE=1 \
    -DWITH_PARTITION_STORAGE_ENGINE=1 \
    -DWITH_FEDERATED_STORAGE_ENGINE=1 \
    -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
    -DENABLED_LOCAL_INFILE=1 \
    -DENABLE_DTRACE=0 \
    -DDEFAULT_CHARSET=utf8mb4 \
    -DDEFAULT_COLLATION=utf8mb4_general_ci \
    -DWITH_EMBEDDED_SERVER=1
    #-DWITH_SSL=system \
    #-DWITH_ZLIB=system \
    #-DWITH_LIBWRAP=0
    make
    make install
    cd ../
    rm -rf mysql-5.5.56
    
    cd /usr/local/mysql-5.5.56
    ./scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql-5.5.56 --datadir=/data/mysql
    chown -R mysql:mysql /data/mysql
    chown -R root /usr/local/mysql-5.5.56
    
    cd ${cur_dir}/install/conf
    rm -f /etc/my.cnf
    cp ./my.cnf /etc/my.cnf
    cp /usr/local/mysql-5.5.56/support-files/mysql.server /etc/init.d/mysql
    chmod +x /etc/init.d/mysql
    chkconfig --add mysql
    chkconfig --level 345 mysql on
    service mysql start
    
    Add_iptables_mysql_rule
}

Install_pre_mysql()
{
    yum install -y cmake ncurses ncurses-devel bison python-devel
}

Install_boost()
{
    cd ${cur_dir}/mysql

    if [ ! -s "${cur_dir}/mysql/boost_1_59_0.tar.bz2" ]; then
        wget -c "https://soft.vpser.net/lib/boost/boost_1_59_0.tar.bz2"
    fi
    tar jxf boost_1_59_0.tar.bz2
    cd boost_1_59_0
    ./bootstrap.sh
    ./b2
    ./b2 install
    cd ../
    rm -rf boost_1_59_0
}

Add_run_mysql()
{
    groupadd mysql
    useradd -r -g mysql -s /bin/false mysql
}

Add_iptables_mysql_rule()
{
    if [ -s /sbin/iptables ]; then
        /sbin/iptables -I INPUT -p tcp --dport 3306 -j ACCEPT
        service iptables save
        service iptables restart
        iptables -nvL
    fi
}
