local function term_nav(dir)
    ---@param self snacks.terminal
    return function(self)
        return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
            vim.cmd.wincmd(dir)
        end)
    end
end

return {
    -- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- Enabled if options are explicitly passed

        bigfile = {},
        explorer = {},
        indent = {},
        input = {},
        notifier = {},
        quickfile = {},
        scope = {},
        terminal = {
            -- Reference: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/util.lua
            win = {
                keys = {
                    nav_h = { "<c-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
                    nav_j = { "<c-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
                    nav_k = { "<c-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
                    nav_l = { "<c-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
                },
            }
        },
    },

    config = function(_, opts)
        require('snacks').setup(opts)
        vim.g.snacks_animate = false

        -- Reference: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
        vim.keymap.set("n", "<leader>tw", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
        vim.keymap.set("n", "<leader>tW", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end,
            { desc = "Terminal (Root Dir)" })
        vim.keymap.set("n", "<c-/>", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end,
            { desc = "Terminal (Root Dir)" })
        vim.keymap.set("n", "<c-_>", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end,
            { desc = "Terminal (Root Dir)" })
        vim.keymap.set("t", "<c-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
        vim.keymap.set("t", "<c-_>", "<cmd>close<cr>", { desc = "Hide Terminal" })
    end,

    -- Default keymaps: https://github.com/folke/snacks.nvim/blob/main/docs/picker.md#%EF%B8%8F-config
    keys = {
        -- Reference:
        --   - https://github.com/folke/snacks.nvim?tab=readme-ov-file#-usage
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
        { "<leader>e",  "<leader>fe",                      desc = "Explorer Snacks (root dir)", remap = true },
        { "<leader>E",  "<leader>fE",                      desc = "Explorer Snacks (cwd)",      remap = true },
        { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse",                 mode = { "n", "v" } },
        { "<leader>gg", function() Snacks.lazygit() end,   desc = "Lazygit" },
        { "<C-g>",      "<leader>gg",                      desc = "Lazygit",                    remap = true },
    },
}
