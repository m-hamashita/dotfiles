local M = {}

function M.config()
    vim.g.winresizer_enable = 1
    vim.g.winresizer_start_key = "<C-w>"
    vim.g.winresizer_vert_resize = 1
    vim.g.winresizer_horiz_resize = 1
end

return M
