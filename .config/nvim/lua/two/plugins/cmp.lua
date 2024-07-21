return {
	'hrsh7th/cmp-nvim-lsp',
  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',
  },
  config = function ()
    local cmp = require('cmp')
    cmp.setup({
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      window = {},
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      })
    })
  end
}
