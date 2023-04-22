call plug#begin()

Plug 'alvan/vim-closetag'
Plug 'lepture/vim-jinja'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', {'do': 'GoUpdateBinaries'}

call plug#end()

set encoding=utf-8
set number
set relativenumber

set noexpandtab
set tabstop=8
set shiftwidth=8

set ttymouse=xterm2
set mouse=a

syntax on
set background=dark

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme molokai
set t_Co=256
set termguicolors

map q :quit<CR>
map <C-a> <Nop>
map <C-s> :write<CR>

hi Pmenu ctermbg=gray ctermfg=black
hi PmenuSel ctermbg=lightgray ctermfg=black
