call plug#begin()

Plug 'alvan/vim-closetag'
Plug 'lepture/vim-jinja'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', {'do': 'GoUpdateBinaries'}

call plug#end()

set encoding=utf-8
set number
set relativenumber

syntax on
colorscheme molokai

map q :quit<CR>
map <C-s> :write<CR>

hi Pmenu ctermbg=gray ctermfg=black
hi PmenuSel ctermbg=lightgray ctermfg=black
