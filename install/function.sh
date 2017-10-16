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
}