# 初始化, 创建目录
Init_start()
{
    yum install -y ntp
    ntpdate -u pool.ntp.org

    yum install -y git gcc gcc-c++ vim wget man zip unzip bison

    if [ ! -d "${cur_dir}/nginx" ]; then
        mkdir -p "${cur_dir}/nginx"
    fi
    if [ ! -d "${cur_dir}/php" ]; then
        mkdir -p "${cur_dir}/php"
    fi 
    if [ ! -d "${cur_dir}/mysql" ]; then
        mkdir -p "${cur_dir}/mysql"
    fi
    if [ ! -d "${cur_dir}/apache" ]; then
        mkdir -p "${cur_dir}/apache"
    fi
    if [ ! -d "${cur_dir}/redis" ]; then
        mkdir -p "${cur_dir}/redis"
    fi
    if [ ! -d "${cur_dir}/memcached" ]; then
        mkdir -p "${cur_dir}/memcached"
    fi
    if [ ! -d "${cur_dir}/node" ]; then
        mkdir -p "${cur_dir}/node"
    fi
    if [ ! -d "${cur_dir}/golang" ]; then
        mkdir -p "${cur_dir}/golang"
    fi
    
    Install_jemalloc
}

# 安装jemalloc
Install_jemalloc()
{
    cd ${cur_dir}/other
    if [ ! -s "${cur_dir}/other/jemalloc-4.5.0.tar.bz2" ]; then
        wget -c https://github.com/jemalloc/jemalloc/releases/download/4.5.0/jemalloc-4.5.0.tar.bz2
    fi
    tar jxf jemalloc-4.5.0.tar.bz2
    cd jemalloc-4.5.0
    ./configure
    make
    make install
    ldconfig
    cd ../
    rm -rf jemalloc-4.5.0
}