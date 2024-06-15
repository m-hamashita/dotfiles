local M = {}

function M.config()
    vim.opt.list = true
    require("indent_blankline").setup({
        show_current_context = true,
    })
end

return M
