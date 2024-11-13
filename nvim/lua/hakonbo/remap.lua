vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- Move lines of code with shift-j shift-k
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep the same value in register when pasting instead of losing it
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Also saving on :W because my left pinky gets stuck
vim.api.nvim_create_user_command("W", "w", {})


-- Making ctrl+c ctrl+v work with WSL to other programs
vim.keymap.set("v", "<C-c>", '"+y', {noremap=true, silent=true})

