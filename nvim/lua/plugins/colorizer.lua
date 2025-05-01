return {
    -- https://github.com/norcalli/nvim-colorizer.lua
    "norcalli/nvim-colorizer.lua",
    ft = {
        'html', 'css', 'javascript', 'typescript', 'lua', 'yaml', 'toml',
    },
    config = function()
        require 'colorizer'.setup { '*' }
    end,
    keys = {
        { "<leader>uc", "<cmd>ColorizerToggle<cr>", desc = "Toggle Colorizer" },
    }
}
