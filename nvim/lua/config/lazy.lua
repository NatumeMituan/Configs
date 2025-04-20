-- https://lazy.folke.io/installation
-- https://github.com/folke/lazy.nvim

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" },
            { "\nPress any key to exit..." } }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- https://github.com/LazyVim/LazyVim/blob/ec5981dfb1222c3bf246d9bcaa713d5cfa486fbd/lua/lazyvim/util/plugin.lua#L74
local lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }
require("lazy.core.handler.event").mappings.LazyFile = { id = "LazyFile", event = lazy_file_events }

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- `setup` won't be called because there's no `opts`, `config`,
        --   or `import = "lazyvim.plugins"` (which internally set `opts`)
        { "LazyVim/LazyVim" },
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = {
        colorscheme = { "catppuccin", "habamax" }
    },
    -- automatically check for plugin updates
    checker = {
        enabled = true
    },
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                -- "tutor",
                "zipPlugin",
            },
        },
    },
})

-- LazyVim for reference:
-- - https://github.com/LazyVim/LazyVim
-- - https://www.lazyvim.org/configuration/lazy.nvim
-- - https://www.lazyvim.org/configuration/lazy.nvim
