-- See `:help vim.o`

-- Relative line number
vim.o.number = true
vim.o.relativenumber = true

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 5

-- Tab and indent
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true

-- Show whitespaces
vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.opt.listchars:append "trail:•"

-- Hilight the text line of the cursor
vim.o.cursorline = true

-- Sync clipboard between OS and Neovim.
-- See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Indent wrapped lines
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case sensitive only when there's uppercase letters in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250

-- Decrease time to wait for a mapped key sequence to complete
vim.o.timeoutlen = 250

-- Default shell in nvim
-- https://github.com/neovim/neovim/issues/13893#issuecomment-1409668526
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.opt.shell = 'pwsh'
    vim.opt.shellcmdflag = '-nologo -noprofile -ExecutionPolicy RemoteSigned -command'
    vim.opt.shellxquote = ''
end
