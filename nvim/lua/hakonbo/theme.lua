-- Setting theme settings:
-- See more here https://github.com/rose-pine/neovim?tab=readme-ov-file#options
require('rose-pine').setup({
    styles = {
        bold = true,
        italic = false --looks super ugly
    }
})
vim.cmd('colorscheme rose-pine')
