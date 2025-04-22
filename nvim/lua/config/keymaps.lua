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

-- Windows
-- https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/config/keymaps.lua#L13
-- https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/config/keymaps.lua#L197
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })
-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Tabs
-- https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/config/keymaps.lua#L204
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

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
map('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Show Line Diagnostics' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Show Diagnostics List' })
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
