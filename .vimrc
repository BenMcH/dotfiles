let mapleader=","
syntax on

set tabstop=2
set shiftwidth=2
set expandtab


set nocompatible

"case insensitive search but only when no capitals
set ignorecase
set smartcase

"save dialog instead of failing to quit
set confirm

set visualbell

"line numbers
set number

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

map <leader>j <esc>0v$yddp

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
