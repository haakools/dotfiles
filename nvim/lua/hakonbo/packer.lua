-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Note to self: 
-- :so
-- :PackerSync
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            require('rose-pine').setup({
                styles = {
                    italic = false
                }
            })
            vim.cmd('colorscheme rose-pine')
        end
    })
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/nvim-treesitter-textobjects')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use { 'mason-org/mason.nvim' }
    use { 'mason-org/mason-lspconfig.nvim' }
    use { 'neovim/nvim-lspconfig' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'L3MON4D3/LuaSnip' }
end)
