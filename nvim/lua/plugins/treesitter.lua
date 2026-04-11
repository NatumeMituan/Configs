return {
    {
        -- https://github.com/nvim-treesitter/nvim-treesitter
        -- Windows: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "LazyFile", "VeryLazy" },
        -- Reference: https://www.lazyvim.org/plugins/treesitter
        dependencies = { {
            -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
            "nvim-treesitter/nvim-treesitter-textobjects",
            event = "VeryLazy",
        } },
        opts = {
            ensure_installed = { 'c', 'cpp', 'gitcommit', 'go', 'lua', 'markdown', 'python', 'rust', 'vimdoc', 'vim' },
            auto_install = true,
            sync_install = false,
            highlight = {
                enable = true,
                -- Names of language parsers instead of filetypes
                -- `vimdoc` for checkhealth (highlighting `OK` etc)
                -- To check the language of current buffer:
                --   `:lua print(vim.treesitter.get_parser(0):lang())`
                disable = { 'vimdoc' }
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            textobjects = {
                move = {
                    enable = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
                    goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
                },
            },
        },
    },
}
