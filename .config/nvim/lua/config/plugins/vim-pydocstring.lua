-- うまくいってないかも
local M = {}

function M.config()
    vim.g.pydocstring_formatter = "google"
    vim.keymap.set("n", "<leader>pd", "<Plug>(pydocstring)")
end

return M
