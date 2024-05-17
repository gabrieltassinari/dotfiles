" vim-plug
call plug#begin()

Plug 'alvan/vim-closetag'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', {'do': 'GoUpdateBinaries'}
Plug 'untitled-ai/jupyter_ascending.vim'
Plug 'Luxed/ayu-vim'
Plug 'gabrieltassinari/vim-sunbather'

call plug#end()

" Mapping
nnoremap <silent>c, :CocDisable<CR>
nnoremap <silent>c. :CocEnable<CR>
map <silent>gd <Plug>(coc-definition)

" Replace increment key due to tmux bind C-a
nnoremap <C-b> <C-a>
xnoremap <C-b> <C-a>
xnoremap g<C-b> g<C-a>

" Create a new jupyter cell
noremap <silent> <C-s>c o# %%<Esc>
noremap <silent> <C-s>m o# %% [markdown]<Esc>

" General config
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

autocmd Filetype python          set sw=4 ts=4 et
autocmd Filetype haskell         set sw=4 ts=4 et
autocmd Filetype sh              set sw=4 ts=4 noet
autocmd Filetype cpp             set sw=4 ts=4 noet
autocmd Filetype css             set sw=2 ts=2 noet
autocmd Filetype json            set sw=2 ts=2 et
autocmd Filetype javascript      set sw=2 ts=2 et
autocmd Filetype typescript      set sw=2 ts=2 et
autocmd Filetype typescriptreact set sw=2 ts=2 et
autocmd Filetype html            set sw=2 ts=2 et

" Enable mouse (to scroll works with tmux)
if !has('nvim')
	set ttymouse=xterm2
endif
set mouse=a

" Colorscheme/Colors
syntax on
set background=dark
"colorscheme ayu
colorscheme sunbather
set t_Co=256

" Background transparency
hi signcolumn guibg=NONE ctermbg=NONE
hi Normal guibg=NONE ctermbg=NONE
"hi StatusLine guibg=NONE ctermbg=NONE

" Coc.nvim extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-pyright']
