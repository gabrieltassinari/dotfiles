local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.clangd.setup{
	capabilities = capabilities,
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" , "arduino" },
}

lspconfig.pyright.setup{
	capabilities = capabilities,
}

lspconfig.tsserver.setup{
	capabilities = capabilities,
}
