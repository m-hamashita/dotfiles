local M = {}

function M.config()
    vim.keymap.set("n", ",", "<Plug>(caw:hatpos:toggle)")
    vim.keymap.set("v", ",", "<Plug>(caw:hatpos:toggle)")
end

return M
