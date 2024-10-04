vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Plugins
require('two')

-- General config
vim.opt.number = true
vim.opt.relativenumber = false
vim.api.nvim_set_option("clipboard","unnamed")

-- Mapping

-- Column
vim.keymap.set('n', 'c,', '<cmd>set cc=80<cr>')
vim.keymap.set('n', 'c.', '<cmd>set cc=0<cr>')

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

-- Colorscheme
vim.cmd.colorscheme('sunbather')
vim.opt.background = 'dark'
vim.opt.termguicolors = false

vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
vim.cmd.highlight({ "signcolumn", "guibg=NONE", "ctermbg=NONE" })
vim.cmd.highlight({ "StatusLine", "guibg=NONE", "ctermbg=NONE" })
