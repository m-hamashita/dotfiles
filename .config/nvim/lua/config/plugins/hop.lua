local M = {}

function M.config()
	--- Config
	local hop = require("hop")
	hop.setup({
		keys = "asdfghjkl",
		uppercase_labels = false,
		quit_key = "q",
	})

	--- Mappings
	local directions = require("hop.hint").HintDirection
	local positions = require("hop.hint").HintPosition
	vim.keymap.set({ "n", "v" }, "f", "<Nop>", { remap = true })
	-- f: forward, current line only
	vim.keymap.set({ "n", "v" }, "ff", function()
		hop.hint_char1({
			direction = directions.AFTER_CURSOR,
			current_line_only = true,
		})
	end, { remap = true })

	-- F: backward, current line only
	vim.keymap.set({ "n", "v" }, "fF", function()
		hop.hint_char1({
			direction = directions.BEFORE_CURSOR,
			current_line_only = true,
		})
	end, { remap = true })

	-- j: forward
	vim.keymap.set({ "n", "v" }, "fj", function()
		hop.hint_vertical({
			direction = directions.AFTER_CURSOR,
		})
	end, { remap = true })

	-- k: backward
	vim.keymap.set({ "n", "v" }, "fk", function()
		hop.hint_vertical({
			direction = directions.BEFORE_CURSOR,
		})
	end, { remap = true })

	-- w: forward
	vim.keymap.set({ "n", "v" }, "fw", function()
		hop.hint_words({
			direction = directions.AFTER_CURSOR,
			hint_position = positions.BEGIN,
		})
	end, { remap = true })

	-- b: backward
	vim.keymap.set({ "n", "v" }, "fb", function()
		hop.hint_words({
			direction = directions.BEFORE_CURSOR,
			hint_position = positions.BEGIN,
		})
	end, { remap = true })

	-- e: forward
	vim.keymap.set({ "n", "v" }, "fe", function()
		hop.hint_words({
			direction = directions.AFTER_CURSOR,
			hint_position = positions.END,
		})
	end, { remap = true })

	-- E: backward
	vim.keymap.set({ "n", "v" }, "fE", function()
		hop.hint_words({
			direction = directions.BEFORE_CURSOR,
			hint_position = positions.END,
		})
	end, { remap = true })

	-- s: char2v
	vim.keymap.set({ "n", "v" }, "fs", function()
		hop.hint_char2({
			multi_windows = true,
		})
	end, { remap = true })

	-- p: pattern
	vim.keymap.set({ "n", "v" }, "fp", function()
		hop.hint_patterns({
			multi_windows = true,
		})
	end, { remap = true })
end

return M
