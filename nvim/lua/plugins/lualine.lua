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
            globalstatus = true,
        }

        opts.sections.lualine_c = {
            -- Reference: https://www.lazyvim.org/plugins/ui#lualinenvim
            LazyVim.lualine.root_dir(),
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            LazyVim.lualine.pretty_path({ relative = 'root' }),
        }

        -- https://lazy.folke.io/usage
        table.insert(opts.sections.lualine_x, 1, {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = require("catppuccin.palettes").get_palette('macchiato').peach },
        })

        opts.extensions = { 'lazy', 'trouble' }

        return opts
    end,
}
