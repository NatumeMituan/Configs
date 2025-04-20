return {
    -- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- Enabled if options are explicitly passed

        -- https://github.com/folke/snacks.nvim/blob/main/docs/input.md
        input = {},
        -- https://github.com/folke/snacks.nvim/blob/main/docs/explorer.md
        explorer = {},
    },
    -- Default keymaps: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-config
    keys = {
        -- Reference:
        --   - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/snacks_explorer.lua
        {
            "<leader>fe",
            function()
                Snacks.explorer({ cwd = LazyVim.root() })
            end,
            desc = "Explorer Snacks (root dir)",
        },
        {
            "<leader>fE",
            function()
                Snacks.explorer.open()
            end,
            desc = "Explorer Snacks (cwd)",
        },
        { "<leader>e", "<leader>fe", desc = "Explorer Snacks (root dir)", remap = true },
        { "<leader>E", "<leader>fE", desc = "Explorer Snacks (cwd)",      remap = true },
    },
}
