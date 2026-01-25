local M = {}

local function get_root_dir()
	local git_dirs = vim.fs.find(".git", { upward = true })
	if git_dirs and git_dirs[1] then
		return vim.fs.dirname(git_dirs[1])
	end

	return vim.loop.cwd()
end

local function should_attach_to_buffer()
	if not vim.bo.buflisted then
		return false
	end

	if vim.bo.buftype ~= "" then
		return false
	end

	return true
end

function M.config()
	require("copilot").setup({
		panel = {
			enabled = true,
			auto_refresh = false,
			keymap = {
				jump_prev = "[[",
				jump_next = "]]",
				accept = "<CR>",
				refresh = "gr",
				open = "<M-CR>",
			},
			layout = {
				position = "bottom",
				ratio = 0.4,
			},
		},
		suggestion = {
			enabled = true,
			auto_trigger = true,
			hide_during_completion = true,
			debounce = 15,
			trigger_on_accept = true,
			keymap = {
				accept = "<Tab>",
				accept_word = false,
				accept_line = false,
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
				toggle_auto_trigger = false,
			},
		},
		nes = {
			enabled = true,
			auto_trigger = true,
			keymap = {
				accept_and_goto = false,
				accept = false,
				dismiss = false,
			},
		},
		auth_provider_url = nil,
		logger = {
			file = vim.fn.stdpath("log") .. "/copilot-lua.log",
			file_log_level = vim.log.levels.OFF,
			print_log_level = vim.log.levels.WARN,
			trace_lsp = "off",
			trace_lsp_progress = false,
			log_lsp_messages = false,
		},
		copilot_node_command = "node",
		workspace_folders = {},
		copilot_model = "",
		disable_limit_reached_message = false,
		root_dir = get_root_dir,
		should_attach = should_attach_to_buffer,
		server = {
			type = "nodejs",
			custom_server_filepath = nil,
		},
		server_opts_overrides = {},
	})
end

return M
