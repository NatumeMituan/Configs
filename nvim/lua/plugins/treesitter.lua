return {
    -- https://github.com/nvim-treesitter/nvim-treesitter
    -- Windows: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
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
        })
    end
}
