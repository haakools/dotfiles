require('mason').setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup({
    ensure_installed = {
        'clangd',        -- C / C++
        'ts_ls',         -- TypeScript (tsserver was renamed)
        'eslint',
        'jsonls',
        'pyright',
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({
                capabilities = capabilities,
            })
        end,
    }
})

-- Autocompletion setup
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>']     = cmp.mapping.select_prev_item(),
        ['<C-n>']     = cmp.mapping.select_next_item(),
        ['<C-c>']     = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
})

-- Attach keymaps when LSP connects to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set('n', 'gd',         vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K',          vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr',         vim.lsp.buf.references, opts)
        vim.keymap.set('n', '[d',         vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', ']d',         vim.diagnostic.goto_next, opts)
    end
})


-- See the diagnotistc window with leader+d
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts)


