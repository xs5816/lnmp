Config_vim()
{
    if [ ${enable_config_vim} == 'n' ]; then
        return
    fi
    
    yum install -y ctags
    cd ${cur_dir}/other
    vim_version='vim-8.0.1234'
    # 编译安装vim
    if [ ! -s "${cur_dir}/other/${vim_version}.tar.gz" ]; then
        wget -c "https://github.com/vim/vim/archive/v8.0.1234.tar.gz"
        mv v8.0.1234.tar.gz ${vim_version}.tar.gz
    fi
    tar zxf ${vim_version}.tar.gz
    cd ${vim_version}
    ./configure --with-features=huge \
    --enable-gnome-check \
    --enable-gtk3-check  \
    --enable-multibyte \
    --enable-pythoninerp \
    --enable-python3interp \
    --enable-cscope
    make && make install
    ln -sf /usr/local/bin/vim /usr/bin/vim
    cd ../
    rm -rf ${vim_version}

    cat > /root/.vimrc<<EOF
" ===================================================
" 设置部分
" ==================================================
" 高亮当前列
set cursorcolumn
" 高亮当前行
set cursorline
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
" 开启实时搜索功能
set incsearch
" 高亮匹配的括号
set showmatch
" 设置搜索结果高亮
set hlsearch
" 设置上下行可视行数
set scrolloff=3
" 自动切换当前目录为文件所在目录
set autochdir
" vim自身命令行模式智能补全
set wildmenu
" 设置空格等字符可见
set nolist
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
" 基于语法进行代码折叠
set foldmethod=syntax
" 启动vim时关闭折叠代码
set nofoldenable

" ===================================================
" 快捷键映射
" ===================================================
let mapleader=";"
nnoremap <Leader>q      :q<cr>
nnoremap <Leader>w      :w<cr>
nnoremap <Leader>l      :set list<cr>
nnoremap <Leader>nl     :set nolist<cr>
" <Tab>
nnoremap <Leader>tn             :tabnew<cr>
nnoremap <Leader>tc             :tabc<cr>       " close tab
nnoremap <Leader>to             :tabo<cr>       " close other tab
nnoremap <Leader>ts             :tabs<cr>       " tab list 
nnoremap <Leader>tf             :tabfirst<cr>   " move to first tab
nnoremap <Leader>tn             :tabn<cr>       " move to next tab
nnoremap <Leader>tp             :tabp<cr>       " move to previous tab
nnoremap <Leader>tl             :tablast<cr>    " move to last tab
nnoremap <F8>                   :tabn<cr>
" Windows
nnoremap <Leader>sp     :sp<cr>
nnoremap <Leader>vsp    :vsp<cr>
nnoremap <Leader>wl             <C-W>l<cr>      " right
nnoremap <Leader>wh             <C-W>h<cr>      " left 
nnoremap <Leader>wk             <C-W>k<cr>      " up
nnoremap <Leader>wj             <C-W>j<cr>      " down
nnoremap <Leader>wn             <C-W><C-W><cr>  " next window
nnoremap <F7>                   <C-W><C-W><cr>
"
" Buffers


nnoremap ,l             :set list<cr>
" 设置<F2>快捷键去除尾部空格
nnoremap <F2>           :%s/\s\+$//g<cr>
" 设置<F3>快捷键退出
nnoremap <F3>           :qa<cr>
" 设置<F4>快捷键保存
nnoremap <F4>           :w<cr>


" ===================================================
" 插件部分
" ===================================================
filetype plugin indent on
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
" 插件管理 
Bundle 'gmarik/vundle'
" 文件浏览插件 
Bundle 'scrooloose/nerdtree'
" 标签方法浏览插件
Bundle 'majutsushi/tagbar'
" 自动补全插件 
"Bundle 'valloric/youcompleteme'
" molokai主题
Bundle 'tomasr/molokai'
" solarized主题
Bundle 'brantb/vim-colors-solarized'
" 文件搜索插件 
Bundle 'kien/ctrlp.vim'
" airline状态栏插件
Bundle 'vim-airline/vim-airline'
" 高亮文档中的颜色代码 
Bundle 'gorodinskiy/vim-coloresque'
call vundle#end()

" Nerd tree
let NERDTreeWinSize=25
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
" 不显示冗余帮助信息
let NERDTreeMinimalUI=1
let NERDTreeIgnore=['\~$','\.pyc$', '\.swp$']
nnoremap  <F5> :NERDTreeToggle<cr>

" Tagbar
let g:tagbar_right=1
let g:tagbar_width=25
let g:tagbar_autofocus=1
" 不显示冗余的帮助信息
let g:tagbar_compact=1
nnoremap <F6> :TagbarToggle<cr>

" YouCompleteMe
" let g:ycm_autoclose_preview_window_after_completion=1
" nnoremap <leader>g :YcmCompleter GoToDefinitionElesDeclaration<cr>

" Ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png,*.jpg,*.jpeg,*.gif
let g:ctrlp_custom_ignore='\v[\/]\.(git|hg|svn)$'

" Airline
"let g:airline#extensions#whitespace#enabled=0
" 打开tabline功能，方便查看buffer和切换
"let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_nr_show=1
" 设置切换buffer的快捷键
nnoremap <Leader>bn     :bn<cr> " next
nnoremap <Leader>bp     :bp<cr> " previous

" 开启语法高亮功能
syntax enable
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
        git clone 'https://github.com/vim-airline/vim-airline'
    fi
    if [ ! -d ${bundle_dir}/vim-coloresque ]; then
        git clone 'https://github.com/gorodinskiy/vim-coloresque'
    fi
}
