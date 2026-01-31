if vim.loader then
	vim.loader.enable()
end
vim.lsp.set_log_level("error")

vim.diagnostic.config({
  virtual_lines = true,
})
