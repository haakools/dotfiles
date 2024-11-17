-- nvim/after/ftplugin/gdscript.lua
-- See this for configuration 
-- https://www.reddit.com/r/neovim/comments/13ski66/neovim_configuration_for_godot_4_lsp_as_simple_as/

--  Prerequisites
--   - sudo apt install netcat
--   - Configure the Godot4 External Editor Settings as if it was windows
--      Use External Editor: On
--      Exec Path: nvim
--      Exec Flags: --server "\\\\.\\pipe\\godot.pipe" --remote-send "<C-\><C-N>:n {file}<CR>:call cursor({line},{col})<CR>"


local function get_windows_host() 
    -- get local ip address of dns "nameserver" / Windows host
    local handle = io.popen("cat /etc/resolv.conf | grep nameserver | awk '{print $2}'")
    local result = handle:read("*a")
    handle:close()

    -- Remove whitespace/newlines
    return result:gsub("%s+", "") 
end


local port = os.getenv('GDScript_Port') or '6005'
local cmd = {'netcat', '127.0.0.1', port}
local pipe = [[\\.\pipe\godot.pipe]]
local pipe_path = os.getenv('HOME') .. '/godot.pipe'


vim.lsp.start({
    name = 'Godot',
    cmd = cmd,
    root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
    on_attach = function(client, bufnr)
        -- Create pipe file
        os.execute('touch' .. pipe_path)
        vim.api.nvim_command([[echo serverstart(']] .. pipe .. [[')]])


        -- Keymaps for the LSP
        local opts = {noremap=true, silent=true, buffer=bufnr}
        vim.keymap.set('n', 'gk', vim.lsp.buf.definition, opts)
        -- ctrl+k to get on hoved information
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.hover, opts)
        vim.keymap.set('v', '<C-k>', vim.lsp.buf.hover, opts)

    end
})

