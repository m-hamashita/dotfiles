local M = {}

local function split_type()
	local width = vim.api.nvim_win_get_width(0)
	local height = vim.api.nvim_win_get_height(0) * 2.1

	if height > width then
		vim.g.neoterm_size = 10
		return "bel"
	else
		vim.g.neoterm_size = 50
		return "vert"
	end
end

local function open_neoterm(cmd)
	local split = split_type()
	local command = split .. " " .. cmd
	vim.api.nvim_command(command)
end

vim.g.neoterm_autoinsert = 1
vim.g.neoterm_autoscroll = 1
-- vim.g.neoterm_default_mod = "aboveleft"
vim.g.neoterm_default_mod = "vertical"
vim.g.neoterm_size = tostring(0.3 * vim.o.columns)
vim.g.neoterm_split_on_tnew = 1
vim.keymap.set("n", "<space>tt", function()
	open_neoterm("Ttoggle")
end, { noremap = true, silent = true })

vim.keymap.set("t", "<space>tt", function()
	open_neoterm("Ttoggle")
end, { silent = true })

function M.config()
	-- vim.cmd([[
	--
	--        function! NTermInNewTab()
	--            let l:tmp = g:neoterm_default_mod
	--            let g:neoterm_default_mod = "tab"
	--            Tnew
	--            let g:neoterm_default_mod = l:tmp
	--        endfunction
	--
	--        function! NTermCurrentDir()
	--            let l:cmd = "cd " .expand("%:p:h")
	--            call neoterm#exec({ 'cmd': [ cmd , '' ] })
	--            Topen
	--        endfunction
	--
	--        function! NTermHolizontalSplit()
	--            let l:tmp = g:neoterm_default_mod
	--            let g:neoterm_default_mod = "aboveleft"
	--            Tnew
	--            let g:neoterm_default_mod = l:tmp
	--        endfunction
	--
	--        function! NTermVerticalSplit()
	--            let l:tmp = g:neoterm_default_mod
	--            let g:neoterm_default_mod = "vertical"
	--            Tnew
	--            let g:neoterm_default_mod = l:tmp
	--        endfunction
	--
	--        nnoremap <c-t><c-h> :call NTermHolizontalSplit()<CR>
	--        nnoremap <c-t><c-v> :call NTermVerticalSplit()<CR>
	--
	--        command! CMake                call NTermCMake()
	--        command! CatkinMake           call NTermCatkinMake()
	--        command! -nargs=* Python      call NTermPython(<f-args>)
	--        "command! -nargs=* Python      :T python %:p <f-args>
	--        command! TexCompile           call NTermTexCompile()
	--        command! UpdateConfig         call UpdateConfig()
	--        command! -nargs=1 GitPush     call GitPush(<f-args>)
	--        command! -nargs=+ NTermMulti  call NTermMulti(<f-args>)
	--        command! NTermMulti4          call NTermMulti(2,2)
	--        command! NTermMulti6          call NTermMulti(3,2)
	--        command! NTermMulti8          call NTermMulti(4,2)
	--    ]])
end

-- return M
