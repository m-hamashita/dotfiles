local M = {}

function M.config()
	vim.g["fern#renderer"] = "nerdfont"
	vim.g["fern#default_hidden"] = 1
	vim.g["fern#drawer_width"] = 40
	vim.api.nvim_set_keymap("n", "<space>w", ":<C-u>Fern . -drawer -right -toggle<CR>", {
		noremap = true,
		silent = true,
	})

	vim.cmd([[
        function! s:init_fern() abort
          nmap <silent><buffer><nowait> < <Plug>(fern-action-leave)
          nmap <silent><buffer><nowait> > <Plug>(fern-action-enter)
        endfunction

        augroup fern-custom
          autocmd! *
	      autocmd FileType fern call s:init_fern()
        augroup END

	    augroup glyph-palette
	      autocmd! *
	      autocmd FileType fern call glyph_palette#apply()
	      autocmd FileType nerdtree,startify call glyph_palette#apply()
	    augroup END
    ]])
end

return M
