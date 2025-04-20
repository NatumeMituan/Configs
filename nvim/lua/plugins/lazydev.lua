return {
    -- https://github.com/folke/lazydev.nvim
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
        library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found

            -- Reference:
            --   - https://www.lazyvim.org/plugins/coding#lazydevnvim
            --   - https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/coding.lua
            { path = "snacks.nvim", words = { "Snacks" } },
            { path = "LazyVim",     words = { "LazyVim" } },
        },
    },
}
