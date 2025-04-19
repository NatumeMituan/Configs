return {
    -- https://github.com/catppuccin/nvim
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        -- Reference:
        --   - https://www.lazyvim.org/plugins/colorscheme#catppuccin
        require("catppuccin").setup({
            flavour = "macchiato",
            transparent_background = true,
            custom_highlights = function(cp)
                return {
                    LineNr = { fg = cp.text, bg = cp.surface0 },
                    CursorLineNr = { fg = cp.peach },
                }
            end,
            integrations = {
                mason = true,
                fidget = true,
                native_lsp = {
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                telescope = {
                    enabled = true,
                    style = "nvchad"
                },
                which_key = true
            }
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
