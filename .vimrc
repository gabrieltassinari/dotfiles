call plug#begin()

Plug 'davidhalter/jedi-vim'
Plug 'alvan/vim-closetag'
Plug 'lepture/vim-jinja'

call plug#end()

set number
set relativenumber

syntax on
colorscheme molokai

hi Pmenu ctermbg=gray ctermfg=black
hi PmenuSel ctermbg=lightgray ctermfg=black
