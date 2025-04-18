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
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
