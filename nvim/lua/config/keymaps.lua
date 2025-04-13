-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- See `:help vim.keymap.set()`

-- Disable arrow keys
vim.keymap.set({"n", "v", "i"}, "<Left>", "<Nop>")
vim.keymap.set({"n", "v", "i"}, "<Right>", "<Nop>")
vim.keymap.set({"n", "v", "i"}, "<Up>", "<Nop>")
vim.keymap.set({"n", "v", "i"}, "<Down>", "<Nop>")

-- Move line up/down and reindent the line
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line up' })
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line down' })

-- Scroll up/down and center the line
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Scroll up half screen' })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Scroll down halp screen' })
vim.keymap.set("n", "<C-b>", "<C-b>zz", { desc = 'Scroll up full screen' })
vim.keymap.set("n", "<C-f>", "<C-f>zz", { desc = 'Scroll down full screen' })

--- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })