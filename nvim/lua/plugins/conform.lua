return {
    -- https://github.com/stevearc/conform.nvim
    "stevearc/conform.nvim",
    -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#lazy-loading-with-lazynvim
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
        {
            -- Customize or remove this keymap to your liking
            "<leader>cf",
            function()
                require("conform").format()
            end,
            mode = "",
            desc = "Format Code",
        },
    },
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
        -- Set default options
        default_format_opts = {
            async = false,
            quiet = false,
            timeout_ms = 3000,
            lsp_format = "fallback",
        },
        -- Set up format-on-save
        format_on_save = {},
    },
}
