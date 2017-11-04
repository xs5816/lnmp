# lnmp
自己定制的环境安装脚本  
测试通过的环境 centos6.9, centos7未测试，可能会有些问题  

> 安装方法

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

> 主要安装的软件

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

> 说明

php, nginx, mysql服务均默认启动  
适用于本地测试，不适用于生产环境，参数没有经过调优  
同时运行多个版本的php, 不同版本监听不同的端口  
php5.4 9000端口  
php5.5 9001端口  
php5.6 9002端口  
php7.0 9003端口


> php服务命令

```
service php-fpm54 {start|stop|force-quit|restart|reload|status}

service php-fpm55 {start|stop|force-quit|restart|reload|status}

service php-fpm56 {start|stop|force-quit|restart|reload|status}

service php-fpm70 {start|stop|force-quit|restart|reload|status} 

```

> nginx服务命令

```
service nginx {start|stop|status|restart|condrestart|try-restart|reload|force-reload|configtest}
```

> mysql服务命令

```
service mysql {start|stop|restart|reload|force-reload|status}
```

---

### vim配置使用说明

```
<F2>    去除末尾所有的空格
<F3>    退出所有
<F4>    保存
<F5>    打开Nerd Tree插件
<F6>    打开Tagbar插件
<F7>    跳转到下一个窗口
<F8>    跳转到下一个tab页


以下为详细快捷键映射
nnoremap <Leader>q      :q<cr>
nnoremap <Leader>w      :w<cr>
nnoremap <Leader>l      :set list<cr>
nnoremap <Leader>nl     :set nolist<cr>
" <Tab>
nnoremap <Leader>tn     :tabnew<cr>
nnoremap <Leader>tc     :tabc<cr>       " close tab
nnoremap <Leader>to     :tabo<cr>       " close other tab
nnoremap <Leader>ts     :tabs<cr>       " tab list 
nnoremap <Leader>tf     :tabfirst<cr>   " move to first tab
nnoremap <Leader>tn     :tabn<cr>       " move to next tab
nnoremap <Leader>tp     :tabp<cr>       " move to previous tab
nnoremap <Leader>tl     :tablast<cr>    " move to last tab
nnoremap <F8>           :tabn<cr>
" Windows
nnoremap <Leader>sp     :sp<cr>
nnoremap <Leader>vsp    :vsp<cr>
nnoremap <Leader>wl     <C-W>l<cr>      " right
nnoremap <Leader>wh     <C-W>h<cr>      " left 
nnoremap <Leader>wk     <C-W>k<cr>      " up
nnoremap <Leader>wj     <C-W>j<cr>      " down
nnoremap <Leader>wn     <C-W><C-W><cr>  " next window
nnoremap <F7>           <C-W><C-W><cr>
"
" Buffers


" 设置<F2>快捷键去除尾部空格
nnoremap <F2>           :%s/\s\+$//g<cr>
" 设置<F3>快捷键退出
nnoremap <F3>           :qa<cr>
" 设置<F4>快捷键保存
nnoremap <F4>           :w<cr>

Ctrl + p    打开文件搜索
```
---

此脚本根据以前的写的一些安装文档整理而成，参考了一下lnmp
