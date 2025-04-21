return {
    -- https://github.com/nvim-lualine/lualine.nvim
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function(_, _)
        local lualine = require('lualine')
        local opts = lualine.get_config()

        opts.options = {
            icons_enabled = true,
            theme = 'catppuccin',
            component_separators = '|',
            section_separators = '',
        }

        -- https://lazy.folke.io/usage
        table.insert(opts.sections.lualine_x, 1, {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = require("catppuccin.palettes").get_palette('macchiato').peach },
        })

        return opts
    end,
}
