" vim-plug
call plug#begin()

Plug 'alvan/vim-closetag'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', {'do': 'GoUpdateBinaries'}
Plug 'untitled-ai/jupyter_ascending.vim'
Plug 'Luxed/ayu-vim'
Plug 'nikolvs/vim-sunbather'

call plug#end()

set encoding=utf-8
set number
set relativenumber
set guicursor=i:block
set wildmenu

" Remove *~ / *.un files
set nobackup
set noundofile
set noswapfile

" Tab indentation
set noexpandtab
set tabstop=8
set shiftwidth=8
set backspace=indent,eol,start

autocmd Filetype python     set shiftwidth=4 expandtab
autocmd Filetype sh 	    set shiftwidth=4 tabstop=4
autocmd Filetype json       set shiftwidth=4 tabstop=4
autocmd Filetype javascript set shiftwidth=4 tabstop=4
autocmd Filetype typescript set shiftwidth=2 expandtab
autocmd Filetype tsx	    set shiftwidth=2 expandtab
autocmd Filetype html	    set shiftwidth=2 tabstop=2

" Enable mouse (to scroll works with tmux)
if !has('nvim')
	set ttymouse=xterm2
endif
set mouse=a

" Colorscheme/Colors
syntax on
set background=dark

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"colorscheme ayu
colorscheme sunbather
set t_Co=256
set termguicolors

" Background transparency
hi signcolumn guibg=NONE ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE
"hi StatusLine guibg=NONE ctermbg=NONE

" Coc.nvim extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-pyright']
