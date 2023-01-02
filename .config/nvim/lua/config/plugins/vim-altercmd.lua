local M = {}

function M.config()
    vim.cmd([[
        call altercmd#load()
        AlterCommand path Path
        AlterCommand refresh Refresh
        AlterCommand memo Memo
        AlterCommand memofzf MemoFzf
    ]])
end

return M
