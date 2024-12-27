local M = {}

function M.config()
    vim.keymap.set("n", "<leader>ct", ":<C-u>ConflictMarkerThemselves<CR>")
    vim.keymap.set("n", "<leader>co", ":<C-u>ConflictMarkerOurselves<CR>")
    vim.keymap.set("n", "<leader>cb", ":<C-u>ConflictMarkerBoth<CR>")
end

return M
