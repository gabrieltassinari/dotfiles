-- Plugins
vim.pack.add({
  {src = "https://github.com/nvim-treesitter/nvim-treesitter"},
  {src = "https://github.com/gabrieltassinari/vim-sunbather"},
  {src = "https://github.com/nvim-telescope/telescope.nvim"},
  {src = "https://github.com/nvim-lua/plenary.nvim"},
  {src = "https://github.com/neovim/nvim-lspconfig"},
  {src = "https://github.com/hrsh7th/cmp-nvim-lsp"},
  {src = "https://github.com/hrsh7th/cmp-buffer"},
  {src = "https://github.com/hrsh7th/nvim-cmp"},
  {src = "https://github.com/L3MON4D3/LuaSnip"}
})

-- nvim-treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "html", },
  highlight = { enable = true },
  indent = { enable = true },
}

-- nvim-lspconfig
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(e)
    local telescope = require('telescope.builtin')
    local opts = { buffer = e.buf }

    vim.keymap.set("n", 'gI', telescope.lsp_implementations, opts)
    vim.keymap.set("n", 'gd', telescope.lsp_definitions, opts)
    vim.keymap.set("n", 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", 'K', vim.lsp.buf.hover, opts)
  end,
})

vim.lsp.enable({
  "pyright",
  "clangd",
  "gopls",
})

-- nvim-cmp
require('cmp').setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },

  sources = require('cmp').config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }
  }, {
    { name = 'buffer' }
  })
})

-- General config
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

vim.keymap.set("n", 'c,', colorcolumn)
vim.keymap.set("n", 'c.', disable_diagnostic)
vim.keymap.set("n", 'g?', vim.diagnostic.open_float)

-- Replace increment key due to tmux bind C-a
vim.keymap.set({'n', 'v'}, '<C-b>', '<C-a>')
vim.keymap.set('v', 'g<C-b>', 'g<C-a>')

-- telescope.nvim
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep)

-- Disable *{~,.un} files
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.swapfile = false

-- Colorscheme
vim.cmd.colorscheme('sunbather')
vim.opt.background = 'dark'
vim.opt.termguicolors = false

-- Transparency
vim.cmd.highlight({ "Normal", "guibg=NONE", "ctermbg=NONE" })
vim.cmd.highlight({ "signcolumn", "guibg=NONE", "ctermbg=NONE" })
vim.cmd.highlight({ "StatusLine", "guibg=NONE", "ctermbg=NONE" })
