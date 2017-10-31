Config_vim()
{
    if [ ${enable_config_vim} == 'n' ]; then
        return
    fi
    
    yum install -y ctags
    cd ${cur_dir}/other
    # 编译安装vim
    if [ ! -s "${cur_dir}/other/vim-8.0.1234.tar.gz" ]; then
        wget -c "https://github.com/vim/vim/archive/v8.0.1234.tar.gz"
        mv v8.0.1234.tar.gz vim-8.0.1234.tar.gz
    fi
    tar zxf vim-8.0.1234.tar.gz
    cd vim-8.0.1234
    ./configure --with-features=huge --enable-gnome-check --enable-gtk3-check  --enable-multibyte --enable-pythoninerp --enable-python3interp --enable-cscope
    make && make install
    ln -sf /usr/local/bin/vim /usr/bin/vim
    cd ../
    rm -rf vim-8.0.1234

    cat > /root/.vimrc<<EOF

" 高亮当前行
set cuc
" 高亮当前列
set cul
" 显示行号
set number
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 用空格代替制表符
set expandtab
" 去掉vi一致性模式
set nocompatible
" 避免退格键无法删除的问题
set backspace=indent,eol,start
" 设置命令行高度为2，默认为1
set cmdheight=2
" 总是显示状态行
set laststatus=2
" 覆盖文件时不备份
set nobackup
" 去掉输入错误时候的提示音
set noeb
" 设置自动缩进
set autoindent
set cindent
" 自动保存
set autowrite
" 搜索忽略大小写, 但是有大写字母时仍敏感
set ignorecase
set smartcase
" 高亮匹配的括号
set showmatch
" 设置上下行可视行数
set scrolloff=3
" 自动切换当前目录为文件所在目录
set autochdir
"
set nolist
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

" 设置<F2>快捷键去除尾部空格
nnoremap <F2> :%s/\s\+$//g<cr>
" 设置<F3>快捷键退出
nmap <F3> :q<cr>
" 设置<F4>快捷键保存
nmap <F4> :w<cr>

filetype plugin indent on
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
"Bundle 'valloric/youcompleteme'
Bundle 'tomasr/molokai'
Bundle 'brantb/vim-colors-solarized'
Bundle 'kien/ctrlp.vim'
Bundle 'lokaltog/vim-powerline'

" Nerd tree
let NERDTreeWinSize=25
let NERDTreeIgnore=['\~$','\.pyc$', '\.swp$']
autocmd vimenter * if !argc() | NERDTree | endif
nmap  <F5> :NERDTreeToggle<cr>

" Tagbar
let g:tagbar_width=25
let g:tagbar_autofocus=1
nmap <F6> :TagbarToggle<cr>

" YouCompleteMe
" let g:ycm_autoclose_preview_window_after_completion=1
" nnoremap <leader>g :YcmCompleter GoToDefinitionElesDeclaration<cr>

syntax on
let g:solarized_termtrans=1
set t_Co=256
set background=dark
colorscheme solarized

" syntax on
" set t_Co=256
" colorscheme molokai
EOF
    mkdir -p /root/.vim/bundle
    bundle_dir=/root/.vim/bundle
    cd ${bundle_dir}
    if [ ! -d ${bundle_dir}/vundle ]; then
        git clone 'https://github.com/gmarik/vundle'
    fi
    if [ ! -d ${bundle_dir}/nerdtree ]; then
        git clone 'https://github.com/scrooloose/nerdtree'
    fi
    if [ ! -d ${bundle_dir}/tagbar ]; then
        git clone 'https://github.com/majutsushi/tagbar'
    fi
    if [ ! -d ${bundle_dir}/molokai ]; then
        git clone 'https://github.com/tomasr/molokai'
    fi
    if [ ! -d ${bundle_dir}/vim-colors-solarized ]; then
        git clone 'https://github.com/brantb/vim-colors-solarized'
    fi
    if [ ! -d ${bundle_dir}/ctrlp.vim ]; then
        git clone 'https://github.com/kien/ctrlp.vim'
    fi
    if [ ! -d ${bundle_dir}/vim-powerline ]; then
        git clone 'https://github.com/lokaltog/vim-powerline'
    fi
}
