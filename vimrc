set nocompatible
filetype off                  " required
let mapleader=","
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'easymotion/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'VundleVim/Vundle.vim'

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
nnoremap <left> <<
nnoremap <right> >>

" Quickly edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap ; :

" Don't make .swp files
set nobackup
set noswapfile

filetype plugin indent on
if has('autocmd')
  augroup filetype_ruby
    autocmd!
    autocmd Filetype ruby set autoindent
  augroup end
  augroup filetype_vim
    autocmd!
    " Source the vimrc when it is saved
    autocmd BufWritePost $MYVIMRC :source $MYVIMRC |
                                \ :AirlineRefresh
  augroup end
endif

set statusline=%f         " Path to the file
set statusline+=\ -\      " Separator
set statusline+=FileType: " Label
set statusline+=%y        " Filetype of the file
set laststatus=2


nnoremap <leader>o :NERDTreeToggle<CR>

" Folding Options
set foldmethod=indent
set foldlevelstart=1

" Space to toggle fold open/close
nnoremap <space> za

" 256 Color support
set t_Co=256

" Set bg color of folds to black
highlight Folded ctermbg=16

