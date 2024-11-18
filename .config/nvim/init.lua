vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Plugins
require('two')

-- General config
vim.opt.number = true
vim.opt.relativenumber = false
vim.api.nvim_set_option("clipboard","unnamed")

-- Mapping
local colorcolumn = function()
  if (vim.o.cc == '80') then vim.o.cc = '0' else vim.o.cc = '80' end
end

local disable_diagnostic = function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

vim.keymap.set('n', 'c,', colorcolumn)
vim.keymap.set('n', 'c.', disable_diagnostic)

-- Replace increment key due to tmux bind C-a
vim.keymap.set({'n', 'v'}, '<C-b>', '<C-a>')
vim.keymap.set('v', 'g<C-b>', 'g<C-a>')


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
