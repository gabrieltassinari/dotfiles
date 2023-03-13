call plug#begin()

Plug 'alvan/vim-closetag'
Plug 'lepture/vim-jinja'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set number
set relativenumber

syntax on
colorscheme molokai

hi Pmenu ctermbg=gray ctermfg=black
hi PmenuSel ctermbg=lightgray ctermfg=black
