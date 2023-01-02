vim.keymap.set("n", "<A-Down>", ":MoveLine(1)<CR>")
vim.keymap.set("n", "<A-Up>", ":MoveLine(-1)<CR>")
vim.keymap.set("v", "<A-Down>", ":MoveBlock(1)<CR>")
vim.keymap.set("v", "<A-Up>", ":MoveBlock(-1)<CR>")

vim.keymap.set("n", "<A-Right>", ":MoveHChar(1)<CR>")
vim.keymap.set("n", "<A-Left>", ":MoveHChar(-1)<CR>")
vim.keymap.set("v", "<A-Right>", ":MoveHBlock(1)<CR>")
vim.keymap.set("v", "<A-Left>", ":MoveHBlock(-1)<CR>")
