local M = {}

function M.config()
    local lspsaga = require("lspsaga")
    lspsaga.setup({})
    vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>")
    vim.keymap.set("n", "gd", "<Cmd>Lspsaga goto_definition<CR>")
    vim.keymap.set("n", "fd", "<Cmd>Lspsaga finder tyd+ref+imp+def<CR>")
    vim.keymap.set("n", "<leader>r", "<Cmd>Lspsaga rename<CR>")
end

return M
