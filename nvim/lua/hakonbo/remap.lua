vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Move lines of code with shift-j shift-k
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep the same value in register when pasting instead of losing it
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Also saving on :W because my left pinky gets stuck
vim.api.nvim_create_user_command("W", "w", {})

-- Same but for (Q)uit being also (q)
vim.api.nvim_create_user_command("Q", "q", {})

-- Making ctrl+c ctrl+v work with WSL to other programs
vim.keymap.set("v", "<C-c>", '"+y', {noremap=true, silent=true})


-- Using leader with hjkl and |- to split panes like tmux
vim.keymap.set('n', '<leader>-', ':split<CR>',  { noremap = true, silent = true, desc = 'Horizontal split' })
vim.keymap.set('n', '<leader>|', ':vsplit<CR>', { noremap = true, silent = true, desc = 'Vertical split' })
vim.keymap.set('n', '<leader>wh', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { desc = 'Move to right window' })
vim.keymap.set('n', '<leader>wq', '<C-w>q', { desc = 'Close window' })

