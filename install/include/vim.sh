Config_vim()
{
    if [ ${enable_config_vim} == 'n' ]; then
        return
    fi
    cat > /root/.vimrc<<EOF
set cuc
set cul
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab 

filetype plugin indent on
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" Bundle 'gmarik/vundle'
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

syntax on
let g:solarized_termtrans=1
set t_Co=256
set background=dark
colorscheme solarized
" colorscheme molokai
EOF
    mkdir -p /root/.vim/bundle
    bundle_dir=/root/.vim/bundle
    cd ${bundle_dir}
    if [ ! -d ${bundle_dir}/vundle ]; then
        git clone 'https://github.com/gmarik/vundle.git'
    fi
    cd ${bundle_dir}
    if [ ! -d ${bundle_dir}/nerdtree ]; then
        git clone 'https://github.com/scrooloose/nerdtree.git'
    fi
    cd ${bundle_dir}
    if [ ! -d ${bundle_dir}/tagbar ]; then
        git clone 'https://github.com/majutsushi/tagbar.git'
    fi
    cd ${bundle_dir}
    if [ ! -d ${bundle_dir}/molokai ]; then
        git clone 'https://github.com/tomasr/molokai.git'
    fi
    cd ${bundle_dir}
    if [ ! -d ${bundle_dir}/vim-colors-solarized ]; then
        git clone 'https://github.com/brantb/vim-colors-solarized.git'
    fi
    cd ${bundle_dir}
    if [ ! -d ${bundle_dir}/ctrlp.vim ]; then
        git clone 'https://github.com/kien/ctrlp.vim.git'
    fi
    cd ${bundle_dir}
    if [ ! -d ${bundle_dir}/vim-powerline ]; then
        git clone 'https://github.com/lokaltog/vim-powerline.git'
    fi
}
