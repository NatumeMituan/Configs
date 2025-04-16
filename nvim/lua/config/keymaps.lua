 -- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- See `:help mapleader`
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- See `:help vim.keymap.set()`
local map = vim.keymap.set

-- Disable arrow keys
map({ "n", "v", "i" }, "<Left>", "<Nop>")
map({ "n", "v", "i" }, "<Right>", "<Nop>")
map({ "n", "v", "i" }, "<Up>", "<Nop>")
map({ "n", "v", "i" }, "<Down>", "<Nop>")

-- Move line up/down and reindent the line
map("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move line up' })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move line down' })

-- Scroll up/down and center the line
map("n", "<C-u>", "<C-u>zz", { desc = 'Scroll up half screen' })
map("n", "<C-d>", "<C-d>zz", { desc = 'Scroll down halp screen' })
map("n", "<C-b>", "<C-b>zz", { desc = 'Scroll up full screen' })
map("n", "<C-f>", "<C-f>zz", { desc = 'Scroll down full screen' })

-- Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostics
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show Line Diagnostics' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Show Diagnostics List' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
