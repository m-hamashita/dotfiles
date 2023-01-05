local M = {}

function M.config()
    local status_ok, copilot = pcall(require, "copilot")
    if not status_ok then
        print("hoge")
        return
    end

    local status_c_ok, copilot_cmp = pcall(require, "copilot_cmp")
    if not status_c_ok then
        print("fuga")
        return
    end

    copilot.setup({
        cmp = {
            enabled = true,
        },
    })

    copilot_cmp.setup({
        method = "getCompletionsCycling",
    })
end

return M
