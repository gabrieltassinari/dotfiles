require('two')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
-- General config
vim.opt.relativenumber = true

-- Mapping

-- Replace increment key due to tmux bind C-a
vim.keymap.set({'n', 'v'}, '<C-b>', '<C-a>')
vim.keymap.set('v', 'g<C-b>', 'g<C-a>')

-- Create a new jupyter cell
vim.keymap.set('n', '<C-s>c', 'o# %%<Esc>', { silent = true })
vim.keymap.set('n', '<C-s>m', 'o# %% [markdown]<Esc>', { silent = true })

-- Disable *{~,.un} files
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.swapfile = false

-- Tab indentation
vim.opt.expandtab = false
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.backspace = { 'indent', 'eol' ,'start' }

-- Colorscheme
vim.cmd.colorscheme('sunbather')
vim.opt.background = 'light'

vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
vim.cmd.highlight({ "signcolumn", "guibg=NONE", "ctermbg=NONE" })
vim.cmd.highlight({ "StatusLine", "guibg=NONE", "ctermbg=NONE" })
