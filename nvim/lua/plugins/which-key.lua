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
                { "<leader>c", group = "code" },
                { "<leader>f", group = "file" },
                { "<leader>g", group = "git" },
                { "<leader>s", group = "search" },
                { "[",         group = "prev" },
                { "]",         group = "next" },
                { "g",         group = "goto" },
                { "gs",        group = "surround" },
                { "z",         group = "fold" },
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
