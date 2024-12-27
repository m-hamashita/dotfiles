local M = {}

function M.config()
    -- directory to place notes and diaries.
    vim.g.quick_notes_directory = "~/.cache/quick-notes/"
    -- suffix used for diaries
    vim.g.quick_notes_suffix = "md"
end

return M
