Install_redis()
{
    cd ${cur_dir}/redis
    if [ ${enable_redis} == 'n' ]; then
        return
    fi
    if [ -d "/usr/local/redis-3.2.6" ]; then
        return
    fi

    if [ ! -s "${cur_dir}/redis/redis-3.2.6.tar.gz" ]; then
        wget -c 'http://download.redis.io/releases/redis-3.2.6.tar.gz'
    fi
    tar zxf redis-3.2.6.tar.gz
    cd redis-3.2.6
    make
    cd src && make install PREFIX=/usr/local/redis-3.2.6
    cd ../
    mkdir -p /usr/local/redis-3.2.6/etc/
    cp redis.conf /usr/local/redis-3.2.6/etc/redis.conf
    sed -i 's#daemonize\sno#daemonize yes#g' /usr/local/redis-3.2.6/etc/redis.conf
    ln -sf /usr/local/redis-3.2.6/bin/redis-server /usr/bin/redis-server
    ln -sf /usr/local/redis-3.2.6/bin/redis-cli  /usr/bin/redis-cli
    /usr/local/redis-3.2.6/bin/redis-server /usr/local/redis-3.2.6/etc/redis.conf
    cd ../
    rm -rf redis-3.2.6
}
