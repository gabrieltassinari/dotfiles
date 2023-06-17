call plug#begin()

Plug 'alvan/vim-closetag'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', {'do': 'GoUpdateBinaries'}
Plug 'Luxed/ayu-vim'

call plug#end()

set encoding=utf-8
set number
set relativenumber
set guicursor=i:block

" Tab indentation
set noexpandtab
set tabstop=8
set shiftwidth=8

" Enable mouse (to scroll works with tmux)
if !has('nvim')
	set ttymouse=xterm2
endif
set mouse=a

syntax on
set background=dark

" Colorscheme/Colors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme ayu
set t_Co=256
set termguicolors

" Shortcuts
map q :quit<CR>
map <C-a> <Nop>
map <C-s> :write<CR>

" Background transparency
hi signcolumn guibg=NONE ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi StatusLine guibg=NONE ctermbg=NONE
