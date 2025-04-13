return {
    -- https://github.com/nvim-lualine/lualine.nvim
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'catppuccin',
            component_separators = '|',
            section_separators = ''
        }
    },
    dependencies = {{'nvim-tree/nvim-web-devicons'}}
}
