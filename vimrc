set nocompatible
filetype off                  " required
let mapleader=","
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'easymotion/vim-easymotion'

call vundle#end()            " required
filetype plugin indent on    " required


syntax on

set tabstop=2
set shiftwidth=2
set expandtab



"case insensitive search but only when no capitals
set ignorecase
set smartcase

"save dialog instead of failing to quit
set confirm

set visualbell

"line numbers
set number
set relativenumber

"show last command in bottom right
set showcmd

"autocomplete menu
set wildmenu

"only redraw when necessary
set lazyredraw

"highlights the matching parentheses, bracket, or brace
set showmatch

"search as you type and highlight it
set incsearch

nnoremap <leader>j <esc>ddp
nnoremap <leader>k <esc>ddk<s-p>
nmap <up> <leader>k
nmap <down> <leader>j
nmap <right> >>
nmap <left> <<

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>
nnoremap ; :
