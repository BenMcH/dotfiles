set nocompatible
filetype off                  " required
let mapleader=","
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'skwp/vim-rspec'
Plugin 'tpope/vim-sensible'
Plugin 'kchmck/vim-coffee-script'
Plugin 'chrisbra/Colorizer'
Plugin 'ervandew/supertab'
Plugin 'suan/vim-instant-markdown'
Plugin 'rosenfeld/rgrep.vim'
Plugin 'takac/vim-hardtime'


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

let g:netrw_banner=0

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

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
nmap <up> <nop>
nmap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Force vim to redraw if iterm/tmux clears the screen
nnoremap <c-i> :redraw!<cr>

" Quickly edit the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap ; :
nnoremap : :

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
  augroup spaces  
    autocmd!
    autocmd BufWritePre * %s/\s\+$//e
  augroup END  
endif

set statusline=%f         " Path to the file
set statusline+=\ -\      " Separator
set statusline+=FileType: " Label
set statusline+=%y        " Filetype of the file
set laststatus=2

set background=dark


" Folding Options
set foldmethod=indent
set foldlevelstart=1

" Space to toggle fold open/close
nnoremap <space> za

" 256 Color support

set t_Co=256
" Set bg color of folds to black
highlight Folded ctermbg=16

let g:user_emmet_leader_key='<C-Z>'

set hidden


nnoremap <leader>- :vertical resize -5<cr>
nnoremap <leader>+ :vertical resize +5<cr>
nnoremap <leader>0 :vertical resize 25<cr>
nnoremap <leader>o :Lexplore<CR>:vertical resize 25<cr>

nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <leader>l :set invnumber invrelativenumber<cr>


nnoremap <leader>model :-1read $HOME/.vim/.skeleton.model.rb<cr>ea<space>
nnoremap <leader>cont :-1read $HOME/.vim/.skeleton.controller.rb<cr>ela

set cursorline

" This line sets up rgrep 
set grepprg=grep\ -nrI\ --exclude-dir=target\ --exclude-dir=tmp\ --exclude-dir=log\ --exclude="*.min.js"\ --exclude="*.log"\ $*\ /dev/null

" Setting up Vim Hardtime
let g:hardtime_maxcount = 2
let g:hardtime_allow_different_key = 1
let g:hardtime_showmsg = 1
let g:hardtime_default_on = 1

