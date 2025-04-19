return {
    -- https://github.com/catppuccin/nvim
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "macchiato",
            integrations = {
                telescope = {
                    enabled = true,
                    style = "nvchad"
                }
            }
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
