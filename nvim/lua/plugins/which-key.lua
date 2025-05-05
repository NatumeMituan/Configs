return {
    -- https://github.com/folke/which-key.nvim
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below

        -- Reference:
        --   - https://www.lazyvim.org/plugins/editor#which-keynvim
        --   - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua
        spec = {
            {
                mode = { 'n', 'v' },
                { "<leader><tab>", group = "tabs" },
                { "<leader>c",     group = "code" },
                { "<leader>f",     group = "file" },
                { "<leader>g",     group = "git" },
                { "<leader>gh",    group = "hunks" },
                { "<leader>s",     group = "search" },
                { "<leader>u",     group = "ui" },
                { "<leader>x",     group = "trouble" },
                { "[",             group = "prev" },
                { "]",             group = "next" },
                { "g",             group = "goto" },
                { "gs",            group = "surround" },
                { "z",             group = "fold" },
                {
                    "<leader>b",
                    group = "buffer",
                    expand = function()
                        return require("which-key.extras").expand.buf()
                    end,
                },
                {
                    "<leader>w",
                    group = "windows",
                    proxy = "<c-w>",
                    expand = function()
                        return require("which-key.extras").expand.win()
                    end,
                },
                -- better descriptions
                { "gx", desc = "Open with system app" },
                { "[b", desc = "Prev Buffer" },
                { "]b", desc = "Next Buffer" },
            }
        }
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
