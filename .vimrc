" Replace increment key due to tmux bind C-a
nnoremap <C-b> <C-a>
xnoremap <C-b> <C-a>
xnoremap g<C-b> g<C-a>

" General config
set encoding=utf-8
set number
set wildmenu

" Disable *~ / *.un files
set nobk noudf noswf

" Tab indentation
set sw=8 ts=8 noet
set backspace=indent,eol,start

autocmd Filetype python          set sw=4 ts=4 et
autocmd Filetype haskell         set sw=4 ts=4 et
autocmd Filetype sh              set sw=4 ts=4 noet
autocmd Filetype cpp             set sw=4 ts=4 noet
autocmd Filetype css             set sw=2 ts=2 noet
autocmd Filetype json            set sw=2 ts=2 et
autocmd Filetype html            set sw=2 ts=2 et
autocmd Filetype javascript      set sw=2 ts=2 et
autocmd Filetype typescript      set sw=2 ts=2 et
