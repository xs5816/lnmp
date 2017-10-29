Config_vim()
{
    if [ ${enable_config_vim} == 'n' ]; then
        return
    fi
    
    yum install -y ctags
    # 编译安装vim
    if [ ! -s "{$cur_dir}/other/vim-8.0.1234.tar.gz" ]; then
        wget -c "https://github.com/vim/vim/archives/v8.0.1234.tar.gz" -O vim-8.0.1234.tar.gz
    fi
    tar zxf vim-8.0.1234.tar.gz
    cd vim-8.0.1234.tar.gz
    ./configure --with-features=huge --enable-gnome-check --enable-gtk3-check  --enable-multibyte --enable-pythoninerp --enable-python3interp --enable-cscope
    make && make install
    ln -sf /usr/local/bin/vim /usr/bin/vim
    cd ../
    rm -rf vim-8.0.1234

    cat > /root/.vimrc<<EOF
set cuc
set cul
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab 
set nocompatible
set backspace=indent,eol,start

nmape <F3> :q<cr>
nmape <F4> :w<cr>

filetype plugin indent on
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
" Bundle 'valloric/youcompleteme'
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

" solarized主题
syntax on
let g:solarized_termtrans=1
set t_Co=256
set background=dark
colorscheme solarized

" molokai主题
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
