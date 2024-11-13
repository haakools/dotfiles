
local lsp = require('lsp-zero')

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	-- Replace the language servers listed here 
	-- with the ones you want to install
	ensure_installed = {
		'clangd', --C / C++
		'tsserver', --Typescript
		'eslint', -- 
		'jsonls', --json
		'pyright', --python
        'pylsp'
	},
	handlers = {
		lsp_zero.default_setup,
	},
})


lsp.preset('recommend')
lsp.setup()

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-c>'] = cmp.mapping.confirm({select = true}),
	['<C-space>'] = cmp.mapping.complete(cmp_select)
})

lsp.set_preferences({
	sign_icons = { }
})



